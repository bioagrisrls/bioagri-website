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

package it.bioagri.api.feedbacks;

import it.bioagri.api.*;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Feedback;
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
@RequestMapping("/api/feedbacks")
public class Feedbacks {

    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public Feedbacks(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @GetMapping("")
    public ResponseEntity<List<Feedback>> findAll() {

        authToken.checkPermission(ApiPermissionType.FEEDBACKS, ApiPermissionOperation.READ);

        try {
            return new ResponseEntity<>(dataSource.getFeedbackRepository().findAll(), HttpStatus.OK);
        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

    }

    @GetMapping("/{id}")
    public ResponseEntity<Feedback> findById(@PathVariable Long id) {

        authToken.checkPermission(ApiPermissionType.FEEDBACKS, ApiPermissionOperation.READ);

        try {

            return new ResponseEntity<>(dataSource.getFeedbackRepository()
                    .findByPrimaryKey(id)
                    .orElseThrow(() -> new ApiException(ApiExceptionType.ERROR_RESOURCE_NOT_FOUND, String.format("requested feedback id not found: %s", id), HttpStatus.NOT_FOUND)), HttpStatus.OK);

        } catch (DataSourceSQLException e) {
            throw new ApiDatabaseException(e.getMessage(), e.getException().getSQLState());
        }

    }


}
