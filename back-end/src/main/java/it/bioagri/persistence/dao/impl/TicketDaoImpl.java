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

import it.bioagri.models.Ticket;
import it.bioagri.models.TicketStatus;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.TicketDao;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

public class TicketDaoImpl extends TicketDao {

    public TicketDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<Ticket> findByPrimaryKey(Long id) {

        final AtomicReference<Optional<Ticket>> result = new AtomicReference<>(Optional.empty());

        getDataSource().fetch("SELECT * FROM shop_ticket WHERE shop_ticket.id = ?",
                s -> s.setLong(1, id),
                r -> result.set(Optional.of(new Ticket(
                        r.getLong("id"),
                        r.getString("title"),
                        r.getString("description"),
                        TicketStatus.values()[r.getShort("status")],
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        r.getLong("user_id"),
                        null
                )))
        );

        return result.get();

    }

    @Override
    public List<Ticket> findAll() {

        final var tickets = new ArrayList<Ticket>();

        getDataSource().fetch("SELECT * FROM shop_ticket", null,
                r -> tickets.add(new Ticket(
                        r.getLong("id"),
                        r.getString("title"),
                        r.getString("description"),
                        TicketStatus.values()[r.getShort("status")],
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        r.getLong("user_id"),
                        null
                ))
        );

        return tickets;

    }

    @Override
    public void save(Ticket value) {

        getDataSource().update(
                """
                    INSERT INTO shop_ticket (id, title, description, status, user_id, created_at, updated_at) 
                                     VALUES (?, ?, ?, ?, ?, ?, ?)
                    """,
                    s -> {
                        s.setLong(1, value.getId());
                        s.setString(2, value.getTitle());
                        s.setString(3, value.getDescription());
                        s.setShort(4, (short) value.getStatus().ordinal());
                        s.setLong(5, value.getUserId());
                        s.setTimestamp(6, value.getCreatedAt());
                        s.setTimestamp(7, value.getUpdatedAt());
                    }, false);

    }

    @Override
    public void update(Ticket oldValue, Ticket newValue) {

        getDataSource().update(
                """
                    UPDATE shop_ticket 
                       SET title = ?, description = ?, status = ?, user_id = ?, created_at = ?, updated_at = ?
                     WHERE id = ?
                    """,
                    s -> {
                        s.setString(1, newValue.getTitle());
                        s.setString(2,newValue.getDescription());
                        s.setShort(3, (short) newValue.getStatus().ordinal());
                        s.setLong(4, newValue.getUserId());
                        s.setTimestamp(5, newValue.getCreatedAt());
                        s.setTimestamp(6, newValue.getUpdatedAt());
                        s.setLong(7, oldValue.getId());
                    }, false);

    }


    @Override
    public void delete(Ticket value) {

        getDataSource().update("DELETE FROM shop_ticket WHERE id = ?",
                s -> s.setLong(1, value.getId()), false);

    }


    @Override
    public List<Ticket> findByUserId(Long id) {

        return new ArrayList<>() {{

                getDataSource().fetch("SELECT * FROM shop_ticket WHERE shop_ticket.user_id = ?",
                        s -> s.setLong(1, id),
                        r -> findByPrimaryKey(r.getLong("id")).ifPresent(this::add));

        }};

    }
}
