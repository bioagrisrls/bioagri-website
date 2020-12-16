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

package it.bioagri.api.categories;

import it.bioagri.api.ApiPermission;
import it.bioagri.api.ApiPermissionOperation;
import it.bioagri.api.ApiPermissionType;
import it.bioagri.api.ApiResponseStatus;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Category;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;


@RestController
@RequestMapping("/api/categories")
public class Categories {

    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public Categories(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @GetMapping("")
    public ResponseEntity<List<Category>> findAll() {

        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.READ, authToken);

        try {
            return ResponseEntity.ok(dataSource.getCategoryRepository().findAll());
        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


    @GetMapping("/{id}")
    public ResponseEntity<Category> findById(@PathVariable Long id) {

        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.READ, authToken);

        try {

            return ResponseEntity.ok(dataSource.getCategoryRepository()
                    .findByPrimaryKey(id)
                    .orElseThrow(() -> new ApiResponseStatus(404)));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


    @PostMapping("")
    public ResponseEntity<String> create(@RequestBody Category category) {

        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.CREATE, authToken);

        try {

            category.setId(dataSource.getId("shop_category", Long.class));

            dataSource.getCategoryRepository().save(category);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/categories/%d", category.getId()))).build();

    }


    @PutMapping("/{id}")
    public ResponseEntity<String> update(@PathVariable Long id, @RequestBody Category category) {

        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.UPDATE, authToken);

        try {

            category.setId(dataSource.getId("shop_category", Long.class));

            dataSource.getCategoryRepository().findByPrimaryKey(id)
                    .ifPresentOrElse(
                            (r) -> dataSource.getCategoryRepository().update(r, category),
                            ( ) -> dataSource.getCategoryRepository().save(category)
                    );

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/categories/%d", id))).build();

    }


    @DeleteMapping("")
    public ResponseEntity<String> deleteAll() {

        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.DELETE, authToken);

        try {

            dataSource.getCategoryRepository().findAll()
                    .forEach(dataSource.getCategoryRepository()::delete);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Long id) {

        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.DELETE, authToken);

        try {

            dataSource.getCategoryRepository().delete(
                    dataSource.getCategoryRepository()
                            .findByPrimaryKey(id)
                            .orElseThrow(() -> new ApiResponseStatus(404)));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }

}
