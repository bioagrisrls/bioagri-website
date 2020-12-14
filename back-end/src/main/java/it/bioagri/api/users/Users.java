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

package it.bioagri.api.users;


import it.bioagri.api.ApiPermission;
import it.bioagri.api.ApiPermissionOperation;
import it.bioagri.api.ApiPermissionType;
import it.bioagri.api.ApiResponseStatus;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.User;
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
@RequestMapping("/api/users")
public class Users {


    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public Users(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @GetMapping("")
    public ResponseEntity<List<User>> findAll() {

        try {

            return ResponseEntity.ok(
                    dataSource.getUserRepository()
                            .findAll()
                            .stream()
                            .filter(i -> ApiPermission.hasPermission(ApiPermissionType.USERS, ApiPermissionOperation.READ, authToken, i.getId()))
                            .collect(Collectors.toList()));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @GetMapping("/{id}")
    public ResponseEntity<User> findById(@PathVariable Long id) {

        try {

            return ResponseEntity.ok(dataSource.getUserRepository()
                    .findByPrimaryKey(id)
                    .filter(i -> ApiPermission.hasPermission(ApiPermissionType.USERS, ApiPermissionOperation.READ, authToken, i.getId()))
                    .orElseThrow(() -> new ApiResponseStatus(404)));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


    @PostMapping("")
    public ResponseEntity<String> create(@RequestBody User user) {

        ApiPermission.verify(ApiPermissionType.USERS, ApiPermissionOperation.CREATE, authToken, user.getId());

        try {

            user.setId(dataSource.getId("shop_user", Long.class));

            dataSource.getUserRepository().save(user);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/users/%d", user.getId()))).build();

    }


    @PutMapping("/{id}")
    public ResponseEntity<String> update(@PathVariable Long id, @RequestBody User user) {

        ApiPermission.verify(ApiPermissionType.USERS, ApiPermissionOperation.UPDATE, authToken, user.getId());

        try {

            user.setId(dataSource.getId("shop_user", Long.class));

            dataSource.getUserRepository().findByPrimaryKey(id)
                    .ifPresentOrElse(
                            (r) -> dataSource.getUserRepository().update(r, user),
                            ( ) -> dataSource.getUserRepository().save(user)
                    );

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/users/%d", id))).build();

    }


    @DeleteMapping("")
    public ResponseEntity<String> deleteAll() {

        try {

            dataSource.getUserRepository()
                    .findAll()
                    .stream()
                    .filter(i -> ApiPermission.hasPermission(ApiPermissionType.USERS, ApiPermissionOperation.DELETE, authToken, i.getId()))
                    .forEach(dataSource.getUserRepository()::delete);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Long id) {

        try {

            dataSource.getUserRepository().delete(
                    dataSource.getUserRepository()
                            .findByPrimaryKey(id)
                            .filter(i -> ApiPermission.hasPermission(ApiPermissionType.USERS, ApiPermissionOperation.DELETE, authToken, i.getId()))
                            .orElseThrow(() -> new ApiResponseStatus(404)));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }

}
