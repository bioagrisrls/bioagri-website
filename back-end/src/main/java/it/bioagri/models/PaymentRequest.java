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

package it.bioagri.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import it.bioagri.persistence.DataSource;

import java.util.Optional;

public class PaymentRequest {

    private final String service;
    private final String id;
    private final String data;
    private final Long orderId;

    @JsonIgnore
    private Order order;


    public PaymentRequest(String service, String id, String data, Long orderId) {
        this.service = service;
        this.id = id;
        this.data = data;
        this.orderId = orderId;
    }

    public PaymentRequest() {
        this.service = null;
        this.id = null;
        this.data = null;
        this.orderId = null;
    }


    public String getId() {
        return id;
    }

    public String getService() {
        return service;
    }

    public String getData() {
        return data;
    }

    public Long getOrderId() {
        return orderId;
    }


    @JsonIgnore
    public Optional<Order> getOrder(DataSource dataSource) {

        if(order == null) {
            order = dataSource.getOrderDao()
                    .findByPrimaryKey(orderId)
                    .orElse(null);
        }

        return Optional.ofNullable(order);

    }

}
