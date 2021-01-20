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
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@Component
@Scope("singleton")
public class Locale {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(Locale.class);
    private final Map<String, Map<String, String>> dictionaries;

    @Autowired
    private Locale(ServletContext servletContext) {

        this.dictionaries = Collections.unmodifiableMap(new HashMap<>() {{

            try {

                final var dictionaryPath = Path.of(servletContext.getRealPath("/WEB-INF/lang"));

                Files.walk(dictionaryPath)
                        .filter(p -> p.toString().endsWith(".json"))
                        .peek(p -> logger.info("Loading dictionary {}", dictionaryPath.relativize(p).toString()))
                        .forEach(p -> {

                            try {

                                put(dictionaryPath.relativize(p)
                                        .toString()
                                        .replace('/', '_')
                                        .replace('\\', '_')
                                        .transform(s -> s.substring(0, s.lastIndexOf('.'))), toMap(Files.readString(p)));

                            } catch (IOException ignored) {
                                throw new IllegalStateException();
                            }

                        });

            } catch (IOException ignored) {
                throw new IllegalStateException();
            }

        }});


        if(!dictionaries.containsKey("default"))
            throw new IllegalStateException("Default dictionary not found in /WEB-INF/lang/default.json");

    }


    private Map<String, String> toMap(String json) {

        try {
            return new ObjectMapper().readValue(json, new TypeReference<HashMap<String, String>>() {});
        } catch (JsonProcessingException e) {
            logger.error("Error processing JSON", e);
        }

        return Collections.emptyMap();

    }


    public Map<String, String> getCurrentLocale(ServletRequest servletRequest, HttpSession session) {

        if(servletRequest.getParameter("lang") != null)
            session.setAttribute("override-locale", servletRequest.getParameter("lang").toLowerCase());


        String country;

        if(session.getAttribute("override-locale") != null)
            country = session.getAttribute("override-locale").toString();
        else
            country = servletRequest.getLocale()
                    .getCountry()
                    .toLowerCase();


        if(dictionaries.containsKey(country))
            return dictionaries.get(country);

        return dictionaries.get("default");

    }

}
