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

import it.bioagri.api.payments.PaymentRequest;
import it.bioagri.api.payments.PaymentServiceFailed;
import it.bioagri.models.Order;
import it.bioagri.models.Product;
import it.bioagri.persistence.DataSource;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public class BankTransferPayment implements PaymentExternalService {


    @Override
    public String create(DataSource dataSource, PaymentRequest request, double shippingPrice, double priceTotal, List<Map.Entry<Product, Integer>> items, Order.Builder builder) throws PaymentServiceFailed {
        return "BT_" + UUID.randomUUID().toString().substring(0, 28);
    }

    @Override
    public boolean authorize(DataSource dataSource, PaymentRequest request, Order.Builder builder) {
        return true;
    }

}
