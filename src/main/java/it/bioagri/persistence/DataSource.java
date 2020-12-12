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

package it.bioagri.persistence;

import it.bioagri.persistence.dao.ProductDao;
import it.bioagri.persistence.dao.UserDao;
import it.bioagri.persistence.dao.impl.ProductDaoImpl;
import it.bioagri.persistence.dao.impl.UserDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


@Component
@Scope("singleton")
public class DataSource {

    private final String uri;
    private final String username;
    private final String password;

    private final UserDao userRepository;
    private final ProductDao productRepository;


    @Autowired
    private DataSource (
            @Value("${database.uri}") String uri,
            @Value("${database.username}") String username,
            @Value("${database.password}") String password) {

        this.uri = uri;
        this.username = username;
        this.password = password;

        // TODO...
        this.userRepository = new UserDaoImpl(this);
        this.productRepository = new ProductDaoImpl(this);

    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(uri, username, password);
    }

    public UserDao getUserRepository() {
        return userRepository;
    }

    public ProductDao getProductRepository() {
        return productRepository;
    }
}
