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

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import java.util.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

@Component
@Scope("singleton")
public class Components {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(Components.class);
    private final Map<String, String> components;

    @Autowired
    private Components(ServletContext servletContext) {

        this.components = Collections.unmodifiableMap(new HashMap<>() {{

            try {

                final var componentsPath = Path.of(servletContext.getRealPath("/WEB-INF/components"));

                Files.walk(componentsPath)
                        .filter(p -> p.toString().endsWith(".ui"))
                        .peek(p -> logger.info("Loading component {}", componentsPath.relativize(p).toString()))
                        .forEach(p -> {

                            try {

                                put(componentsPath.relativize(p.getParent())
                                        .toString()
                                        .transform(s -> p.toString().endsWith(".error.ui") ? "%s_error".formatted(s) : s)
                                        .transform(s -> p.toString().endsWith(".loading.ui") ? "%s_loading".formatted(s) : s)
                                        .replace('\\', '_')
                                        .replace('/', '_')
                                        .replace('.', '_'), Page.escapize(Page.minimize(Files.readString(p), true)));


                            } catch (IOException ignored) {
                                throw new IllegalStateException();
                            }

                        });

            } catch (IOException e) {
                throw new IllegalStateException();
            }

        }});

        
    }


    public Map<String, String> getComponents() {
        return components;
    }

}
