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

    private Long id;
    private final OrderStatus status;
    private final String result;
    private final Double price;
    private final String transactionId;
    private final TransactionType transactionType;
    private final String shipmentNumber;
    private final String address;
    private final String city;
    private final String province;
    private final String zip;
    private final String additionalInfo;
    private final String invoice;
    private final Timestamp createdAt;
    private final Timestamp updatedAt;
    private final Long userId;

    private List<Map.Entry<Product, Integer>> products;

    @JsonIgnore
    private User user;


    public Order(long id, OrderStatus status, String result, Double price, String transactionId, TransactionType transactionType, String shipmentNumber, String address, String city, String province, String zip, String additionalInfo, String invoice, Timestamp createdAt, Timestamp updatedAt, Long userId, List<Map.Entry<Product, Integer>> products) {
        this.id = id;
        this.status = status;
        this.result = result;
        this.price = price;
        this.transactionId = transactionId;
        this.transactionType = transactionType;
        this.shipmentNumber = shipmentNumber;
        this.address = address;
        this.city = city;
        this.province = province;
        this.zip = zip;
        this.additionalInfo = additionalInfo;
        this.invoice = invoice;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.userId = userId;
        this.products = products;
    }

    public Order() {
        this.id = 0L;
        this.status = null;
        this.result = null;
        this.price = 0.;
        this.transactionId = null;
        this.transactionType = null;
        this.shipmentNumber = null;
        this.address = null;
        this.city = null;
        this.province = null;
        this.zip = null;
        this.additionalInfo = null;
        this.invoice = null;
        this.createdAt = null;
        this.updatedAt = null;
        this.userId = null;
        this.products = null;
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

    public String getResult() { return result; }

    public Double getPrice() { return price; }

    public String getTransactionId() { return transactionId; }

    public TransactionType getTransactionType() { return transactionType; }

    public String getShipmentNumber() { return shipmentNumber; }

    public String getAddress() { return address; }

    public String getCity() { return city; }

    public String getProvince() { return province; }

    public String getZip() { return zip; }

    public String getAdditionalInfo() { return additionalInfo; }

    public String getInvoice() { return invoice; }

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

        private Long id;
        private OrderStatus status;
        private String result;
        private Double price;
        private String transactionId;
        private TransactionType transactionType;
        private String shipmentNumber;
        private String address;
        private String city;
        private String province;
        private String zip;
        private String additionalInfo;
        private String invoice;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        private Long userId;
        private List<Map.Entry<Product, Integer>> products;


        public Builder() {}

        public Builder(Order order) {
            this.id = order.getId();
            this.status = order.getStatus();
            this.result = order.getResult();
            this.price = order.getPrice();
            this.transactionId = order.getTransactionId();
            this.transactionType = order.getTransactionType();
            this.shipmentNumber = order.getShipmentNumber();
            this.address = order.getAddress();
            this.city = order.getCity();
            this.province = order.getProvince();
            this.zip = order.getZip();
            this.additionalInfo = order.getAdditionalInfo();
            this.invoice = order.getInvoice();
            this.createdAt = order.getCreatedAt();
            this.updatedAt = order.getUpdatedAt();
            this.userId = order.getUserId();
            this.products = null;
        }


        public Builder withId(Long id) {
            this.id = id;
            return this;
        }

        public Builder withStatus(OrderStatus status) {
            this.status = status;
            return this;
        }

        public Builder withResult(String result) {
            this.result = result;
            return this;
        }

        public Builder withPrice(Double price) {
            this.price = price;
            return this;
        }

        public Builder withTransactionId(String transactionId) {
            this.transactionId = transactionId;
            return this;
        }

        public Builder withTransactionType(TransactionType transactionType) {
            this.transactionType = transactionType;
            return this;
        }

        public Builder withShipmentNumber(String shipmentNumber) {
            this.shipmentNumber = shipmentNumber;
            return this;
        }

        public Builder withAddress(String address) {
            this.address = address;
            return this;
        }

        public Builder withCity(String city) {
            this.city = city;
            return this;
        }

        public Builder withProvince(String province) {
            this.province = province;
            return this;
        }

        public Builder withZip(String zip) {
            this.zip = zip;
            return this;
        }

        public Builder withAdditionalInfo(String additionalInfo) {
            this.additionalInfo = additionalInfo;
            return this;
        }

        public Builder withInvoice(String invoice) {
            this.invoice = invoice;
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

        public Builder withProducts(List<Map.Entry<Product, Integer>> products) {
            this.products = products;
            return this;
        }

        public Order build() {
            Order order = new Order(0L, status, result, price, transactionId, transactionType, shipmentNumber, address, city, province, zip, additionalInfo, invoice, createdAt, updatedAt, userId, products);
            order.setId(id);
            return order;
        }

    }
}
