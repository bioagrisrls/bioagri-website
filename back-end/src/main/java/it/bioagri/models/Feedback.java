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

public final class Feedback implements Model {

    private long id;
    private final String title;
    private final String description;
    private final float vote;
    private final FeedbackStatus status;
    private final Timestamp createdAt;
    private final Timestamp updatedAt;
    private final Long userId;
    private final Long productId;

    @JsonIgnore
    private User user;

    @JsonIgnore
    private Product product;


    public Feedback(long id, String title, String description, float vote, FeedbackStatus status, Timestamp createdAt, Timestamp updatedAt, Long userId, Long productId) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.vote = vote;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.userId = userId;
        this.productId = productId;
    }

    public Feedback() {
        this.id = 0;
        this.title = null;
        this.description = null;
        this.vote = 0f;
        this.status = null;
        this.createdAt = null;
        this.updatedAt = null;
        this.userId = null;
        this.productId = null;
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

    public Float getVote() {
        return vote;
    }

    public FeedbackStatus getStatus() {
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

    public Long getProductId() {
        return productId;
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
    public Optional<Product> getProduct(DataSource dataSource) {

        if(product == null) {
            product = dataSource.getProductDao()
                    .findByPrimaryKey(productId)
                    .orElse(null);
        }

        return Optional.ofNullable(product);

    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Feedback feedback = (Feedback) o;
        return getId().equals(feedback.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }


    public static final class Builder {

        private long id;
        private String title;
        private String description;
        private float vote;
        private FeedbackStatus status;
        private Timestamp createdAt;
        private Timestamp updatedAt;
        private Long userId;
        private Long productId;


        public Builder withId(long id) {
            this.id = id;
            return this;
        }

        public Builder withTitle(String title) {
            this.title = title;
            return this;
        }

        public Builder withDescription(String description) {
            this.description = description;
            return this;
        }

        public Builder withVote(float vote) {
            this.vote = vote;
            return this;
        }

        public Builder withStatus(FeedbackStatus status) {
            this.status = status;
            return this;
        }

        public Builder withCreatedAt(Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public Builder withUpdatedAt(Timestamp updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }

        public Builder withUserId(Long userId) {
            this.userId = userId;
            return this;
        }

        public Builder withProductId(Long productId) {
            this.productId = productId;
            return this;
        }

        public Feedback build() {
            return new Feedback(id, title, description, vote, status, createdAt, updatedAt, userId, productId);
        }

    }
}
