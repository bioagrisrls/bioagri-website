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

package it.bioagri.admin;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Product;
import it.bioagri.models.ProductStatus;
import it.bioagri.persistence.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;

@Controller
public class Catalog {

    private final AuthToken authToken;
    private final DataSource dataSource;
    private final ServletContext servletContext;

    @Autowired
    public Catalog(AuthToken authToken, DataSource dataSource, ServletContext servletContext) {
        this.authToken = authToken;
        this.dataSource = dataSource;
        this.servletContext = servletContext;
    }



    @PostMapping("/admin/form/product")
    public void save(

            HttpServletResponse response,
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam Float price,
            @RequestParam Integer stock,
            @RequestParam String info,
            @RequestParam Float discount,
            @RequestParam ProductStatus status

    ) throws IOException {


            dataSource.getProductDao().save(

                    new Product(
                            dataSource.getId("shop_product", Long.class),
                            name,
                            description,
                            info,
                            price,
                            discount,
                            stock,
                            status,
                            Timestamp.from(Instant.now()),
                            Timestamp.from(Instant.now()),
                            null,
                            null,
                            null
                    )

            );

            response.sendRedirect("/admin/dashboard");



    }

    @PostMapping("/admin/delete/product")
    public void delete(@RequestParam long id, HttpServletResponse response) throws IOException {

        dataSource.getProductDao().delete(dataSource.getProductDao().findByPrimaryKey(id).get());

        response.sendRedirect("/admin/dashboard");

    }


    @PostMapping("/admin/update/product")
    public void update(

            HttpServletResponse response,
            @RequestParam long id,
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam Float price,
            @RequestParam Integer stock,
            @RequestParam String info,
            @RequestParam Float discount,
            @RequestParam ProductStatus status

    ) throws IOException {


        dataSource.getProductDao().update(dataSource.getProductDao().findByPrimaryKey(id).get(),

                new Product(
                        id,
                        name,
                        description,
                        info,
                        price,
                        discount,
                        stock,
                        status,
                        Timestamp.from(Instant.now()),
                        Timestamp.from(Instant.now()),
                        null,
                        null,
                        null
                )

        );

        response.sendRedirect("/admin/dashboard");



    }


}
