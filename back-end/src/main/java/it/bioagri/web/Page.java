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

package it.bioagri.web;

import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.ServletRequest;

@Controller
public class Page {

    private final Locale locale;
    private final Components components;
    private final AuthToken authToken;

    @Autowired
    public Page(Locale locale, Components components, AuthToken authToken) {
        this.locale = locale;
        this.components = components;
        this.authToken = authToken;
    }


    private String loadPage(ServletRequest request, Model model, String page) {

        model.addAttribute("reference", page);
        model.addAttribute("components", components.getComponents());
        model.addAttribute("locale", locale.getCurrentLocale(request));

        return "router";

    }


    @GetMapping("/")
    public String index(ServletRequest request, Model model) {
        return loadPage(request, model, "pages/home.jsp");
    }

    @GetMapping("/{page}")
    public String page(ServletRequest request, Model model, @PathVariable String page) {

        return switch (page) {
            case "favicon.ico" -> "/assets/favicon.ico";
            case "favicon.png" -> "/assets/favicon.png";
            default -> loadPage(request, model, "pages/%s.jsp".formatted(page));
        };

    }

    @GetMapping("/admin/{page}")
    public String admin(ServletRequest request, Model model, @PathVariable String page) {

        if(authToken.isValid() && authToken.getUserRole().equals(UserRole.ADMIN))
            return loadPage(request, model, "admin/%s.jsp".formatted(page));

        return "error";

    }

}
