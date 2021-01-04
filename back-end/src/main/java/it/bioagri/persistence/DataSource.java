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

import ch.qos.logback.classic.Logger;
import it.bioagri.models.User;
import it.bioagri.persistence.dao.*;
import it.bioagri.persistence.dao.impl.*;
import org.intellij.lang.annotations.Language;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.atomic.AtomicReference;


@Component
@Scope("singleton")
public class DataSource {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(DataSource.class);

    private final String uri;
    private final String username;
    private final String password;

    private final UserDao userDao;
    private final ProductDao productDao;
    private final CategoryDao categoryDao;
    private final FeedbackDao feedbackDao;
    private final OrderDao orderDao;
    private final TagDao tagDao;
    private final TicketDao ticketDao;
    private final TicketResponseDao ticketResponseDao;
    private final TransactionDao transactionDao;


    @Autowired
    private DataSource (
            @Value("${database.uri}") String uri,
            @Value("${database.username}") String username,
            @Value("${database.password}") String password) {

        this.uri = uri;
        this.username = username;
        this.password = password;

        // TODO...
        this.userDao = new UserDaoImpl(this);
        this.productDao = new ProductDaoImpl(this);
        this.categoryDao = new CategoryDaoImpl(this);
        this.feedbackDao = new FeedbackDaoImpl(this);
        this.orderDao = new OrderDaoImpl(this);
        this.tagDao = new TagDaoImpl(this);
        this.ticketDao = new TicketDaoImpl(this);
        this.ticketResponseDao = new TicketResponseDaoImpl(this);
        this.transactionDao = new TransactionDaoImpl(this);

    }

    public Connection getConnection() throws SQLException {

        var connection = DriverManager.getConnection(uri, username, password);
        connection.setAutoCommit(true);

        return connection;

    }

    public UserDao getUserDao() {
        return userDao;
    }

    public ProductDao getProductDao() {
        return productDao;
    }

    public CategoryDao getCategoryDao() {
        return categoryDao;
    }

    public FeedbackDao getFeedbackDao() {
        return feedbackDao;
    }

    public OrderDao getOrderDao() {
        return orderDao;
    }

    public TagDao getTagDao() {
        return tagDao;
    }

    public TicketDao getTicketDao() {
        return ticketDao;
    }

    public TicketResponseDao getTicketResponseDao() {
        return ticketResponseDao;
    }

    public TransactionDao getTransactionDao() {
        return transactionDao;
    }


    public void fetch(@Language("SQL") String sql, DataSourcePrepareStatement prepareStatement, DataSourceFetchResult fetchResult) {

        logger.trace("FETCH data with query '{}'", sql);


        try(var connection = getConnection();
            var statement = connection.prepareStatement(sql)) {


            if(prepareStatement != null)
                prepareStatement.prepare(statement);


            if(fetchResult != null) {

                var result = statement.executeQuery();

                while (result.next())
                    fetchResult.fetch(result);

                result.close();

            } else {

                statement.execute();

            }

        } catch (SQLException e) {
            throw new DataSourceSQLException(e);
        }

    }


    public int update(@Language("SQL") String sql, DataSourcePrepareStatement prepareStatement) {

        logger.trace("UPDATE data with query '{}'", sql);


        try(var connection = getConnection();
            var statement = connection.prepareStatement(sql)) {


            if(prepareStatement != null)
                prepareStatement.prepare(statement);

            return statement.executeUpdate();

        } catch (SQLException e) {
            throw new DataSourceSQLException(e);
        }

    }


    public <T> T getId(String ref, Class<T> type) {

        final AtomicReference<Object> result = new AtomicReference<>(null);

        fetch("SELECT nextval(pg_get_serial_sequence('%s', 'id')) AS id".formatted(ref), null,
                r -> result.set(r.getObject("id")));


        return type.cast(result.get());

    }


    public User authenticate(String username, String password) {

        final AtomicReference<User> result = new AtomicReference<>(null);


        fetch("SELECT id FROM shop_user WHERE email = ? AND password = ?",
                s -> {
                    s.setString(1, username);
                    s.setString(2, password);
                },
                r -> {
                    getUserDao().findByPrimaryKey(r.getLong("id"))
                            .ifPresent(result::set);
                }
        );


        return result.get();

    }

}
