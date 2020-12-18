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

public final class Order {

    private long id;
    private final OrderStatus status;
    private final Timestamp createdAt;
    private final Timestamp updatedAt;
    private final Long userId;

    private List<Map.Entry<Product, Integer>> products;
    private List<Transaction> transactions;

    @JsonIgnore
    private User user;


    public Order(long id, OrderStatus status, Timestamp createdAt, Timestamp updatedAt, Long userId, List<Map.Entry<Product, Integer>> products, List<Transaction> transactions) {
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

    public long getId() {
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
            user = dataSource.getUserRepository()
                    .findByPrimaryKey(userId)
                    .orElse(null);
        }

        return Optional.ofNullable(user);

    }

    @JsonIgnore
    public List<Map.Entry<Product, Integer>> getProducts(DataSource dataSource) {

        if(products == null) {
            products = dataSource.getProductRepository()
                    .findByOrderId(id);
        }

        return products;
    }

    @JsonIgnore
    public List<Transaction> getTransactions(DataSource dataSource) {

        if(transactions == null) {
            transactions = dataSource.getTransactionRepository()
                    .findByOrderId(id);
        }

        return transactions;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return getId() == order.getId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }

}
