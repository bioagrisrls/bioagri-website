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

public final class Product implements Model {

    private long id;
    private final String name;
    private final String description;
    private final float price;
    private final int stock;
    private final ProductStatus status;
    private final Timestamp updatedAt;
    private final Timestamp createdAt;

    @JsonIgnore
    private List<Category> categories;

    @JsonIgnore
    private List<Tag> tags;

    @JsonIgnore
    private List<Feedback> feedbacks;


    public Product(long id, String name, String description, float price, int stock, ProductStatus status, Timestamp updatedAt, Timestamp createdAt, List<Category> categories, List<Tag> tags, List<Feedback> feedbacks) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.status = status;
        this.updatedAt = updatedAt;
        this.createdAt = createdAt;
        this.categories = categories;
        this.tags = tags;
        this.feedbacks = feedbacks;
    }

    public Product() {
        this.id = 0;
        this.name = null;
        this.description = null;
        this.price = 0;
        this.stock = 0;
        this.status = null;
        this.updatedAt = null;
        this.createdAt = null;
        this.categories = null;
        this.tags = null;
        this.feedbacks = null;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public float getPrice() {
        return price;
    }

    public int getStock() {
        return stock;
    }

    public ProductStatus getStatus() {
        return status;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    @JsonIgnore
    public List<Category> getCategories(DataSource dataSource) {

        if(categories == null) {
            categories = dataSource.getCategoryRepository()
                    .findByProductId(id);
        }

        return categories;
    }

    @JsonIgnore
    public List<Tag> getTags(DataSource dataSource) {

        if(tags == null) {
            tags = dataSource.getTagRepository()
                    .findByProductId(id);
        }

        return tags;
    }

    @JsonIgnore
    public List<Feedback> getFeedbacks(DataSource dataSource) {

        if(feedbacks == null) {
            feedbacks = dataSource.getFeedbackRepository()
                    .findByProductId(id);
        }

        return feedbacks;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return getId() == product.getId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }
}
