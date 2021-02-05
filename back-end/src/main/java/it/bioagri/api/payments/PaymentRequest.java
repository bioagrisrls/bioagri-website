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

import com.fasterxml.jackson.annotation.JsonIgnore;
import it.bioagri.models.Order;
import it.bioagri.models.TransactionType;
import it.bioagri.persistence.DataSource;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class PaymentRequest {

    private final TransactionType service;
    private final String id;
    private final String data;
    private final List<Map.Entry<Long, Integer>> items;

    @JsonIgnore
    private Order order;


    public PaymentRequest(TransactionType service, String id, String data, List<Map.Entry<Long, Integer>> items) {
        this.service = service;
        this.id = id;
        this.data = data;
        this.items = items;
    }

    public PaymentRequest() {
        this.service = null;
        this.id = null;
        this.data = null;
        this.items = new ArrayList<>();
    }


    public String getId() {
        return id;
    }

    public TransactionType getService() {
        return service;
    }

    public String getData() {
        return data;
    }


    public List<Map.Entry<Long, Integer>> getItems() {
        return items;
    }

    @JsonIgnore
    public Optional<Order> getOrder(DataSource dataSource) {

        if(order == null) {
            order = dataSource.getOrderDao()
                    .findByTransactionId(getId())
                    .orElse(null);
        }

        return Optional.ofNullable(order);

    }


    public static final class Builder {

        private TransactionType service;
        private String id;
        private String data;
        private List<Map.Entry<Long, Integer>> items;


        public Builder withService(TransactionType service) {
            this.service = service;
            return this;
        }

        public Builder withId(String id) {
            this.id = id;
            return this;
        }

        public Builder withData(String data) {
            this.data = data;
            return this;
        }

        public Builder withItems(List<Map.Entry<Long, Integer>> items) {
            this.items = items;
            return this;
        }

        public PaymentRequest build() {
            return new PaymentRequest(service, id, data, items);
        }

    }
}
