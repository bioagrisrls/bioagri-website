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

import java.util.LinkedList;
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
                        r.getTimestamp("updated_at")
                )))
        );

        return result.get();

    }

    @Override
    public List<Transaction> findAll() {

        final var transactions = new LinkedList<Transaction>();

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
                        r.getTimestamp("updated_at")
                ))
        );

        return transactions;

    }

    @Override
    public void save(Transaction value) {

    }

    @Override
    public void update(Transaction value, Object... params) {

    }

    @Override
    public void delete(Transaction value) {

    }

    @Override
    public List<Transaction> findByOrderId(Long id) {
        return null;
    }
}
