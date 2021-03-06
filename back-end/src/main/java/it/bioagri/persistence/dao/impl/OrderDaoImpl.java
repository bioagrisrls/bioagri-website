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

package it.bioagri.persistence.dao.impl;

import it.bioagri.models.Order;
import it.bioagri.models.OrderStatus;
import it.bioagri.models.Product;
import it.bioagri.models.TransactionType;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.OrderDao;

import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

public class OrderDaoImpl extends OrderDao {

    public OrderDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<Order> findByPrimaryKey(Long id) {

        final AtomicReference<Optional<Order>> result = new AtomicReference<>(Optional.empty());

        getDataSource().fetch("SELECT * FROM shop_order WHERE shop_order.id = ?",
                s -> s.setLong(1, id),
                r -> result.set(Optional.of(new Order(
                        r.getLong("id"),
                        OrderStatus.values()[r.getShort("status")],
                        r.getString("result"),
                        r.getFloat("price"),
                        r.getString("transaction_id"),
                        TransactionType.values()[r.getShort("transaction_type")],
                        r.getString("shipment_number"),
                        r.getString("address"),
                        r.getString("city"),
                        r.getString("province"),
                        r.getString("zip"),
                        r.getString("additional_info"),
                        r.getString("invoice"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        r.getLong("user_id"),
                        null
                )))
        );

        return result.get();

    }

    @Override
    public List<Order> findAll() {

        final var orders = new ArrayList<Order>();

        getDataSource().fetch("SELECT * FROM shop_order", null,
                r -> orders.add(new Order(
                        r.getLong("id"),
                        OrderStatus.values()[r.getShort("status")],
                        r.getString("result"),
                        r.getFloat("price"),
                        r.getString("transaction_id"),
                        TransactionType.values()[r.getShort("transaction_type")],
                        r.getString("shipment_number"),
                        r.getString("address"),
                        r.getString("city"),
                        r.getString("province"),
                        r.getString("zip"),
                        r.getString("additional_info"),
                        r.getString("invoice"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        r.getLong("user_id"),
                        null
                ))
        );

        return orders;

    }

    @Override
    public void save(Order value) {

        getDataSource().update(
                """
                    INSERT INTO shop_order (id, status, result, price, transaction_id, transaction_type, shipment_number, address, city, province, zip, additional_info, invoice, created_at, updated_at, user_id)
                                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """,
                s -> {
                    s.setLong(1, value.getId());
                    s.setShort(2, (short) value.getStatus().ordinal());
                    s.setString(3, value.getResult());
                    s.setFloat(4, value.getPrice());
                    s.setString(5, value.getTransactionId());
                    s.setShort(6, (short) value.getTransactionType().ordinal());
                    s.setString(7, value.getShipmentNumber());
                    s.setString(8, value.getAddress());
                    s.setString(9, value.getCity());
                    s.setString(10, value.getProvince());
                    s.setString(11, value.getZip());
                    s.setString(12, value.getAdditionalInfo());
                    s.setString(13, value.getInvoice());
                    s.setTimestamp(14, value.getCreatedAt());
                    s.setTimestamp(15, value.getUpdatedAt());
                    s.setLong(16, value.getUserId());
                });

    }

    @Override
    public void update(Order oldValue, Order newValue) {

        getDataSource().update(
                """
                    UPDATE shop_order
                       SET status = ?, result = ?, price = ?, transaction_id = ?, transaction_type = ?, shipment_number = ?, address = ?, city = ?, province = ?, zip = ?, additional_info = ?, invoice = ?, created_at = ?, updated_at = ?, user_id = ?
                     WHERE id = ?
                    """,
                s -> {
                    s.setShort(1, (short) newValue.getStatus().ordinal());
                    s.setString(2, newValue.getResult());
                    s.setFloat(3, newValue.getPrice());
                    s.setString(4, newValue.getTransactionId());
                    s.setShort(5, (short) newValue.getTransactionType().ordinal());
                    s.setString(6, newValue.getShipmentNumber());
                    s.setString(7, newValue.getAddress());
                    s.setString(8, newValue.getCity());
                    s.setString(9, newValue.getProvince());
                    s.setString(10, newValue.getZip());
                    s.setString(11, newValue.getAdditionalInfo());
                    s.setString(12, newValue.getInvoice());
                    s.setTimestamp(13, newValue.getCreatedAt());
                    s.setTimestamp(14, newValue.getUpdatedAt());
                    s.setLong(15, newValue.getUserId());
                    s.setLong(16, oldValue.getId());
                });

    }

    @Override
    public void delete(Order value) {

        getDataSource().update("DELETE FROM shop_order  WHERE id = ?",
                s -> s.setLong(1, value.getId()));

    }


    @Override
    public Optional<Order> findByTransactionId(String transactionId) {

        final AtomicReference<Optional<Order>> result = new AtomicReference<>(Optional.empty());

        getDataSource().fetch("SELECT * FROM shop_order WHERE shop_order.transaction_id = ?",
                s -> s.setString(1, transactionId),
                r -> result.set(Optional.of(new Order(
                        r.getLong("id"),
                        OrderStatus.values()[r.getShort("status")],
                        r.getString("result"),
                        r.getFloat("price"),
                        r.getString("transaction_id"),
                        TransactionType.values()[r.getShort("transaction_type")],
                        r.getString("shipment_number"),
                        r.getString("address"),
                        r.getString("city"),
                        r.getString("province"),
                        r.getString("zip"),
                        r.getString("additional_info"),
                        r.getString("invoice"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        r.getLong("user_id"),
                        null
                )))
        );

        return result.get();

    }


    @Override
    public void addProduct(Order order, Product product, int quantity) {

        getDataSource().update(
                """
                INSERT INTO shop_order_product (order_id, product_id, quantity) 
                                        VALUES (?, ?, ?)
                """,
                s -> {
                    s.setLong(1, order.getId());
                    s.setLong(2, product.getId());
                    s.setLong(3, quantity);
                });

        order.getProducts(getDataSource()).add(new AbstractMap.SimpleImmutableEntry<>(product, quantity));

    }

    @Override
    public void removeProduct(Order order, Product product) {

        getDataSource().update(
                """
                DELETE FROM shop_order_product 
                      WHERE order_id = ?
                        AND product_id = ?
                """,
                s -> {
                    s.setLong(1, order.getId());
                    s.setLong(2, product.getId());
                });

        order.getProducts(getDataSource()).removeIf(i -> i.getKey().equals(product));

    }

}
