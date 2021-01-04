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
import java.util.Objects;
import java.util.Optional;

public final class Ticket implements Model {

    private long id;
    private final String title;
    private final String description;
    private final TicketStatus status;
    private final Timestamp createdAt;
    private final Timestamp updatedAt;
    private final Long userId;

    private List<TicketResponse> responses;
    private User user;


    public Ticket(long id, String title, String description, TicketStatus status, Timestamp createdAt, Timestamp updatedAt, Long userId, List<TicketResponse> responses) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.responses = responses;
        this.userId = userId;
    }

    public Ticket() {
        this.id = 0;
        this.title = null;
        this.description = null;
        this.status = null;
        this.createdAt = null;
        this.updatedAt = null;
        this.responses = null;
        this.userId = null;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public TicketStatus getStatus() {
        return status;
    }

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
    public Optional<List<TicketResponse>> getResponses(DataSource dataSource) {

        if(responses == null) {
            responses = dataSource.getTicketResponseDao()
                    .findByTicketId(id);
        }

        return Optional.ofNullable(responses);
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Ticket ticket = (Ticket) o;
        return getId() == ticket.getId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }
}
