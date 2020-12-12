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

package it.bioagri.api.tags;

import it.bioagri.api.*;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Tag;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/tags")
public class Tags {

    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public Tags(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @GetMapping("")
    public ResponseEntity<List<Tag>> findAll() {

        authToken.checkPermission(ApiPermissionType.TAGS, ApiPermissionOperation.READ);

        try {
            return new ResponseEntity<>(dataSource.getTagRepository().findAll(), HttpStatus.OK);
        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

    }

    @GetMapping("/{id}")
    public ResponseEntity<Tag> findById(@PathVariable Long id) {

        authToken.checkPermission(ApiPermissionType.TAGS, ApiPermissionOperation.READ);

        try {

            return new ResponseEntity<>(dataSource.getTagRepository()
                    .findByPrimaryKey(id)
                    .orElseThrow(() -> new ApiException(ApiExceptionType.ERROR_RESOURCE_NOT_FOUND, String.format("requested tag id not found: %s", id), HttpStatus.NOT_FOUND)), HttpStatus.OK);

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

    }


    @PostMapping("")
    public ResponseEntity<String> create(@RequestBody Tag tag) {

        authToken.checkPermission(ApiPermissionType.TAGS, ApiPermissionOperation.UPDATE);


        tag.setId(dataSource.getId("shop_tag"));

        try {
            dataSource.getTagRepository().save(tag);
        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

        return ResponseEntity.created(URI.create(String.format("/api/tags/%d", tag.getId()))).build();

    }


    @PutMapping("/{id}")
    public ResponseEntity<String> update(@PathVariable Long id, @RequestBody Tag tag) {

        authToken.checkPermission(ApiPermissionType.TAGS, ApiPermissionOperation.UPDATE);

        try {

            tag.setId(dataSource.getId("shop_tag"));

            dataSource.getTagRepository().findByPrimaryKey(id)
                    .ifPresentOrElse(
                            (r) -> dataSource.getTagRepository().update(r, tag),
                            ( ) -> dataSource.getTagRepository().save(tag)
                    );

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

        return ResponseEntity.created(URI.create(String.format("/api/tags/%d", id))).build();

    }


    @DeleteMapping("")
    public ResponseEntity<String> deleteAll() {

        authToken.checkPermission(ApiPermissionType.TAGS, ApiPermissionOperation.DELETE);

        try {

            dataSource.getTagRepository().findAll()
                    .forEach(dataSource.getTagRepository()::delete);

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

        return ResponseEntity.noContent().build();

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Long id) {

        authToken.checkPermission(ApiPermissionType.TAGS, ApiPermissionOperation.DELETE);

        try {

            dataSource.getTagRepository().delete(
                    dataSource.getTagRepository()
                            .findByPrimaryKey(id)
                            .orElseThrow(() -> new ApiException(ApiExceptionType.ERROR_RESOURCE_NOT_FOUND, String.format("requested tag id not found: %s", id), HttpStatus.NOT_FOUND))
            );

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

        return ResponseEntity.noContent().build();

    }



}
