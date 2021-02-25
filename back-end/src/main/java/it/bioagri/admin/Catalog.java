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
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.Product;
import it.bioagri.models.ProductStatus;
import it.bioagri.persistence.DataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;

@Controller
public class Catalog {

    private final DataSource dataSource;

    public Catalog(DataSource dataSource){
        this.dataSource = dataSource;
    }

    @GetMapping("/admin/catalog")
    public String getAllData(ModelMap model) {
        model.addAttribute("products", dataSource.getProductDao().findAll());
        return "/admin/catalog";
    }

    @GetMapping("/admin/get/productData")
    public String getProductData(@RequestParam long id, ModelMap model){

        model.addAttribute("categories", dataSource.getCategoryDao().findAll());
        model.addAttribute("tags", dataSource.getTagDao().findAll());
        model.addAttribute("productData",dataSource.getProductDao().findByPrimaryKey(id).get());

        String categories = "";
        String tags = "";
        String categoriesId = "";
        String tagsId = "";

        for(Category category : dataSource.getProductDao().findByPrimaryKey(id).get().getCategories(dataSource)) {
            categories += category.getName() + ",";
            categoriesId+= category.getId().toString() + ",";
        }

        if(categories.length() > 0)
            categories = categories.substring(0,categories.length()-1);

        for(Tag tag : dataSource.getProductDao().findByPrimaryKey(id).get().getTags(dataSource)) {
            tags += tag.getHashtag() + ",";
            tagsId+= tag.getId().toString() + ",";
        }

        if(tags.length() > 0)
            tags = tags.substring(0,tags.length()-1);

        model.addAttribute("productCategories",categories);
        model.addAttribute("productCategoriesId",categoriesId);
        model.addAttribute("productTags",tags);
        model.addAttribute("productTagsId",tagsId);
        return "/admin/updateProduct";
    }

}
