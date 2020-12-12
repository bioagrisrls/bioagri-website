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
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.OrderDao;

import java.util.HashMap;
import java.util.LinkedList;
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
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        new HashMap<>(),
                        new LinkedList<>()
                )))
        );


        result.get().ifPresent(r -> r.getProducts()
                .putAll(getDataSource().getProductRepository().findByOrderId(r.getId())));

        result.get().ifPresent(r -> r.getTransactions()
                .addAll(getDataSource().getTransactionRepository().findByOrderId(r.getId())));


        return result.get();

    }

    @Override
    public List<Order> findAll() {

        final var orders = new LinkedList<Order>();

        getDataSource().fetch("SELECT * FROM shop_order", null,
                r -> orders.add(new Order(
                        r.getLong("id"),
                        OrderStatus.values()[r.getShort("status")],
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        new HashMap<>(),
                        new LinkedList<>()
                ))
        );


        for(var order : orders) {

            order.getProducts()
                    .putAll(getDataSource().getProductRepository().findByOrderId(order.getId()));

            order.getTransactions()
                    .addAll(getDataSource().getTransactionRepository().findByOrderId(order.getId()));

        }


        return orders;
        
    }

    @Override
    public void save(Order value) {

    }

    @Override
    public void update(Order value, Object... params) {

    }

    @Override
    public void delete(Order value) {

    }

}
