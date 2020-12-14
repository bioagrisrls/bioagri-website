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

import it.bioagri.api.auth.AuthToken;
import it.bioagri.api.ApiPermissionOperation;
import it.bioagri.api.ApiPermissionType;
import it.bioagri.models.Product;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceSQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

    @GetMapping("/{id}/wishlist")
    public ResponseEntity<List<Product>> findById(@PathVariable Long id) {

        try {

            if(!authToken.getUserId().equals(id))
                authToken.hasPermission(ApiPermissionType.WISHLIST, ApiPermissionOperation.READ);

            return new ResponseEntity<>(dataSource.getUserRepository()
                    .findByPrimaryKey(id)
                    .orElseThrow(() -> new ApiException(ApiExceptionType.ERROR_RESOURCE_NOT_FOUND, String.format("requested user id not found: %s", id), HttpStatus.NOT_FOUND)).getWishList(), HttpStatus.OK);

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

    }

}
