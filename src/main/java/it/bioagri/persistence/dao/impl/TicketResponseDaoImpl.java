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

import it.bioagri.models.Category;
import it.bioagri.models.TicketResponse;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.TicketResponseDao;

import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

public class TicketResponseDaoImpl extends TicketResponseDao {

    public TicketResponseDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<TicketResponse> findByPrimaryKey(Long id) {

        final AtomicReference<Optional<TicketResponse>> result = new AtomicReference<>(Optional.empty());

        getDataSource().fetch("SELECT * FROM shop_ticket_response WHERE shop_ticket_response.id = ?",
                s -> s.setLong(1, id),
                r -> result.set(Optional.of(new TicketResponse(
                        r.getLong("id"),
                        r.getString("response"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at")
                )))
        );

        return result.get();

    }

    @Override
    public List<TicketResponse> findAll() {

        final var responses = new LinkedList<TicketResponse>();

        getDataSource().fetch("SELECT * FROM shop_ticket_response", null,
                r -> responses.add(new TicketResponse(
                        r.getLong("id"),
                        r.getString("response"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at")
                ))
        );

        return responses;

    }

    @Override
    public void save(TicketResponse value) {

    }

    @Override
    public void update(TicketResponse value, Object... params) {

    }

    @Override
    public void delete(TicketResponse value) {

    }
}
