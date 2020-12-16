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
import it.bioagri.models.Product;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;


@RestController
@RequestMapping("/api/users")
public class WishList {

    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public WishList(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }

    @GetMapping("/{sid}/wishlist")
    public ResponseEntity<List<Product>> findAll(@PathVariable Long sid) {

        ApiPermission.verifyOrThrow(ApiPermissionType.WISHLIST, ApiPermissionOperation.READ, authToken, sid);

        try {

            return ResponseEntity.ok(dataSource.getUserRepository()
                    .findByPrimaryKey(sid)
                    .orElseThrow(() -> new ApiResponseStatus(400))
                    .getWishList(dataSource));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @GetMapping("/{sid}/wishlist/{id}")
    public ResponseEntity<Product> findById(@PathVariable Long sid, @PathVariable Long id) {

        ApiPermission.verifyOrThrow(ApiPermissionType.WISHLIST, ApiPermissionOperation.READ, authToken, sid);

        try {

            return ResponseEntity.ok(dataSource.getUserRepository()
                    .findByPrimaryKey(sid)
                    .orElseThrow(() -> new ApiResponseStatus(400))
                    .getWishList(dataSource)
                    .stream()
                    .filter(i -> id.equals(i.getId()))
                    .findFirst()
                    .orElseThrow(() -> new ApiResponseStatus(404)));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


    @PostMapping("/{sid}/wishlist")
    public ResponseEntity<String> create(@PathVariable Long sid, @RequestBody Product product) {

        ApiPermission.verifyOrThrow(ApiPermissionType.WISHLIST, ApiPermissionOperation.CREATE, authToken, sid);

        try {

            var u = dataSource.getUserRepository()
                    .findByPrimaryKey(sid)
                    .orElseThrow(() -> new ApiResponseStatus(400));

            var p = dataSource.getProductRepository()
                    .findByPrimaryKey(product.getId())
                    .orElseThrow(() -> new ApiResponseStatus(404));


            u.getWishList(dataSource).add(p);
            dataSource.getUserRepository().update(u, u);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/users/%d/wishlist/%d", sid, product.getId()))).build();

    }


    @PutMapping("/{sid}/wishlist/{id}")
    public ResponseEntity<String> update(@PathVariable Long sid, @PathVariable Long id, @RequestBody Product product) {

        ApiPermission.verifyOrThrow(ApiPermissionType.WISHLIST, ApiPermissionOperation.UPDATE, authToken, sid);

        try {


            var u = dataSource.getUserRepository()
                    .findByPrimaryKey(sid)
                    .orElseThrow(() -> new ApiResponseStatus(400));

            var p = dataSource.getProductRepository()
                    .findByPrimaryKey(product.getId())
                    .orElseThrow(() -> new ApiResponseStatus(404));


            u.getWishList(dataSource)
                .stream()
                .filter(i -> i.getId().equals(id))
                .findFirst()
                .ifPresent(u.getWishList(dataSource)::remove);

            u.getWishList(dataSource).add(p);
            dataSource.getUserRepository().update(u, u);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/users/%d/wishlist/%d", sid, product.getId()))).build();

    }


    @DeleteMapping("/{sid}/wishlist")
    public ResponseEntity<String> deleteAll(@PathVariable Long sid) {

        ApiPermission.verifyOrThrow(ApiPermissionType.WISHLIST, ApiPermissionOperation.DELETE, authToken, sid);

        try {

            var u = dataSource.getUserRepository()
                    .findByPrimaryKey(sid)
                    .orElseThrow(() -> new ApiResponseStatus(400));

            u.getWishList(dataSource).clear();
            dataSource.getUserRepository().update(u, u);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }


    @DeleteMapping("/{sid}/wishlist/{id}")
    public ResponseEntity<String> delete(@PathVariable Long sid, @PathVariable Long id) {

        ApiPermission.verifyOrThrow(ApiPermissionType.WISHLIST, ApiPermissionOperation.DELETE, authToken, sid);

        try {

            var u = dataSource.getUserRepository()
                    .findByPrimaryKey(sid)
                    .orElseThrow(() -> new ApiResponseStatus(400));

            var p = u.getWishList(dataSource)
                    .stream()
                    .filter(i -> i.getId().equals(id))
                    .findFirst()
                    .orElseThrow(() -> new ApiResponseStatus(404));

            u.getWishList(dataSource).remove(p);
            dataSource.getUserRepository().update(u, u);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }

}
