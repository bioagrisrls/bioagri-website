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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import it.bioagri.api.*;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Category;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import it.bioagri.utils.ApiUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;
import java.util.stream.Collectors;


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


    @Operation(description = "Retrieve all category resources")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Category resources collection"),
    })
    @GetMapping("")
    @ApiPermissionPublic
    public ResponseEntity<List<Category>> findAll(
            @RequestParam(required = false, defaultValue =   "0") Long skip,
            @RequestParam(required = false, defaultValue = "999") Long limit,
            @RequestParam(required = false, value =  "filter-by") List<String> filterBy,
            @RequestParam(required = false, value = "filter-val") List<String> filterValue,
            @RequestParam(required = false, defaultValue = "asc") String order,
            @RequestParam(required = false, value =  "sorted-by") String sortedBy) {


        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.READ, authToken);

        try {

            return ResponseEntity.ok(
                    dataSource.getCategoryRepository()
                            .findAll()
                            .stream()
                            .filter(i -> ApiUtils.filterBy(filterBy, filterValue, i, dataSource))
                            .sorted((a, b) -> ApiUtils.sortedBy(sortedBy, order, a, b))
                            .skip(skip)
                            .limit(limit)
                            .collect(Collectors.toList()));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


    @Operation(description = "Retrieve a specific category resource")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Category resource"),
            @ApiResponse(responseCode = "404", description = "Category id not found"),
    })
    @GetMapping("/{id}")
    @ApiPermissionPublic
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


    @Operation(description = "Create a new category resource")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Category created"),
    })
    @PostMapping("")
    public ResponseEntity<String> create(@RequestBody Category category) {

        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.CREATE, authToken);

        try {

            category.setId(dataSource.getId("shop_category", Long.class));

            dataSource.getCategoryRepository().save(category);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create("/api/categories/%d".formatted(category.getId()))).build();

    }


    @Operation(description = "Create or update a new category resource")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Category created or updated"),
    })
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

        return ResponseEntity.created(URI.create("/api/categories/%d".formatted(id))).build();

    }


    @Operation(description = "Delete all category resources")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "All category resources deleted"),
    })
    @DeleteMapping("")
    public ResponseEntity<String> deleteAll(
            @RequestParam(required = false, value =  "filter-by") List<String> filterBy,
            @RequestParam(required = false, value = "filter-val") List<String> filterValue) {


        ApiPermission.verifyOrThrow(ApiPermissionType.CATEGORIES, ApiPermissionOperation.DELETE, authToken);

        try {

            dataSource.getCategoryRepository().findAll()
                    .stream()
                    .filter(i -> ApiUtils.filterBy(filterBy, filterValue, i, dataSource))
                    .forEach(dataSource.getCategoryRepository()::delete);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }



    @Operation(description = "Delete a specific category resource")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Category deleted"),
    })
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
