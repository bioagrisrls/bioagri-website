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
import java.util.Optional;

public class TicketResponse {

    private long id;
    private final String response;
    private final Timestamp createdAt;
    private final Timestamp updatedAt;
    private final Long ticketId;

    private Ticket ticket;


    public TicketResponse(long id, String response, Timestamp createdAt, Timestamp updatedAt, Long ticketId) {
        this.id = id;
        this.response = response;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.ticketId = ticketId;
    }

    public TicketResponse() {
        this.id = 0;
        this.response = null;
        this.createdAt = null;
        this.updatedAt = null;
        this.ticketId = null;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getId() {
        return id;
    }

    public String getResponse() {
        return response;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public Long getTicketId() {
        return ticketId;
    }


    @JsonIgnore
    public Optional<Ticket> getTicket(DataSource dataSource) {

        if(ticket == null) {
            ticket = dataSource.getTicketRepository()
                    .findByPrimaryKey(ticketId)
                    .orElse(null);
        }

        return Optional.ofNullable(ticket);

    }

}
