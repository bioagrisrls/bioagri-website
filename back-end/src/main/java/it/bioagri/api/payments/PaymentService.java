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

import it.bioagri.api.auth.AuthLogin;
import it.bioagri.api.auth.services.AuthExternalService;
import it.bioagri.api.auth.services.FacebookAuth;
import it.bioagri.api.auth.services.GoogleAuth;
import it.bioagri.api.auth.services.TwitterAuth;
import it.bioagri.api.payments.services.PaymentExternalService;
import it.bioagri.api.payments.services.PaypalPayment;
import it.bioagri.models.PaymentRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
@Scope("singleton")
public class PaymentService {

    private final Map<String, PaymentExternalService> services;


    @Autowired
    private PaymentService(
            @Value("${payments.services.external.paypal.id}"      ) String paypalId,
            @Value("${payments.services.external.paypal.secret}"  ) String paypalSecret) {

        services = Map.of(
                "<<PAYMENT_TYPE_PAYPAL>>", new PaypalPayment(paypalId, paypalSecret)
        );

    }



    public boolean authorize(PaymentRequest request) {

        for(var service : services.keySet()) {

            if(request.getService().equals(service) && services.get(service).authorize(request.getOrderId()))
                return true;

        }

        return false;

    }

}
