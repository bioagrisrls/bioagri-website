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

import it.bioagri.api.ApiPermission;
import it.bioagri.api.ApiPermissionOperation;
import it.bioagri.api.ApiPermissionType;
import it.bioagri.api.ApiResponseStatus;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Transaction;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/orders")
public class Transactions {


    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public Transactions(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @GetMapping("/{sid}/transactions")
    public ResponseEntity<List<Transaction>> findAll(@PathVariable Long sid) {

        try {

            return ResponseEntity.ok(dataSource.getTransactionRepository()
                    .findAll()
                    .stream()
                    .filter(i -> i.getOrderId().equals(sid))
                    .filter(i -> ApiPermission.hasPermission(ApiPermissionType.TRANSACTIONS, ApiPermissionOperation.READ, authToken, i.getOrder(dataSource)
                            .orElseThrow(() -> new ApiResponseStatus(502))
                            .getUserId()))
                    .collect(Collectors.toList()));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @GetMapping("/{sid}/transactions/{id}")
    public ResponseEntity<Transaction> findById(@PathVariable Long sid, @PathVariable Long id) {

        try {

            return ResponseEntity.ok(dataSource.getTransactionRepository()
                    .findByPrimaryKey(id)
                    .filter(i -> i.getOrderId().equals(sid))
                    .filter(i -> ApiPermission.hasPermission(ApiPermissionType.TRANSACTIONS, ApiPermissionOperation.READ, authToken, i.getOrder(dataSource)
                            .orElseThrow(() -> new ApiResponseStatus(502))
                            .getUserId()))
                    .orElseThrow(() -> new ApiResponseStatus(404)));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


    @PostMapping("/{sid}/transactions")
    public ResponseEntity<String> create(@PathVariable Long sid, @RequestBody Transaction transaction) {

        ApiPermission.verify(ApiPermissionType.TRANSACTIONS, ApiPermissionOperation.CREATE, authToken, transaction.getOrder(dataSource)
                .orElseThrow(() -> new ApiResponseStatus(404))
                .getUserId());

        try {

            transaction.setId(dataSource.getId("shop_transaction", Long.class));

            dataSource.getTransactionRepository().save(transaction);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/orders/%d/transactions/%d", sid, transaction.getId()))).build();

    }


    @PutMapping("/{sid}/transactions/{id}")
    public ResponseEntity<String> update(@PathVariable Long sid, @PathVariable Long id, @RequestBody Transaction transaction) {

        ApiPermission.verify(ApiPermissionType.TRANSACTIONS, ApiPermissionOperation.UPDATE, authToken, transaction.getOrder(dataSource)
                .orElseThrow(() -> new ApiResponseStatus(404))
                .getUserId());

        try {

            transaction.setId(dataSource.getId("shop_transaction", Long.class));

            dataSource.getTransactionRepository().findByPrimaryKey(id)
                    .ifPresentOrElse(
                            (r) -> dataSource.getTransactionRepository().update(r, transaction),
                            ( ) -> dataSource.getTransactionRepository().save(transaction)
                    );

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/orders/%d/transactions/%d", sid, transaction.getId()))).build();

    }


    @DeleteMapping("/{sid}/transactions")
    public ResponseEntity<String> deleteAll(@PathVariable Long sid) {

        try {

            dataSource.getTransactionRepository()
                    .findAll()
                    .stream()
                    .filter(i -> i.getOrderId().equals(sid))
                    .filter(i -> ApiPermission.hasPermission(ApiPermissionType.TRANSACTIONS, ApiPermissionOperation.DELETE, authToken, i.getOrder(dataSource)
                            .orElseThrow(() -> new ApiResponseStatus(502))
                            .getUserId()))
                    .forEach(dataSource.getTransactionRepository()::delete);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }


    @DeleteMapping("/{sid}/transactions/{id}")
    public ResponseEntity<String> delete(@PathVariable Long sid, @PathVariable Long id) {

        try {

            dataSource.getTransactionRepository().delete(
                    dataSource.getTransactionRepository()
                            .findByPrimaryKey(id)
                            .filter(i -> i.getOrderId().equals(sid))
                            .filter(i -> ApiPermission.hasPermission(ApiPermissionType.TRANSACTIONS, ApiPermissionOperation.DELETE, authToken, i.getOrder(dataSource)
                                    .orElseThrow(() -> new ApiResponseStatus(502))
                                    .getUserId()))
                            .orElseThrow(() -> new ApiResponseStatus(404)));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }

}