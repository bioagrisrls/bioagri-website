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
import com.paypal.orders.Order;
import com.paypal.orders.OrderRequest;
import com.paypal.orders.OrdersCaptureRequest;
import it.bioagri.api.payments.PaymentRequest;
import it.bioagri.models.Transaction;
import it.bioagri.models.TransactionStatus;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;

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
    public Transaction authorize(PaymentRequest request, Transaction.Builder builder) {

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

                for(var i : response.result().links())
                    logger.debug("Links      : %s => %s".formatted(i.rel(), i.href()));

                for(var i : response.result().purchaseUnits())
                    for(var j : i.payments().captures())
                        logger.debug("Captures   : %s".formatted(j.id()));

                logger.debug("BuyerMail  : %s".formatted(response.result().payer().email()));
                logger.debug("BuyerName  : %s".formatted(response.result().payer().name().fullName()));

                logger.debug("=====  END AUTHORIZATION   =====");

            }


            // TODO: fill data...
            builder
                    .withStatus(TransactionStatus.PROCESSING)
                    .withTransactionCode(response.result().id())
                    .withAddress("%s, %s, %s, %s, %s, %s, %s".formatted(
                            response.result().payer().addressPortable().addressLine1(),
                            response.result().payer().addressPortable().addressLine2(),
                            response.result().payer().addressPortable().addressLine3(),
                            response.result().payer().addressPortable().adminArea1(),
                            response.result().payer().addressPortable().adminArea2(),
                            response.result().payer().addressPortable().adminArea3(),
                            response.result().payer().addressPortable().adminArea4()))
                    .withCity(response.result().payer().addressPortable().countryCode())
                    .withCreatedAt(Timestamp.from(Instant.now()))
                    .withUpdatedAt(Timestamp.from(Instant.now()))
                    .withCourierService("undefined");



            if(HttpStatus.resolve(response.statusCode()) != null
                    && HttpStatus.valueOf(response.statusCode()).is2xxSuccessful()) {

                return builder
                        .withStatus(TransactionStatus.OK)
                        .build();

            }


        } catch (IOException e) {

            logger.error("===== PAYPAL AUTHORIZATION =====");
            logger.error(e.getMessage(), e);
            logger.error("=====  END AUTHORIZATION   =====");

        }


        return builder
                .withStatus(TransactionStatus.FAILED)
                .build();

    }

}
