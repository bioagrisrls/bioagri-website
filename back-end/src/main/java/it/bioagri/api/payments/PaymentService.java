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

import it.bioagri.api.payments.services.PaymentExternalService;
import it.bioagri.api.payments.services.PaypalPayment;
import it.bioagri.models.Order;
import it.bioagri.models.Transaction;
import it.bioagri.persistence.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.Map;

@Component
@Scope("singleton")
public class PaymentService {

    private final Map<String, PaymentExternalService> services;
    private final String shipmentRecipient;
    private final String shipmentPrice;
    private final String shipmentCourierService;

    @Autowired
    private PaymentService(
            @Value("${payments.services.external.paypal.id}"      ) String paypalId,
            @Value("${payments.services.external.paypal.secret}"  ) String paypalSecret,
            @Value("${payments.shipment.recipient}"               ) String shipmentRecipient,
            @Value("${payments.shipment.courier}"                 ) String shipmentCourierService,
            @Value("${payments.shipment.price}"                   ) String shipmentPrice) {

        this.shipmentRecipient = shipmentRecipient;
        this.shipmentCourierService = shipmentCourierService;
        this.shipmentPrice = shipmentPrice;

        services = Map.of(
                "<<PAYMENT_TYPE_PAYPAL>>", new PaypalPayment(paypalId, paypalSecret)
        );

    }



    public String create(DataSource dataSource, PaymentRequest request) throws PaymentServiceNotFound, PaymentServiceFailed {


        for(var service : services.keySet()) {

            if(request.getService().equals(service))
                return services.get(service).create(dataSource, request, Double.parseDouble(shipmentPrice));

        }

        throw new PaymentServiceNotFound(request);

    }

    public boolean authorize(DataSource dataSource, PaymentRequest request) throws PaymentServiceNotFound {


        for(var service : services.keySet()) {

            if(request.getService().equals(service))
                return services.get(service).authorize(dataSource, request, new Order.Builder());

        }

        throw new PaymentServiceNotFound(request);

    }

}
