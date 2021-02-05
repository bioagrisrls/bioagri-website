/*
 * MIT License
 *
 * Copyright (c) 2020 BioAgri S.r.l.s.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

package it.bioagri.api.payments;

import it.bioagri.api.ApiResponseStatus;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.api.orders.Orders;
import it.bioagri.models.Order;
import it.bioagri.models.OrderStatus;
import it.bioagri.models.Product;
import it.bioagri.models.ProductStatus;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import it.bioagri.utils.Mail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.Instant;

@RestController
@RequestMapping("/api/payments")
public class Payment {

    private final AuthToken authToken;
    private final DataSource dataSource;
    private final PaymentService paymentService;
    private final Mail mail;

    @Autowired
    public Payment(AuthToken authToken, DataSource dataSource, Mail mail, PaymentService paymentService) {
        this.authToken = authToken;
        this.dataSource = dataSource;
        this.paymentService = paymentService;
        this.mail = mail;
    }



    @PostMapping("create")
    public ResponseEntity<String> create(HttpServletRequest http, @RequestBody PaymentRequest request) {

        try {


            if(!authToken.isLoggedIn())
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();


            try {


                var builder = new Order.Builder()
                        .withId(dataSource.getId("shop_order", Long.class))
                        .withStatus(OrderStatus.PROCESSING)
                        .withResult("")
                        .withPrice(0.)
                        .withShipmentNumber("")
                        .withTransactionId("")
                        .withTransactionType(request.getService())
                        .withAddress("")
                        .withCity("")
                        .withProvince("")
                        .withZip("")
                        .withAdditionalInfo("")
                        .withInvoice("")
                        .withUserId(authToken.getUserId())
                        .withCreatedAt(Timestamp.from(Instant.now()))
                        .withUpdatedAt(Timestamp.from(Instant.now()));

                var order = builder.build();

                dataSource.getOrderDao().save(builder.build());



                for(var i : request.getItems()) {

                    if(i.getValue() <= 0)
                        return ResponseEntity.badRequest().build();


                    var product = dataSource.getProductDao()
                            .findByPrimaryKey(i.getKey())
                            .orElseThrow(() -> new ApiResponseStatus(403));


                    if(product.getStock() < i.getValue())
                        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();


                    product = new Product.Builder(product)
                            .withStock(product.getStock() - i.getValue())
                            .withStatus(product.getStock().equals(i.getValue())
                                    ? ProductStatus.NOT_AVAILABLE
                                    : product.getStatus())
                            .withUpdatedAt(Timestamp.from(Instant.now()))
                            .build();


                    dataSource.getProductDao().update(product, product);
                    dataSource.getOrderDao().addProduct(order, product, i.getValue());

                }


                order = builder
                        .withTransactionId(paymentService.create(dataSource, request))
                        .build();

                dataSource.getOrderDao().update(order, order);


                return ResponseEntity.ok(order.getTransactionId());



            } catch (PaymentServiceFailed e) {
                return ResponseEntity.status(HttpStatus.PAYMENT_REQUIRED).build();
            } catch (PaymentServiceNotFound e) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
            }


        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @PostMapping("authorize")
    public ResponseEntity<String> authorize(HttpServletRequest http, @RequestBody PaymentRequest request) {

        try {


            if(!authToken.isLoggedIn())
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();


            var order = request
                    .getOrder(dataSource)
                    .orElseThrow(() -> new ApiResponseStatus(400));

            var builder = new Order.Builder(order);


            try {

                if(paymentService.authorize(dataSource, request, builder)) {

                    dataSource.getOrderDao().update(order, builder
                            .withStatus(OrderStatus.PENDING)
                            .withUpdatedAt(Timestamp.from(Instant.now()))
                            .build()
                    );


                    var user = dataSource.getUserDao()
                            .findByPrimaryKey(authToken.getUserId())
                            .orElseThrow(() -> new ApiResponseStatus(502));

                    mail.sendUserPayment(http, http.getSession(), user.getId(), user.getMail(), order.getId());


                } else {

                    dataSource.getOrderDao().update(order, builder
                            .withStatus(OrderStatus.ABORTED)
                            .withUpdatedAt(Timestamp.from(Instant.now()))
                            .build()
                    );


                    for(var i : request.getItems()) {


                        var product = dataSource.getProductDao()
                                .findByPrimaryKey(i.getKey())
                                .orElseThrow(() -> new ApiResponseStatus(403));


                        product = new Product.Builder(product)
                                .withStock(product.getStock() + i.getValue())
                                .withStatus(product.getStock().equals(0)
                                        ? ProductStatus.AVAILABLE
                                        : product.getStatus())
                                .withUpdatedAt(Timestamp.from(Instant.now()))
                                .build();


                        dataSource.getProductDao().update(product, product);

                    }

                    return ResponseEntity.status(HttpStatus.PAYMENT_REQUIRED).build();

                }


            } catch (PaymentServiceNotFound e) {
                return ResponseEntity.status(HttpStatus.PAYMENT_REQUIRED).build();
            }


        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.ok().build();

    }


}

