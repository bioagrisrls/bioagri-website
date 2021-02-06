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

package it.bioagri.api.payments.services;

import ch.qos.logback.classic.Logger;
import com.paypal.core.PayPalEnvironment;
import com.paypal.core.PayPalHttpClient;
import com.paypal.http.HttpResponse;
import com.paypal.http.serializer.Json;
import com.paypal.orders.*;
import it.bioagri.api.payments.PaymentRequest;
import it.bioagri.api.payments.PaymentServiceFailed;
import it.bioagri.models.Product;
import it.bioagri.persistence.DataSource;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class PaypalPayment implements PaymentExternalService {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(PaypalPayment.class);

    private final String clientId;
    private final String clientSecret;
    private final PayPalHttpClient client;

    public PaypalPayment(String clientId, String clientSecret) {

        this.clientId = clientId;
        this.clientSecret = clientSecret;

        this.client = new PayPalHttpClient(
                new PayPalEnvironment.Sandbox(clientId, clientSecret)
        );

    }


    public PayPalHttpClient getClient() {
        return client;
    }

    public String getClientId() {
        return clientId;
    }

    public String getClientSecret() {
        return clientSecret;
    }



    @Override
    public String create(DataSource dataSource, PaymentRequest request, double shippingPrice) throws PaymentServiceFailed {


        if (request.getItems().size() == 0)
            throw new PaymentServiceFailed(request, "EMPTY");


        List<Map.Entry<Product, Integer>> items;

        try {

            items = request.getItems()
                    .stream()
                    .filter(i -> i.getValue() > 0)
                    .map(i -> Map.entry(
                            dataSource.getProductDao()
                                    .findByPrimaryKey(i.getKey())
                                    .orElseThrow(() -> new RuntimeException("PRODUCT_NOT_FOUND")), i.getValue()
                    ))
                    .peek(i -> {
                        if (i.getKey().getStock() < i.getValue())
                            throw new RuntimeException("PRODUCT_NOT_AVAILABLE");
                    })
                    .collect(Collectors.toList());

        } catch (RuntimeException e) {
            throw new PaymentServiceFailed(request, e.getMessage());
        }


        try {

            double priceTotal = items
                    .stream()
                    .mapToDouble(i -> BigDecimal
                            .valueOf(i.getKey().getPrice() - (i.getKey().getPrice() * i.getKey().getDiscount() / 100))
                            .setScale(2, RoundingMode.HALF_UP)
                            .doubleValue() * i.getValue())
                    .reduce(0.0, Double::sum);


            OrderRequest order = new OrderRequest()
                    .checkoutPaymentIntent("CAPTURE")
                    .purchaseUnits(List.of(
                            new PurchaseUnitRequest()
                                    .description("Acquisto su Bioagri Shop")
                                    .amountWithBreakdown(new AmountWithBreakdown()
                                            .currencyCode("EUR")
                                            .value(BigDecimal.valueOf(priceTotal + shippingPrice)
                                                    .setScale(2, RoundingMode.HALF_UP)
                                                    .toPlainString())
                                            .amountBreakdown(new AmountBreakdown()
                                                    .itemTotal(new Money()
                                                            .currencyCode("EUR")
                                                            .value(BigDecimal.valueOf(priceTotal)
                                                                    .setScale(2, RoundingMode.HALF_UP)
                                                                    .toPlainString()))
                                                    .shipping(new Money()
                                                            .currencyCode("EUR")
                                                            .value(BigDecimal.valueOf(shippingPrice)
                                                                    .setScale(2, RoundingMode.HALF_UP)
                                                                    .toPlainString()))
                                                    .handling(new Money()
                                                            .currencyCode("EUR")
                                                            .value("0.00"))
                                                    .taxTotal(new Money()
                                                            .currencyCode("EUR")
                                                            .value("0.00"))
                                                    .shippingDiscount(new Money()
                                                            .currencyCode("EUR")
                                                            .value("0.00"))))
                                    .items(items.stream()
                                            .map(i -> new Item()
                                                    .name(i.getKey().getName())
                                                    .sku(i.getKey().getId().toString())
                                                    .quantity(i.getValue().toString())
                                                    .unitAmount(new Money()
                                                            .currencyCode("EUR")
                                                            .value(BigDecimal
                                                                    .valueOf(i.getKey().getPrice() - (i.getKey().getPrice() * i.getKey().getDiscount() / 100))
                                                                    .setScale(2, RoundingMode.HALF_UP)
                                                                    .toPlainString()))
                                                    .tax(new Money()
                                                            .currencyCode("EUR")
                                                            .value("0.00")))
                                            .collect(Collectors.toList()))

                    ));


            HttpResponse<Order> response = getClient().execute(new OrdersCreateRequest() {{
                requestBody(order);
            }});


            if(response.statusCode() != 201)
                throw new PaymentServiceFailed(request, "BAD_REQUEST");

            return response.result().id();


        } catch (IOException e) {
            throw new PaymentServiceFailed(request, "INTERNAL_ERROR");
        }

    }

    @Override
    public boolean authorize(DataSource dataSource, PaymentRequest request, it.bioagri.models.Order.Builder builder) {

        try {

            HttpResponse<Order> response = getClient().execute(new OrdersCaptureRequest(request.getId()) {{
                requestBody(new OrderRequest());
            }});


            if(logger.isDebugEnabled()) {

                logger.debug("===== PAYPAL AUTHORIZATION =====");
                logger.debug("Status Code: %d".formatted(response.statusCode()));
                logger.debug("OrderId    : %s".formatted(response.result().id()));
                logger.debug("Status     : %s".formatted(response.result().status()));
                logger.debug("CreateTime : %s".formatted(response.result().createTime()));
                logger.debug("UpdateTime : %s".formatted(response.result().updateTime()));
                logger.debug("Expiration : %s".formatted(response.result().expirationTime()));
                logger.debug("Units      : %d".formatted(response.result().purchaseUnits().size()));
                logger.debug("Items      : %d".formatted(request.getItems().size()));

                for(var i : response.result().links())
                    logger.debug("Links      : %s => %s".formatted(i.rel(), i.href()));

                for(var i : response.result().purchaseUnits()) {

                    for (var j : i.payments().captures())
                        logger.debug("Captures   : %s".formatted(j.id()));

                    logger.debug("InvoiceId  : %s".formatted(i.invoiceId()));

                }

                logger.debug("BuyerMail  : %s".formatted(response.result().payer().email()));
                logger.debug("BuyerName  : %s".formatted(response.result().payer().name().fullName()));

                logger.debug("=====  END AUTHORIZATION   =====");

            }



            if(response.statusCode() != 201)
                return false;

            if(response.result().purchaseUnits().size() != 1)
                return false;

            if(response.result().purchaseUnits().get(0).payments().captures().size() != 1)
                return false;


            var unit = response.result().purchaseUnits().get(0);
            var capture = unit.payments().captures().get(0);

            if(unit.shippingDetail().addressPortable() != null) {

                builder
                        .withAddress("%s %s %s, %s, %s, %s %s, %s".formatted(
                                unit.shippingDetail().addressPortable().addressLine1(),
                                unit.shippingDetail().addressPortable().addressLine2(),
                                unit.shippingDetail().addressPortable().addressLine3(),
                                unit.shippingDetail().addressPortable().adminArea1(),
                                unit.shippingDetail().addressPortable().adminArea2(),
                                unit.shippingDetail().addressPortable().adminArea3(),
                                unit.shippingDetail().addressPortable().adminArea4(),
                                unit.shippingDetail().addressPortable().countryCode()))
                        .withProvince(unit.shippingDetail().addressPortable().adminArea1())
                        .withCity(unit.shippingDetail().addressPortable().adminArea2())
                        .withZip(unit.shippingDetail().addressPortable().postalCode());

            }

            if(unit.invoiceId() != null)
                builder.withInvoice(unit.invoiceId());

            if(capture.amount() != null)
                builder.withPrice(Double.parseDouble(capture.amount().value()));


            builder.withResult(new Json().serialize(response.result()));

            return true;


        } catch (IOException ignored) {
            return false;
        }

    }
}
