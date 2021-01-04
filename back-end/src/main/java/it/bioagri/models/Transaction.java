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
import java.util.Objects;
import java.util.Optional;

public final class Transaction implements Model {

    private long id;
    private final TransactionStatus status;
    private final String result;
    private final double total;
    private final TransactionType type;
    private final String courierService;
    private final String shipmentNumber;
    private final double weight;
    private final String recipient;
    private final String address;
    private final String city;
    private final String province;
    private final String zip;
    private final String phone;
    private final String additionalInfo;
    private final String invoice;
    private final Timestamp createdAt;
    private final Timestamp updatedAt;
    private final Long orderId;
    private final String transactionCode;

    @JsonIgnore
    private Order order;

    public Transaction(long id, TransactionStatus status, String result, double total, TransactionType type, String courierService, String shipmentNumber, double weight, String recipient, String address, String city, String province, String zip, String phone, String additionalInfo, String invoice, Timestamp createdAt, Timestamp updatedAt, Long orderId, String transactionCode) {
        this.id = id;
        this.status = status;
        this.result = result;
        this.total = total;
        this.type = type;
        this.courierService = courierService;
        this.shipmentNumber = shipmentNumber;
        this.weight = weight;
        this.recipient = recipient;
        this.address = address;
        this.city = city;
        this.province = province;
        this.zip = zip;
        this.phone = phone;
        this.additionalInfo = additionalInfo;
        this.invoice = invoice;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.orderId = orderId;
        this.transactionCode = transactionCode;
    }

    public Transaction() {
        this.id = 0;
        this.status = null;
        this.result = null;
        this.total = 0;
        this.type = null;
        this.courierService = null;
        this.shipmentNumber = null;
        this.weight = 0;
        this.recipient = null;
        this.address = null;
        this.city = null;
        this.province = null;
        this.zip = null;
        this.phone = null;
        this.additionalInfo = null;
        this.invoice = null;
        this.createdAt = null;
        this.updatedAt = null;
        this.orderId = null;
        this.transactionCode = null;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public TransactionStatus getStatus() {
        return status;
    }

    public String getResult() {
        return result;
    }

    public Double getTotal() {
        return total;
    }

    public TransactionType getType() {
        return type;
    }

    public String getCourierService() {
        return courierService;
    }

    public String getShipmentNumber() {
        return shipmentNumber;
    }

    public Double getWeight() {
        return weight;
    }

    public String getRecipient() {
        return recipient;
    }

    public String getAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public String getProvince() {
        return province;
    }

    public String getZip() {
        return zip;
    }

    public String getPhone() {
        return phone;
    }

    public String getAdditionalInfo() {
        return additionalInfo;
    }

    public String getInvoice() {
        return invoice;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public Long getOrderId() {
        return orderId;
    }

    public String getTransactionCode() { return transactionCode; }

    @JsonIgnore
    public Optional<Order> getOrder(DataSource dataSource) {

        if(order == null) {
            order = dataSource.getOrderDao()
                    .findByPrimaryKey(orderId)
                    .orElse(null);
        }

        return Optional.ofNullable(order);

    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Transaction that = (Transaction) o;
        return getId() == that.getId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }
}
