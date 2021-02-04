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

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

public final class Order implements Model {

    private long id;
    private final OrderStatus status;
    private final Timestamp createdAt;
    private final Timestamp updatedAt;
    private final Long userId;

    private List<Map.Entry<Product, Integer>> products;
    private List<Transaction> transactions;

    @JsonIgnore
    private User user;


    public Order(Long id, OrderStatus status, Timestamp createdAt, Timestamp updatedAt, Long userId, List<Map.Entry<Product, Integer>> products, List<Transaction> transactions) {
        this.id = id;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.userId = userId;
        this.products = products;
        this.transactions = transactions;
    }

    public Order() {
        this.id = 0;
        this.status = null;
        this.createdAt = null;
        this.updatedAt = null;
        this.userId = null;
        this.products = null;
        this.transactions = null;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public Long getUserId() {
        return userId;
    }

    @JsonIgnore
    public Optional<User> getUser(DataSource dataSource) {

        if(user == null) {
            user = dataSource.getUserDao()
                    .findByPrimaryKey(userId)
                    .orElse(null);
        }

        return Optional.ofNullable(user);

    }

    @JsonIgnore
    public List<Map.Entry<Product, Integer>> getProducts(DataSource dataSource) {

        if(products == null) {
            products = dataSource.getProductDao()
                    .findByOrderId(id);
        }

        return products;
    }

    @JsonIgnore
    public List<Transaction> getTransactions(DataSource dataSource) {

        if(transactions == null) {
            transactions = dataSource.getTransactionDao()
                    .findByOrderId(id);
        }

        return transactions;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return getId().equals(order.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }


    public static final class Builder {

        private long id;
        private OrderStatus status;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        private Long userId;


        public Builder withId(long id) {
            this.id = id;
            return this;
        }

        public Builder withStatus(OrderStatus status) {
            this.status = status;
            return this;
        }

        public Builder withCreatedAt(Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public Builder withUpdatedAt(Timestamp updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }

        public Builder withUserId(Long userId) {
            this.userId = userId;
            return this;
        }

        public Order build() {
            Order order = new Order(0L, status, createdAt, updatedAt, userId, null, null);
            order.setId(id);
            return order;
        }

    }
}
