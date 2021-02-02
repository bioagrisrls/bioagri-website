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
    private final String info;
    private final float price;
    private final float discount;
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


    public Product(long id, String name, String description, String info, float price, float discount, int stock, ProductStatus status, Timestamp updatedAt, Timestamp createdAt, List<Category> categories, List<Tag> tags, List<Feedback> feedbacks) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.info = info;
        this.price = price;
        this.discount = discount;
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
        this.info = null;
        this.price = 0;
        this.discount = 0;
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

    public String getInfo() {
        return info;
    }

    public Float getPrice() {
        return price;
    }

    public float getDiscount() {
        return discount;
    }

    public Integer getStock() {
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
            categories = dataSource.getCategoryDao()
                    .findByProductId(id);
        }

        return categories;
    }

    @JsonIgnore
    public List<Tag> getTags(DataSource dataSource) {

        if(tags == null) {
            tags = dataSource.getTagDao()
                    .findByProductId(id);
        }

        return tags;
    }

    @JsonIgnore
    public List<Feedback> getFeedbacks(DataSource dataSource) {

        if(feedbacks == null) {
            feedbacks = dataSource.getFeedbackDao()
                    .findByProductId(id);
        }

        return feedbacks;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return getId().equals(product.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }

    @Override
    public String toString() {
        return getId().toString();
    }


    public static final class Builder {

        private long id;
        private String name;
        private String description;
        private String info;
        private float price;
        private float discount;
        private int stock;
        private ProductStatus status;
        private Timestamp updatedAt;
        private Timestamp createdAt;


        public Builder withId(long id) {
            this.id = id;
            return this;
        }

        public Builder withName(String name) {
            this.name = name;
            return this;
        }

        public Builder withDescription(String description) {
            this.description = description;
            return this;
        }

        public Builder withInfo(String info) {
            this.info = info;
            return this;
        }

        public Builder withPrice(float price) {
            this.price = price;
            return this;
        }

        public Builder withDiscount(float discount) {
            this.discount = discount;
            return this;
        }

        public Builder withStock(int stock) {
            this.stock = stock;
            return this;
        }

        public Builder withStatus(ProductStatus status) {
            this.status = status;
            return this;
        }

        public Builder withUpdatedAt(Timestamp updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }

        public Builder withCreatedAt(Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public Product build() {
            return new Product(id, name, description, info, price, discount, stock, status, updatedAt, createdAt, null, null, null);
        }
    }
}
