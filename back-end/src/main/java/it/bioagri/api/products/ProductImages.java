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
import it.bioagri.api.ApiPermissionPublic;
import it.bioagri.api.ApiPermissionType;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.persistence.DataSource;
import it.bioagri.utils.ApiRequestQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletContext;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/products")
public class ProductImages {


    private final AuthToken authToken;
    private final DataSource dataSource;
    private final ServletContext servletContext;

    @Autowired
    public ProductImages(AuthToken authToken, DataSource dataSource, ServletContext servletContext) {
        this.authToken = authToken;
        this.dataSource = dataSource;
        this.servletContext = servletContext;
    }


    @GetMapping("/{sid}/images")
    @ApiPermissionPublic
    public ResponseEntity<List<String>> findAll(
            @PathVariable Long sid,
            @RequestParam(required = false, defaultValue =   "0") Long skip,
            @RequestParam(required = false, defaultValue = "999") Long limit,
            @RequestParam(required = false, value =  "filter-by") List<String> filterBy,
            @RequestParam(required = false, value = "filter-val") List<String> filterValue,
            @RequestParam(required = false, defaultValue = "asc") String order,
            @RequestParam(required = false, value =  "sorted-by") String sortedBy) {

        ApiPermission.verifyOrThrow(ApiPermissionType.PRODUCTS, ApiPermissionOperation.READ, authToken);

        try {

            final var rootPath = Path.of(servletContext.getRealPath("/"));
            final var imagesPath = rootPath.resolve("/assets/img/products/%s".formatted(sid));

            if(Files.notExists(imagesPath))
                return ResponseEntity.notFound().build();


            return ResponseEntity.ok(
                    Files.walk(imagesPath)
                            .filter(i -> !i.equals(imagesPath))
                            .map(i -> rootPath.relativize(i).toString())
                            .filter(i -> ApiRequestQuery.filterBy(filterBy, filterValue, i, dataSource))
                            .sorted((a, b) -> ApiRequestQuery.sortedBy(sortedBy, order, a, b))
                            .skip(skip)
                            .limit(limit)
                            .collect(Collectors.toList()));


        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


}
