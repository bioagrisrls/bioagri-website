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
import it.bioagri.models.Order;
import it.bioagri.models.OrderStatus;
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

            try {

                return paymentService.create(dataSource, request, shi);

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


//            if(request.getOrder(dataSource).isEmpty()) {
//
//                var order = new Order(
//                        dataSource.getId("shop_order", Long.class),
//                        OrderStatus.PROCESSING,
//                        Timestamp.from(Instant.now()),
//                        Timestamp.from(Instant.now()),
//                        authToken.getUserId(),
//                        null,
//                        null
//                );
//
//                dataSource.getOrderDao().save(order);
//
//                for(var i : request.getItems())
//                    dataSource.getOrderDao().addProduct(
//                            order,
//                            dataSource.getProductDao()
//                                    .findByPrimaryKey(i.getKey())
//                                    .orElseThrow(() -> new ApiResponseStatus(400)),
//                            i.getValue()
//                    );
//
//                request.setOrderId(order.getId());
//
//            }


            try {

                var transaction = paymentService.authorize(dataSource, request);

                // TODO: Transaction failed.
                // TODO: Transaction success.

            } catch (PaymentServiceNotFound e) {
                return ResponseEntity.status(HttpStatus.PAYMENT_REQUIRED).build();
            }



            var user = dataSource.getUserDao()
                    .findByPrimaryKey(authToken.getUserId())
                    .orElseThrow(() -> new ApiResponseStatus(502));

            mail.sendUserPayment(http, http.getSession(), user.getId(), user.getMail(), request.getOrderId());

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.ok().build();

    }


}

