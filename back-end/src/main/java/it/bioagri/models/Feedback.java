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
    private final Timestamp createdAt;
    private final Timestamp updatedAt;
    private final Long userId;
    private final Long productId;

    @JsonIgnore
    private User user;

    @JsonIgnore
    private Product product;


    public Feedback(long id, String title, String description, float vote, Timestamp createdAt, Timestamp updatedAt, Long userId, Long productId) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.vote = vote;
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
        this.createdAt = null;
        this.updatedAt = null;
        this.userId = null;
        this.productId = null;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public float getVote() {
        return vote;
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
            user = dataSource.getUserRepository()
                    .findByPrimaryKey(userId)
                    .orElse(null);
        }

        return Optional.ofNullable(user);

    }

    @JsonIgnore
    public Optional<Product> getProduct(DataSource dataSource) {

        if(product == null) {
            product = dataSource.getProductRepository()
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
        return getId() == feedback.getId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }
}
