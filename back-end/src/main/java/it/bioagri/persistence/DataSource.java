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
import it.bioagri.api.auth.AuthLogin;
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

    private final UserDao userRepository;
    private final ProductDao productRepository;
    private final CategoryDao categoryRepository;
    private final FeedbackDao feedbackRepository;
    private final OrderDao orderRepository;
    private final TagDao tagRepository;
    private final TicketDao ticketRepository;
    private final TicketResponseDao ticketResponseRepository;
    private final TransactionDao transactionRepository;


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
        this.categoryRepository = new CategoryDaoImpl(this);
        this.feedbackRepository = new FeedbackDaoImpl(this);
        this.orderRepository = new OrderDaoImpl(this);
        this.tagRepository = new TagDaoImpl(this);
        this.ticketRepository = new TicketDaoImpl(this);
        this.ticketResponseRepository = new TicketResponseDaoImpl(this);
        this.transactionRepository = new TransactionDaoImpl(this);

    }

    public Connection getConnection() throws SQLException {

        var connection = DriverManager.getConnection(uri, username, password);
        connection.setAutoCommit(true);

        return connection;

    }

    public UserDao getUserRepository() {
        return userRepository;
    }

    public ProductDao getProductRepository() {
        return productRepository;
    }

    public CategoryDao getCategoryRepository() {
        return categoryRepository;
    }

    public FeedbackDao getFeedbackRepository() {
        return feedbackRepository;
    }

    public OrderDao getOrderRepository() {
        return orderRepository;
    }

    public TagDao getTagRepository() {
        return tagRepository;
    }

    public TicketDao getTicketRepository() {
        return ticketRepository;
    }

    public TicketResponseDao getTicketResponseRepository() {
        return ticketResponseRepository;
    }

    public TransactionDao getTransactionRepository() {
        return transactionRepository;
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


    public User authenticate(AuthLogin authLogin) {

        final AtomicReference<User> result = new AtomicReference<>(null);


        fetch("SELECT id FROM shop_user WHERE email = ? AND password = ?",
                s -> {
                    s.setString(1, authLogin.getUsername());
                    s.setString(2, authLogin.getPassword());
                },
                r -> {
                    getUserRepository().findByPrimaryKey(r.getLong("id"))
                            .ifPresent(result::set);
                }
        );


        return result.get();

    }

}
