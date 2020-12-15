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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import javax.servlet.ServletContext;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Controller
@Scope("singleton")
public class Loader {

    private final ServletContext servletContext;
    private final Map<String, String> components;

    @Autowired
    public Loader(ServletContext servletContext) {

        this.servletContext = servletContext;

        this.components = new HashMap<>() {{

            try {

                Files.list(Path.of(servletContext.getRealPath("/components")))
                        .filter(p -> p.toString().endsWith(".ui"))
                        .peek(p -> System.err.printf("%s: Loading component %s%n", Loader.class.getSimpleName(), p.getFileName().toString()))
                        .forEach(p -> {

                            try {

                                put(p.getFileName()
                                                .toString()
                                                .transform(s -> s.substring(0, s.lastIndexOf('.'))), minimize(Files.readString(p)));

                            } catch (IOException ignored) {
                                throw new IllegalStateException();
                            }

                        });

            } catch (IOException ignored) {
                throw new IllegalStateException();
            }

        }};
        
    }


    public String load(Model model, String page) {
        model.addAttribute("components", components);
        return page;
    }


    public static String minimize(String content) {

        var output = new StringBuilder();

        Arrays.asList(content
                .replaceAll("(?s)<!--.*?-->", "")
                .split("\n"))
                .forEach(i -> output.append(i.trim()));

        return output.toString();

    }

}
