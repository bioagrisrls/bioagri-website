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
                        new ArrayList<>()
                )))
        );

        // TODO: get ticket responses for a ticket

//        result.get().ifPresent(r -> r.getResponses()
//                .addAll(getDataSource().getTicketResponseRepository().findByTicketId(r.getId())));

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
                        new ArrayList<>()
                ))
        );


        // TODO: get ticket responses for a ticket

        for(var ticket : tickets) {

//            ticket.getTags()
//                    .addAll(getDataSource().getTicketResponseRepository().findByTicketId(ticket.getId()));

        }

        return tickets;

    }

    @Override
    public void save(Ticket value) {

    }

    @Override
    public void update(Ticket oldValue, Ticket newValue) {

    }


    @Override
    public void delete(Ticket value) {

    }


    @Override
    public List<Ticket> findByUserId(Long id) {

        var tickets = new ArrayList<Ticket>();

        getDataSource().fetch("SELECT * FROM shop_ticket WHERE shop_ticket.user_id = ?",
                s -> s.setLong(1, id),
                r -> findByPrimaryKey(r.getLong("id")).ifPresent(tickets::add));

        return tickets;

    }
}
