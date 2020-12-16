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
import it.bioagri.models.Product;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.AbstractMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/api/orders")
public class OrderProducts {

    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public OrderProducts(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }

    @GetMapping("/{sid}/products")
    public ResponseEntity<List<Map.Entry<Product, Integer>>> findAll(@PathVariable Long sid) {

        try {

            return ResponseEntity.ok(dataSource.getOrderRepository()
                    .findByPrimaryKey(sid)
                    .filter(i -> ApiPermission.hasPermission(ApiPermissionType.ORDER_PRODUCTS, ApiPermissionOperation.READ, authToken, i.getUserId()))
                    .orElseThrow(() -> new ApiResponseStatus(400))
                    .getProducts(dataSource));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @GetMapping("/{sid}/products/{id}")
    public ResponseEntity<Map.Entry<Product, Integer>> findById(@PathVariable Long sid, @PathVariable Long id) {

        try {

            return ResponseEntity.ok(dataSource.getOrderRepository()
                    .findByPrimaryKey(sid)
                    .filter(i -> ApiPermission.verifyOrThrow(ApiPermissionType.ORDER_PRODUCTS, ApiPermissionOperation.READ, authToken, i.getUserId()))
                    .orElseThrow(() -> new ApiResponseStatus(400))
                    .getProducts(dataSource)
                    .stream()
                    .filter(i -> id.equals(i.getKey().getId()))
                    .findFirst()
                    .orElseThrow(() -> new ApiResponseStatus(404)));

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


    @PostMapping("/{sid}/products")
    public ResponseEntity<String> create(@PathVariable Long sid, @RequestBody Map.Entry<Product, Integer> product) {

        try {

            var o = dataSource.getOrderRepository()
                    .findByPrimaryKey(sid)
                    .filter(i -> ApiPermission.verifyOrThrow(ApiPermissionType.ORDER_PRODUCTS, ApiPermissionOperation.CREATE, authToken, i.getUserId()))
                    .orElseThrow(() -> new ApiResponseStatus(400));

            var p = dataSource.getProductRepository()
                    .findByPrimaryKey(product.getKey().getId())
                    .orElseThrow(() -> new ApiResponseStatus(404));


            o.getProducts(dataSource).add(new AbstractMap.SimpleImmutableEntry<>(p, product.getValue()));
            dataSource.getOrderRepository().update(o, o);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/orders/%d/products/%d", sid, product.getKey().getId()))).build();

    }


    @PutMapping("/{sid}/products/{id}")
    public ResponseEntity<String> update(@PathVariable Long sid, @PathVariable Long id, @RequestBody Map.Entry<Product, Integer> product) {

        try {

            var o = dataSource.getOrderRepository()
                    .findByPrimaryKey(sid)
                    .filter(i -> ApiPermission.verifyOrThrow(ApiPermissionType.ORDER_PRODUCTS, ApiPermissionOperation.UPDATE, authToken, i.getUserId()))
                    .orElseThrow(() -> new ApiResponseStatus(400));

            var p = dataSource.getProductRepository()
                    .findByPrimaryKey(product.getKey().getId())
                    .orElseThrow(() -> new ApiResponseStatus(404));


            o.getProducts(dataSource)
                    .stream()
                    .filter(i -> i.getKey().getId().equals(id))
                    .findFirst()
                    .ifPresent(o.getProducts(dataSource)::remove);

            o.getProducts(dataSource).add(new AbstractMap.SimpleImmutableEntry<>(p, product.getValue()));
            dataSource.getOrderRepository().update(o, o);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.created(URI.create(String.format("/api/orders/%d/products/%d", sid, product.getKey().getId()))).build();

    }


    @DeleteMapping("/{sid}/products")
    public ResponseEntity<String> deleteAll(@PathVariable Long sid) {

        ApiPermission.verifyOrThrow(ApiPermissionType.WISHLIST, ApiPermissionOperation.DELETE, authToken, sid);

        try {

            var o = dataSource.getOrderRepository()
                    .findByPrimaryKey(sid)
                    .filter(i -> ApiPermission.verifyOrThrow(ApiPermissionType.ORDER_PRODUCTS, ApiPermissionOperation.DELETE, authToken, i.getUserId()))
                    .orElseThrow(() -> new ApiResponseStatus(400));

            o.getProducts(dataSource).clear();
            dataSource.getOrderRepository().update(o, o);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }


    @DeleteMapping("/{sid}/products/{id}")
    public ResponseEntity<String> delete(@PathVariable Long sid, @PathVariable Long id) {

        ApiPermission.verifyOrThrow(ApiPermissionType.WISHLIST, ApiPermissionOperation.DELETE, authToken, sid);

        try {

            var o = dataSource.getOrderRepository()
                    .findByPrimaryKey(sid)
                    .filter(i -> ApiPermission.verifyOrThrow(ApiPermissionType.ORDER_PRODUCTS, ApiPermissionOperation.DELETE, authToken, i.getUserId()))
                    .orElseThrow(() -> new ApiResponseStatus(400));

            var p = o.getProducts(dataSource)
                    .stream()
                    .filter(i -> i.getKey().getId().equals(id))
                    .findFirst()
                    .orElseThrow(() -> new ApiResponseStatus(404));

            o.getProducts(dataSource).remove(p);
            dataSource.getOrderRepository().update(o, o);

        } catch (DataSourceSQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return ResponseEntity.noContent().build();

    }

}

