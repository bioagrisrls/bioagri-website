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
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class ProductDaoImpl extends ProductDao {

    public ProductDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<Product> findByPrimaryKey(Long id) throws SQLException {

        try(var connection = getDataSource().getConnection()) {

            var statement = connection.prepareStatement (
                    """
                        SELECT * FROM shop_product,
                                      shop_product_category
                        WHERE shop_product.id = ?
                          AND shop_product_category.product_id = shop_product.id
                    """
            );

            statement.setLong(1, id);


            var result = statement.executeQuery();

            if(result.next()) {

                var product = new Product(
                        result.getLong("id"),
                        result.getString("name"),
                        result.getString("description"),
                        result.getFloat("price"),
                        result.getInt("quantity"),
                        ProductStatus.values()[result.getShort("status")],
                        result.getTimestamp("updated_at"),
                        result.getTimestamp("created_at"),
                        new LinkedList<>(),
                        new LinkedList<>(),
                        new LinkedList<>()
                );


                do {

                    getDataSource().getCategoryRepository()
                            .findByPrimaryKey(result.getLong("category_id"))
                            .ifPresent(product.getCategories()::add);


                } while (result.next());
//
//
//                product.getTags().addAll(getDataSource()
//                        .getTagRepository()
//                        .findByProductId(id)
//                );
//
//                product.getFeedbacks().addAll(getDataSource()
//                        .getFeedbackRepository()
//                        .findByProductId(id)
//                );


                return Optional.of(product);


            }

            return Optional.empty();

        }
    }

    @Override
    public List<Product> findAll() throws SQLException {
        return null;
    }

    @Override
    public void save(Product value) throws SQLException {

    }

    @Override
    public void update(Product value, Object... params) throws SQLException {

    }

    @Override
    public void delete(Product value) throws SQLException {

    }

    @Override
    public List<Product> findByWishUserId(Long id) throws SQLException {

        var products = new LinkedList<Product>();


        try(var connection = getDataSource().getConnection()) {

            var statement = connection.prepareStatement(
                    "SELECT * FROM shop_wish WHERE shop_wish.user_id = ?"
            );

            statement.setLong(1, id);


            var result = statement.executeQuery();

            while (result.next())
                findByPrimaryKey(result.getLong("product_id")).ifPresent(products::add);

        }

        return products;

    }
}
