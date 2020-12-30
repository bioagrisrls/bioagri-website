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
import it.bioagri.api.auth.AuthToken;
import it.bioagri.utils.CachedRequestWrapper;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;

@Component
public class Minifier implements Filter {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(Minifier.class);


    private final AuthToken authToken;

    @Autowired
    public Minifier(AuthToken authToken) {
        this.authToken = authToken;
    }


    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {


        if(request instanceof HttpServletRequest) {

            if (((HttpServletRequest) request).getRequestURI().startsWith("/assets")) {

                chain.doFilter(request, response);
                return;

            }

            if (((HttpServletRequest) request).getRequestURI().startsWith("/api")) {

                logger.trace("invoked REST API {} from {}", ((HttpServletRequest) request).getRequestURI(), authToken);

                chain.doFilter(new CachedRequestWrapper((HttpServletRequest) request), response);
                return;

            }


            if (response instanceof HttpServletResponse) {


                ServletResponse wrapper;

                chain.doFilter(request, (wrapper = new HttpServletResponseWrapper((HttpServletResponse) response) {

                    private final PrintWriter writer;
                    private final CharArrayWriter buffer;

                    {
                        writer = new PrintWriter((buffer = new CharArrayWriter()));
                    }

                    @Override
                    public PrintWriter getWriter() throws IOException {
                        return writer;
                    }

                    @Override
                    public String toString() {
                        return buffer.toString();
                    }

                }));


                response.getOutputStream().print(
                        """
                                <!--
                                                        
                                    Authors:
                                        Antonino Natale   <linkedin.com/in/antonino-natale>
                                        Matteo Perfidio   <linkedin.com/in/matteo-perfidio>
                                        Davide Crisafulli <linkedin.com/in/davide-crisafulli>
                                   
                                    Copyright (c) 2021 Bioagri S.r.l.s. All Rights Reserved.
                                    
                                -->                   
                                """
                );

                response.getOutputStream().write(Page.minimize(wrapper.toString(), false).getBytes(StandardCharsets.UTF_8));

            }

        } else {

            chain.doFilter(request, response);

        }

    }
}