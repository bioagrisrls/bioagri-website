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

import it.bioagri.models.Category;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.DataSourceFetchResult;
import it.bioagri.persistence.DataSourcePrepareStatement;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

@Controller
public class Dashboard {

    private final DataSource dataSource;

    public Dashboard(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @GetMapping("/admin/dashboard")
    public void getAllData(ModelMap model) {

        dataSource.fetch(

                "SELECT count(*) AS ordersCount FROM  shop_order",
                null,
                r -> {
                    model.addAttribute("ordersCount", r.getInt("ordersCount"));
                });

        dataSource.fetch(

                "SELECT count(*) AS feedbacksCount FROM  shop_feedback",
                null,
                r -> {
                    model.addAttribute("feedbacksCount", r.getInt("feedbacksCount"));
                });

        dataSource.fetch(
                "SELECT count(*) AS usersCount FROM shop_user ",
                null,
                r -> {
                    model.addAttribute("usersCount", r.getInt("usersCount"));
                });

        dataSource.fetch(
                "SELECT count(*) AS productsCount FROM shop_product ",
                null,
                r -> {
                    model.addAttribute("productsCount", r.getInt("productsCount"));
                });

    }


}