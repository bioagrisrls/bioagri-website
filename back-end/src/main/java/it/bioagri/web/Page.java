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

import it.bioagri.api.ApiResponseStatus;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.function.Predicate;

@Controller
public class Page {

    private final Locale locale;
    private final Components components;
    private final AuthToken authToken;
    private final ServletContext servletContext;

    @Autowired
    public Page(Locale locale, Components components, AuthToken authToken, ServletContext servletContext) {
        this.locale = locale;
        this.components = components;
        this.authToken = authToken;
        this.servletContext = servletContext;
    }


    private String loadPage(ServletRequest request, ModelMap model, String page) {

        model.addAttribute("reference", page);
        model.addAttribute("components", components.getComponents());
        model.addAttribute("locale", locale.getCurrentLocale(request));
        model.addAttribute("authToken", authToken);

        return "router";

    }


    @GetMapping("/")
    public String index(ServletRequest request, ModelMap model) {
        return loadPage(request, model, "pages/home.jsp");
    }

    @GetMapping("/{page}")
    public String page(ServletRequest request, ModelMap model, @PathVariable String page) {

        if(page.startsWith("{{")) // FIXME
            throw new ApiResponseStatus(204);

        return switch (page) {
            case "favicon.ico" -> "/assets/favicon.ico";
            case "favicon.png" -> "/assets/favicon.png";
            default -> loadPage(request, model, "pages/%s.jsp".formatted(page));
        };

    }


    @GetMapping("/admin/{page}")
    public String admin(ServletRequest request, ServletResponse response, ModelMap model, @PathVariable String page) throws ServletException, IOException {

        request.getRequestDispatcher("/home").include(request, response);

        if(authToken.getUserRole().equals(UserRole.ADMIN))
            return loadPage(request, model, "admin/%s.jsp".formatted(page));

        return "prova";

    }


    public static String minimize(String content, boolean replaceNewLines) {

        var output = new StringBuilder();

        Arrays.stream(content
                .replaceAll("(?s)<!--.*?-->", "")
                .replaceAll("(?s)/\\*.*?\\*/", "")
                .replaceAll("\s+", " ")
                .split("\n"))
                .filter(Predicate.not(String::isEmpty))
                .filter(Predicate.not(String::isBlank))
                .forEach(i -> output.append(i.trim()).append(replaceNewLines ? ' ' : '\n'));



        return output.toString();

    }

    public static String escapize(String content) {
        return content
                .replace("/", "\\/")
                .replace("`", "\\`");
    }

}
