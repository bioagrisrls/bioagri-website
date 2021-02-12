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


import it.bioagri.models.Tag;
import it.bioagri.persistence.DataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;



@Controller
public class TagsManager {


    private final DataSource dataSource;


    public TagsManager(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @PostMapping("/admin/create/tag")
    public void save(

            HttpServletResponse response,
            @RequestParam String hashtag

    ) throws IOException {


        dataSource.getTagDao().save(

                new Tag(
                        dataSource.getId("shop_tag", Long.class),
                        hashtag
                )

        );

        response.sendRedirect("/admin/dashboard");


    }


    @PostMapping("/admin/delete/tag")
    public void delete(@RequestParam long id, HttpServletResponse response) throws IOException {

        dataSource.getTagDao().delete(dataSource.getTagDao().findByPrimaryKey(id).get());

        response.sendRedirect("/admin/dashboard");

    }

    @PostMapping("/admin/update/tag")
    public void update(

            HttpServletResponse response,
            @RequestParam long id,
            @RequestParam String hashtag

    ) throws IOException {


        dataSource.getTagDao().update(dataSource.getTagDao().findByPrimaryKey(id).get(),

                new Tag(
                        id,
                        hashtag
                )

        );

        response.sendRedirect("/admin/dashboard");


    }


}
