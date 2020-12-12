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

import java.sql.SQLException;
import java.util.LinkedList;
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
                        new LinkedList<>()
                )))
        );


        result.get().ifPresent(r -> r.getWishList()
                .addAll(getDataSource().getProductRepository().findByWishUserId(r.getId())));


        return result.get();


    }

    @Override
    public List<User> findAll() {

        final var users = new LinkedList<User>();

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
                        new LinkedList<>()
                ))
        );


        for(var user : users) {

            user.getWishList()
                    .addAll(getDataSource().getProductRepository().findByWishUserId(user.getId()));

        }

        return users;

    }

    @Override
    public void save(User value) {

    }

    @Override
    public void update(User value, Object... params) {

    }

    @Override
    public void delete(User value) {

    }


}
