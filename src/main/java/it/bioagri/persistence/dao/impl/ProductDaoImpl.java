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
                            new LinkedList<>(),
                            new LinkedList<>(),
                            new LinkedList<>()
                    );


                    do {

                        getDataSource().getCategoryRepository()
                                .findByPrimaryKey(r.getLong("category_id"))
                                .ifPresent(product.getCategories()::add);


                    } while (r.next());


                    result.set(Optional.of(product));

                }

        );


        // TODO: fetch tags & feedbacks for product.

//        result.get().ifPresent(r -> r.getTags()
//                .addAll(getDataSource().getTagRepository().findByProductId(r.getId())));
//
//        result.get().ifPresent(r -> r.getFeedbacks()
//                .addAll(getDataSource().getFeedbackRepository().findByProductId(r.getId())));


        return result.get();

    }

    @Override
    public List<Product> findAll() {

        final var products = new LinkedList<Product>();

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
                        new LinkedList<>(),
                        new LinkedList<>(),
                        new LinkedList<>()
                ))
        );


        // TODO: fetch tags & feedbacks for product.

//        for(var product : products) {
//
//            product.getTags()
//                    .addAll(getDataSource().getTagRepository().findByProductId(product.getId()));
//
//            product.getFeedbacks()
//                    .addAll(getDataSource().getFeedbackRepository().findByProductId(product.getId()));
//
//        }


        return products;

    }

    @Override
    public void save(Product value) {

    }

    @Override
    public void update(Product oldValue, Product newValue) {

    }

    @Override
    public void delete(Product value) {

    }


    @Override
    public List<Product> findByWishUserId(Long id) {

        var products = new LinkedList<Product>();

        getDataSource().fetch("SELECT * FROM shop_wish WHERE shop_wish.user_id = ?",
                s -> s.setLong(1, id),
                r -> findByPrimaryKey(r.getLong("product_id")).ifPresent(products::add));

        return products;

    }


    @Override
    public Map<Product, Integer> findByOrderId(Long id) {

        var products = new HashMap<Product, Integer>();

        getDataSource().fetch("SELECT * FROM shop_order_product WHERE shop_order_product.order_id = ?",
                s -> s.setLong(1, id),
                r -> findByPrimaryKey(r.getLong("product_id"))
                        .ifPresent(p -> {
                            try {
                                products.put(p, r.getInt("quantity"));
                            } catch (SQLException ignored) { }
                        })
        );

        return products;

    }


}
