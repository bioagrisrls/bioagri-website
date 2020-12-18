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

import it.bioagri.models.Product;
import it.bioagri.models.ProductStatus;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.ProductDao;
import it.bioagri.utils.ListUtils;

import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;

public class ProductDaoImpl extends ProductDao {

    public ProductDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<Product> findByPrimaryKey(Long id) {

        final AtomicReference<Optional<Product>> result = new AtomicReference<>(Optional.empty());

        getDataSource().fetch(
                """
                        SELECT * FROM shop_product,
                                      shop_product_category
                        WHERE shop_product.id = ?
                          AND shop_product_category.product_id = shop_product.id
                    """,

                s -> s.setLong(1, id),
                r -> {

                    var product = new Product(
                            r.getLong("id"),
                            r.getString("name"),
                            r.getString("description"),
                            r.getFloat("price"),
                            r.getInt("stock"),
                            ProductStatus.values()[r.getShort("status")],
                            r.getTimestamp("updated_at"),
                            r.getTimestamp("created_at"),
                            null,
                            null,
                            null
                    );

                    result.set(Optional.of(product));

                }

        );

        return result.get();

    }

    @Override
    public List<Product> findAll() {

        final var products = new ArrayList<Product>();

        getDataSource().fetch("SELECT * FROM shop_product", null,
                r -> products.add(new Product(
                        r.getLong("id"),
                        r.getString("name"),
                        r.getString("description"),
                        r.getFloat("price"),
                        r.getInt("stock"),
                        ProductStatus.values()[r.getShort("status")],
                        r.getTimestamp("updated_at"),
                        r.getTimestamp("created_at"),
                        null,
                        null,
                        null
                ))
        );

        return products;

    }

    @Override
    public void save(Product value) {

        getDataSource().update(
                """
                    INSERT INTO shop_product (id, name, description, price, stock, status, created_at, updated_at)
                                      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                    """,
                    s -> {
                        s.setLong(1, value.getId());
                        s.setString(2, value.getName());
                        s.setString(3, value.getDescription());
                        s.setFloat(4, value.getPrice());
                        s.setInt(5, value.getStock());
                        s.setShort(6, (short) value.getStatus().ordinal());
                        s.setTimestamp(7, value.getCreatedAt());
                        s.setTimestamp(8, value.getUpdatedAt());
                    }, false);



        for(var i : value.getCategories(getDataSource())) {

            getDataSource().update(
                    """
                    INSERT INTO shop_product_category (product_id, category_id) 
                                               VALUES (?, ?)
                    """,
                    s -> {
                        s.setLong(1, value.getId());
                        s.setLong(2, i.getId());
                    }, false);

        }


        for(var i : value.getTags(getDataSource())) {

            getDataSource().update(
                    """
                    INSERT INTO shop_product_tag (product_id, tag_id) 
                                          VALUES (?, ?)
                    """,
                    s -> {
                        s.setLong(1, value.getId());
                        s.setLong(2, i.getId());
                    }, false);

        }



    }

    @Override
    public void update(Product oldValue, Product newValue) {

        getDataSource().update(
                """
                    UPDATE shop_product 
                       SET name = ?, description = ?, price = ?, stock = ?, status = ?, created_at = ?, updated_at = ?
                     WHERE id = ?
                    """,
                    s -> {
                        s.setString(1, newValue.getName());
                        s.setString(2, newValue.getDescription());
                        s.setFloat(3, newValue.getPrice());
                        s.setInt(4, newValue.getStock());
                        s.setShort(5, (short) newValue.getStatus().ordinal());
                        s.setTimestamp(6, newValue.getCreatedAt());
                        s.setTimestamp(7, newValue.getUpdatedAt());
                        s.setLong(8, oldValue.getId());
                    }, false);


        ListUtils.differences(oldValue.getCategories(getDataSource()), newValue.getCategories(getDataSource()), (added, removed) -> {

            for(var i : added) {

                getDataSource().update(
                        """
                        INSERT INTO shop_product_category (product_id, category_id) 
                                                   VALUES (?, ?)
                        """,
                        s -> {
                            s.setLong(1, newValue.getId());
                            s.setLong(2, i.getId());
                        }, false);

            }

            for(var i : removed) {

                getDataSource().update(
                        """
                        DELETE FROM shop_product_category 
                              WHERE product_id = ?
                                AND category_id = ?
                        """,
                        s -> {
                            s.setLong(1, oldValue.getId());
                            s.setLong(2, i.getId());
                        }, false);

            }

        });


        ListUtils.differences(oldValue.getTags(getDataSource()), newValue.getTags(getDataSource()), (added, removed) -> {

            for(var i : added) {

                getDataSource().update(
                        """
                        INSERT INTO shop_product_tag (product_id, tag_id) 
                                                   VALUES (?, ?)
                        """,
                        s -> {
                            s.setLong(1, newValue.getId());
                            s.setLong(2, i.getId());
                        }, false);

            }

            for(var i : removed) {

                getDataSource().update(
                        """
                        DELETE FROM shop_product_tag 
                              WHERE product_id = ?
                                AND tag_id = ?
                        """,
                        s -> {
                            s.setLong(1, oldValue.getId());
                            s.setLong(2, i.getId());
                        }, false);

            }

        });

    }

    @Override
    public void delete(Product value) {

        getDataSource().update("DELETE FROM shop_product WHERE id = ?",
                s -> s.setLong(1, value.getId()), false);

    }


    @Override
    public List<Product> findByWishUserId(Long id) {

        return new ArrayList<>() {{

                getDataSource().fetch("SELECT * FROM shop_wish WHERE shop_wish.user_id = ?",
                        s -> s.setLong(1, id),
                        r -> findByPrimaryKey(r.getLong("product_id")).ifPresent(this::add));

        }};

    }


    @Override
    public List<Map.Entry<Product, Integer>> findByOrderId(Long id) {

        return new ArrayList<>() {{

                getDataSource().fetch("SELECT * FROM shop_order_product WHERE shop_order_product.order_id = ?",
                        s -> s.setLong(1, id),
                        r -> findByPrimaryKey(r.getLong("product_id"))
                                .ifPresent(p -> {
                                    try {
                                        add(new AbstractMap.SimpleImmutableEntry<>(p, r.getInt("quantity")));
                                    } catch (SQLException ignored) { }
                                })
                );

        }};

    }


}
