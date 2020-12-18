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

import it.bioagri.models.Transaction;
import it.bioagri.models.TransactionStatus;
import it.bioagri.models.TransactionType;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.TransactionDao;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

public class TransactionDaoImpl extends TransactionDao {

    public TransactionDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<Transaction> findByPrimaryKey(Long id) {

        final AtomicReference<Optional<Transaction>> result = new AtomicReference<>(Optional.empty());

        getDataSource().fetch("SELECT * FROM shop_transaction WHERE shop_transaction.id = ?",
                s -> s.setLong(1, id),
                r -> result.set(Optional.of(new Transaction(
                        r.getLong("id"),
                        TransactionStatus.values()[r.getShort("status")],
                        r.getString("result"),
                        r.getDouble("total"),
                        TransactionType.values()[r.getShort("type")],
                        r.getString("courier_service"),
                        r.getString("shipment_number"),
                        r.getDouble("weight"),
                        r.getString("recipient"),
                        r.getString("address"),
                        r.getString("city"),
                        r.getString("province"),
                        r.getString("zip"),
                        r.getString("phone"),
                        r.getString("additional_info"),
                        r.getString("invoice"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        r.getLong("order_id"),
                        r.getString("transaction_code")
                )))
        );

        return result.get();

    }

    @Override
    public List<Transaction> findAll() {

        final var transactions = new ArrayList<Transaction>();

        getDataSource().fetch("SELECT * FROM shop_transaction", null,
                r -> transactions.add(new Transaction(
                        r.getLong("id"),
                        TransactionStatus.values()[r.getShort("status")],
                        r.getString("result"),
                        r.getDouble("total"),
                        TransactionType.values()[r.getShort("type")],
                        r.getString("courier_service"),
                        r.getString("shipment_number"),
                        r.getDouble("weight"),
                        r.getString("recipient"),
                        r.getString("address"),
                        r.getString("city"),
                        r.getString("province"),
                        r.getString("zip"),
                        r.getString("phone"),
                        r.getString("additional_info"),
                        r.getString("invoice"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        r.getLong("order_id"),
                        r.getString("transaction_code")
                ))
        );

        return transactions;

    }

    @Override
    public void save(Transaction value) {

        getDataSource().update(
                """
                    INSERT INTO shop_transaction (id, status, created_at, updated_at, result, total, type, 
                                                  courier_service, shipment_number, weight, recipient, address, city, 
                                                  province, zip, phone, additional_info, invoice, order_id, 
                                                  transaction_code) 
                                          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """,
                s -> {
                    s.setLong(1, value.getId());
                    s.setShort(2, (short) value.getStatus().ordinal());
                    s.setTimestamp(3, value.getCreatedAt());
                    s.setTimestamp(4, value.getUpdatedAt());
                    s.setString(5, value.getResult());
                    s.setDouble(6, value.getTotal());
                    s.setShort(7, (short) value.getType().ordinal());
                    s.setString(8, value.getCourierService());
                    s.setString(9, value.getShipmentNumber());
                    s.setDouble(10, value.getWeight());
                    s.setString(11, value.getRecipient());
                    s.setString(12, value.getAddress());
                    s.setString(13, value.getCity());
                    s.setString(14, value.getProvince());
                    s.setString(15, value.getZip());
                    s.setString(16, value.getPhone());
                    s.setString(17, value.getAdditionalInfo());
                    s.setString(18, value.getInvoice());
                    s.setLong(19, value.getOrderId());
                    s.setString(20, value.getTransactionCode());
                });

    }

    @Override
    public void update(Transaction oldValue, Transaction newValue) {

        getDataSource().update(
            """
                UPDATE shop_transaction
                   SET status = ?, created_at = ?, updated_at = ?, result = ?, total = ?, type = ?, courier_service = ?, 
                       shipment_number = ?, weight = ?, recipient = ?, address = ?, city = ?, province = ?, zip = ?, 
                       phone = ?, additional_info = ?, invoice = ?, transaction_code = ? 
                 WHERE id = ?
                """,
                    s -> {
                        s.setShort(1, (short) newValue.getStatus().ordinal());
                        s.setTimestamp(2, newValue.getCreatedAt());
                        s.setTimestamp(3, newValue.getUpdatedAt());
                        s.setString(4, newValue.getResult());
                        s.setDouble(5, newValue.getTotal());
                        s.setShort(6, (short) newValue.getType().ordinal());
                        s.setString(7, newValue.getCourierService());
                        s.setString(8, newValue.getShipmentNumber());
                        s.setDouble(9, newValue.getWeight());
                        s.setString(10, newValue.getRecipient());
                        s.setString(11, newValue.getAddress());
                        s.setString(12, newValue.getCity());
                        s.setString(13, newValue.getProvince());
                        s.setString(14, newValue.getZip());
                        s.setString(15, newValue.getPhone());
                        s.setString(16, newValue.getAdditionalInfo());
                        s.setString(17, newValue.getInvoice());
                        s.setString(18, newValue.getTransactionCode());
                        s.setLong(19, oldValue.getId());
                    });

    }

    @Override
    public void delete(Transaction value) {

        getDataSource().update("DELETE FROM shop_transaction WHERE id = ?",
                s -> s.setLong(1, value.getId()));

    }

    @Override
    public List<Transaction> findByOrderId(Long id) {

        return new ArrayList<>() {{

                getDataSource().fetch("SELECT * FROM shop_transaction WHERE order_id = ?",
                        s -> s.setLong(1, id),
                        r -> findByPrimaryKey(r.getLong("id")).ifPresent(this::add));

        }};

    }

}
