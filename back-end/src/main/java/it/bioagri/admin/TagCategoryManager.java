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
public class TagCategoryManager {


    private final DataSource dataSource;


    public TagCategoryManager(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @GetMapping("/admin/tagscategory")
    public String getAllData(ModelMap model) {

        model.addAttribute("categories", dataSource.getCategoryDao().findAll());
        model.addAttribute("tags", dataSource.getTagDao().findAll());
        return "/admin/tagscategory";

    }

    @PostMapping("/admin/create/category")
    public void saveCategory( @RequestParam String name) throws IOException {
        dataSource.getCategoryDao().save(new Category(dataSource.getId("shop_category", Long.class),name));
    }


    @PostMapping("/admin/delete/category")
    public void deleteCategory(@RequestParam long id, HttpServletResponse response) throws IOException {
        dataSource.getCategoryDao().delete(dataSource.getCategoryDao().findByPrimaryKey(id).get());
    }

    @PostMapping("/admin/update/category")
    public void updateCategory(@RequestParam long id, @RequestParam String name) {
        dataSource.getCategoryDao().update(dataSource.getCategoryDao().findByPrimaryKey(id).get(),new Category(id,name));
    }



    @PostMapping("/admin/create/tag")
    public void save(@RequestParam String hashtag)  {
        dataSource.getTagDao().save(new Tag(dataSource.getId("shop_tag", Long.class), hashtag));
    }


    @PostMapping("/admin/delete/tag")
    public void delete(@RequestParam long id)  {
        dataSource.getTagDao().delete(dataSource.getTagDao().findByPrimaryKey(id).get());
    }

    @PostMapping("/admin/update/tag")
    public void update( @RequestParam long id, @RequestParam String hashtag)  {
        dataSource.getTagDao().update(dataSource.getTagDao().findByPrimaryKey(id).get(), new Tag(id,hashtag));
    }


}
