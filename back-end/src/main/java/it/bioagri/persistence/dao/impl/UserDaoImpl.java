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

import it.bioagri.models.*;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.UserDao;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;


public class UserDaoImpl extends UserDao {

    public UserDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<User> findByPrimaryKey(Long id) {

        final AtomicReference<Optional<User>> result = new AtomicReference<>(Optional.empty());

        getDataSource().fetch("SELECT * FROM shop_user WHERE shop_user.id = ?",
                s -> s.setLong(1, id),
                r -> result.set(Optional.of(new User(
                        r.getLong("id"),
                        r.getString("email"),
                        r.getString("password"),
                        UserStatus.values()[r.getShort("status")],
                        UserRole.values()[r.getShort("role")],
                        r.getString("name"),
                        r.getString("surname"),
                        UserGender.values()[r.getShort("gender")],
                        r.getString("phone"),
                        r.getDate("birth"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        null,
                        null,
                        null
                )))
        );

        return result.get();

    }

    @Override
    public List<User> findAll() {

        final var users = new ArrayList<User>();

        getDataSource().fetch("SELECT * FROM shop_user", null,
                r -> users.add(new User(
                        r.getLong("id"),
                        r.getString("email"),
                        r.getString("password"),
                        UserStatus.values()[r.getShort("status")],
                        UserRole.values()[r.getShort("role")],
                        r.getString("name"),
                        r.getString("surname"),
                        UserGender.values()[r.getShort("gender")],
                        r.getString("phone"),
                        r.getDate("birth"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        null,
                        null,
                        null
                ))
        );

        return users;

    }

    @Override
    public void save(User value) {

        getDataSource().update(
                """
                    INSERT INTO shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at) 
                                   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """,
                    s -> {
                        s.setLong(1, value.getId());
                        s.setString(2, value.getMail());
                        s.setString(3, value.getPassword());
                        s.setShort(4, (short) value.getStatus().ordinal());
                        s.setShort(5, (short) value.getRole().ordinal());
                        s.setString(6, value.getName());
                        s.setString(7, value.getSurname());
                        s.setShort(8, (short) value.getGender().ordinal());
                        s.setString(9, value.getPhone());
                        s.setString(10, value.getPhone());
                        s.setDate(11, value.getBirth());
                        s.setTimestamp(12, value.getCreatedAt());
                        s.setTimestamp(13, value.getUpdatedAt());
                    });


        for(var i : value.getWishList(getDataSource())) {

            getDataSource().update(
                    """
                    INSERT INTO shop_wish (user_id, product_id) 
                                   VALUES (?, ?)
                    """,
                    s -> {
                        s.setLong(1, value.getId());
                        s.setLong(2, i.getId());
                    });

        }

    }

    @Override
    public void update(User oldValue, User newValue) {

        getDataSource().update(
                """
                    UPDATE shop_user 
                       SET email = ?, password = ?, status = ?, role = ?, name = ?, surname = ?, gender = ?, phone = ?, birth = ?, created_at = ?, updated_at = ?
                     WHERE id = ?
                    """,
                    s -> {
                        s.setString(1, newValue.getMail());
                        s.setString(2, newValue.getPassword());
                        s.setShort(3, (short) newValue.getStatus().ordinal());
                        s.setShort(4, (short) newValue.getRole().ordinal());
                        s.setString(5, newValue.getName());
                        s.setString(6, newValue.getSurname());
                        s.setShort(7, (short) newValue.getGender().ordinal());
                        s.setString(8, newValue.getPhone());
                        s.setString(9, newValue.getPhone());
                        s.setDate(10, newValue.getBirth());
                        s.setTimestamp(11, newValue.getCreatedAt());
                        s.setTimestamp(12, newValue.getUpdatedAt());
                        s.setLong(13, oldValue.getId());
                    });


    }

    @Override
    public void delete(User value) {

        getDataSource().update("DELETE FROM shop_user WHERE id = ?",
                s -> s.setLong(1, value.getId()));

    }

    @Override
    public void addWishList(User user, Product product) {

        getDataSource().update(
                """
                INSERT INTO shop_wish (user_id, product_id) 
                               VALUES (?, ?)
                """,
                s -> {
                    s.setLong(1, user.getId());
                    s.setLong(2, product.getId());
                });


        user.getWishList(getDataSource()).add(product);

    }

    @Override
    public void removeWishList(User user, Product product) {

        getDataSource().update(
                """
                DELETE FROM shop_wish 
                      WHERE user_id = ?
                        AND product_id = ?
                """,
                s -> {
                    s.setLong(1, user.getId());
                    s.setLong(2, product.getId());
                });


        user.getWishList(getDataSource()).remove(product);

    }
}
