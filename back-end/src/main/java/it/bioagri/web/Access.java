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
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.Optional;


@Component
public class Access implements Filter {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(Access.class);
    private final static Map<String, Map.Entry<String, Boolean>> accessWithAuthentication;


    static {

        accessWithAuthentication = Map.of (
            "/checkout",     Map.entry("/catalog", true),
            "/myaccount",    Map.entry("/home", true),
            "/mywish",       Map.entry("/home", true),
            "/myorder",      Map.entry("/home", true),
            "/registration", Map.entry("/home", false)
        );

    }


    private final AuthToken authToken;

    @Autowired
    public Access(AuthToken authToken) {
        this.authToken = authToken;
    }



    private void filterAccess(String URI, HttpServletRequest request, HttpServletResponse response) throws IOException {

        if (authToken.isLoggedIn() != accessWithAuthentication.get(URI).getValue()) {

            response.sendRedirect(Optional
                    .ofNullable(request.getHeader("Referer"))
                    .orElse(accessWithAuthentication.get(URI).getKey())
            );

            logger.error("Access denied for URI {} by {}", URI, authToken);

        }

    }


    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        if(request instanceof HttpServletRequest && response instanceof HttpServletResponse) {

            if(accessWithAuthentication.containsKey(((HttpServletRequest) request).getRequestURI()))
                filterAccess(((HttpServletRequest) request).getRequestURI(), (HttpServletRequest) request, (HttpServletResponse) response);

        }

        chain.doFilter(request, response);

    }

}
