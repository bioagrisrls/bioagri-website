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

package it.bioagri.api.orders;

import it.bioagri.api.*;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Order;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class Orders {


    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public Orders(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @GetMapping("")
    public ResponseEntity<List<Order>> findAll() {

        authToken.checkPermission(ApiPermissionType.ORDERS, ApiPermissionOperation.READ);

        try {
            return new ResponseEntity<>(dataSource.getOrderRepository().findAll(), HttpStatus.OK);
        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

    }

    @GetMapping("/{id}")
    public ResponseEntity<Order> findById(@PathVariable Long id) {

        authToken.checkPermission(ApiPermissionType.ORDERS, ApiPermissionOperation.READ);

        try {

            return new ResponseEntity<>(dataSource.getOrderRepository()
                    .findByPrimaryKey(id)
                    .orElseThrow(() -> new ApiException(ApiExceptionType.ERROR_RESOURCE_NOT_FOUND, String.format("requested order id not found: %s", id), HttpStatus.NOT_FOUND)), HttpStatus.OK);

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

    }


    @PostMapping("")
    public ResponseEntity<String> create(@RequestBody Order order) {

        authToken.checkPermission(ApiPermissionType.ORDERS, ApiPermissionOperation.UPDATE);


        order.setId(dataSource.getId("shop_order"));

        try {
            dataSource.getOrderRepository().save(order);
        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

        return ResponseEntity.created(URI.create(String.format("/api/orders/%d", order.getId()))).build();

    }


    @PutMapping("/{id}")
    public ResponseEntity<String> update(@PathVariable Long id, @RequestBody Order order) {

        authToken.checkPermission(ApiPermissionType.ORDERS, ApiPermissionOperation.UPDATE);

        try {

            order.setId(dataSource.getId("shop_order"));

            dataSource.getOrderRepository().findByPrimaryKey(id)
                    .ifPresentOrElse(
                            (r) -> dataSource.getOrderRepository().update(r, order),
                            ( ) -> dataSource.getOrderRepository().save(order)
                    );

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

        return ResponseEntity.created(URI.create(String.format("/api/orders/%d", id))).build();

    }


    @DeleteMapping("")
    public ResponseEntity<String> deleteAll() {

        authToken.checkPermission(ApiPermissionType.ORDERS, ApiPermissionOperation.DELETE);

        try {

            dataSource.getOrderRepository().findAll()
                    .forEach(dataSource.getOrderRepository()::delete);

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

        return ResponseEntity.noContent().build();

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Long id) {

        authToken.checkPermission(ApiPermissionType.ORDERS, ApiPermissionOperation.DELETE);

        try {

            dataSource.getOrderRepository().delete(
                    dataSource.getOrderRepository()
                            .findByPrimaryKey(id)
                            .orElseThrow(() -> new ApiException(ApiExceptionType.ERROR_RESOURCE_NOT_FOUND, String.format("requested order id not found: %s", id), HttpStatus.NOT_FOUND))
            );

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

        return ResponseEntity.noContent().build();

    }


}