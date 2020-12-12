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

import it.bioagri.models.User;
import it.bioagri.models.UserGender;
import it.bioagri.models.UserRole;
import it.bioagri.models.UserStatus;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.UserDao;

import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class UserDaoImpl extends UserDao {

    public UserDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<User> findByPrimaryKey(Long id) throws SQLException {
        
        try(var connection = getDataSource().getConnection()) {
            
            var statement = connection.prepareStatement(
                    "SELECT * FROM shop_user  WHERE shop_user.id = ?"
            );

            statement.setLong(1, id);



            var result = statement.executeQuery();

            if(result.next()) {

                var user = new User(
                        result.getLong("id"),
                        result.getString("email"),
                        result.getString("password"),
                        UserStatus.values()[result.getShort("status")],
                        UserRole.values()[result.getShort("role")],
                        result.getString("name"),
                        result.getString("surname"),
                        UserGender.values()[result.getShort("gender")],
                        result.getString("phone"),
                        result.getDate("birth"),
                        result.getTimestamp("created_at"),
                        result.getTimestamp("updated_at"),
                        new LinkedList<>()
                );


                user.getWishList().addAll(getDataSource()
                        .getProductRepository()
                        .findByWishUserId(id)
                );


                return Optional.of(user);


            }

            return Optional.empty();
            
        }

    }

    @Override
    public List<User> findAll() {
        return null;
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
