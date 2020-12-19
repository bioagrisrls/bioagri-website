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

package it.bioagri.api.products;


import it.bioagri.api.ApiPermission;
import it.bioagri.api.ApiPermissionOperation;
import it.bioagri.api.ApiPermissionType;
import it.bioagri.api.ApiResponseStatus;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Category;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import it.bioagri.utils.ApiUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/api/products")
public class ProductCategories {

    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public ProductCategories(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @GetMapping("/{sid}/categories")
    public ResponseEntity<List<Category>> findAll(
            @PathVariable Long sid,
            @RequestParam(required = false, defaultValue =   "0") Long skip,
            @RequestParam(required = false, defaultValue = "999") Long limit,
            @RequestParam(required = false, value =  "filter-by") String filterBy,
            @RequestParam(required = false, value = "filter-val") String filterValue) {


        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.READ, authToken);
        ApiPermission.verifyOrThrow(ApiPermissionType.PRODUCTS, ApiPermissionOperation.READ, authToken);

        try {

            return ResponseEntity.ok(dataSource.getProductRepository()
                    .findByPrimaryKey(sid)
                    .orElseThrow(() -> new ApiResponseStatus(400))
                    .getCategories(dataSource)
                    .stream()
                    .filter(i -> ApiUtils.filterBy(filterBy, filterValue, i))
                    .skip(skip)
                    .limit(limit)
                    .collect(Collectors.toList()));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @PutMapping("/{sid}/categories/{id}")
    public ResponseEntity<String> update(@PathVariable Long sid, @PathVariable Long id) {

        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.READ, authToken);
        ApiPermission.verifyOrThrow(ApiPermissionType.PRODUCTS, ApiPermissionOperation.UPDATE, authToken);

        try {

            dataSource.getProductRepository().addCategory(
                    dataSource.getProductRepository()
                            .findByPrimaryKey(sid)
                            .orElseThrow(() -> new ApiResponseStatus(400)),
                    dataSource.getCategoryRepository()
                            .findByPrimaryKey(id)
                            .orElseThrow(() -> new ApiResponseStatus(404))
            );

            return ResponseEntity.ok().build();

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


    @DeleteMapping("/{sid}/categories/{id}")
    public ResponseEntity<String> delete(@PathVariable Long sid, @PathVariable Long id) {

        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.READ, authToken);
        ApiPermission.verifyOrThrow(ApiPermissionType.PRODUCTS, ApiPermissionOperation.UPDATE, authToken);

        try {


            dataSource.getProductRepository().removeCategory(
                    dataSource.getProductRepository()
                        .findByPrimaryKey(sid)
                        .orElseThrow(() -> new ApiResponseStatus(400)),
                    dataSource.getCategoryRepository()
                        .findByPrimaryKey(id)
                        .orElseThrow(() -> new ApiResponseStatus(404))
            );


            return ResponseEntity.ok().build();

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

}

