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

package it.bioagri.api;

import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Product;
import it.bioagri.models.User;
import it.bioagri.persistence.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;
import java.util.List;


@RestController
public class Test {

    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public Test(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/api/public/users/{id}")
    public ResponseEntity<User> publtest(@PathVariable Long id) {

        try {
            var v = dataSource.getUserRepository()
                    .findByPrimaryKey(id);

            if(v.isEmpty())
                throw new ApiException("GENERIC_ERROR", String.format("user id %s not found", id), HttpStatus.I_AM_A_TEAPOT);

            return new ResponseEntity<>(v.get(), HttpStatus.OK);

        } catch (SQLException e) {
            throw new ApiException("SQL_ERROR", e.getStackTrace()[0].toString(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping("/api/public/users/{id}/wishlist")
    public ResponseEntity<List<Product>> publtest2(@PathVariable Long id) {

        try {
            System.out.println("dataSource.getProductRepository().findByWishUserId(id) = " + dataSource.getProductRepository().findByWishUserId(id));
            return new ResponseEntity<>(dataSource.getProductRepository().findByWishUserId(id), HttpStatus.OK);

        } catch (SQLException e) {
            throw new ApiException("SQL_ERROR", e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping("/api/private/test")
    public String privtest() {
        return "Hello World from " + authToken.getToken();
    }

}
