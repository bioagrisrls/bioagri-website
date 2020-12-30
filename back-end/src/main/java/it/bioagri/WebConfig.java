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

package it.bioagri;

import ch.qos.logback.classic.Logger;
import it.bioagri.api.ApiPermissionPublic;
import it.bioagri.api.ApiResponseStatus;
import it.bioagri.api.auth.AuthToken;
import it.bioagri.utils.CachedRequestWrapper;
import it.bioagri.web.Page;
import org.jetbrains.annotations.NotNull;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.util.ContentCachingRequestWrapper;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

@Component
public class WebConfig implements WebMvcConfigurer {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(WebConfig.class);

    @Component
    static class Interceptor implements HandlerInterceptor {

        private final AuthToken authToken;

        @Autowired
        public Interceptor(AuthToken authToken) {
            this.authToken = authToken;
        }


        @Override
        public boolean preHandle(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response, @NotNull Object handler) throws Exception {

            if(Objects.equals(request.getAttribute("John"), "Doe"))
                return true;

            if(handler instanceof HandlerMethod && ((HandlerMethod) handler).hasMethodAnnotation(ApiPermissionPublic.class))
                 return true;

            if(request.getHeader("X-Auth-Token") == null)
                throw new ApiResponseStatus(401);

            if(!request.getHeader("X-Auth-Token").equals(authToken.getToken()))
                throw new ApiResponseStatus(403);

            return true;

        }


        @Override
        public void postHandle(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response, @NotNull Object handler, ModelAndView modelAndView) throws Exception {

            if(authToken.isExpired())
                response.addHeader("X-Auth-Token", authToken.generateToken().getToken());

        }


    }


    @Component
    public static class Minifier implements Filter {

        private final AuthToken authToken;

        @Autowired
        public Minifier(AuthToken authToken) {
            this.authToken = authToken;
        }

        @Override
        public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {


            if(request instanceof HttpServletRequest) {

                if(((HttpServletRequest) request).getRequestURI().startsWith("/assets")) {

                    chain.doFilter(request, response);
                    return;

                }

                if(((HttpServletRequest) request).getRequestURI().startsWith("/api")) {

                    logger.trace("invoked REST API {} from {}", ((HttpServletRequest) request).getRequestURI(), authToken);

                    chain.doFilter(new CachedRequestWrapper((HttpServletRequest) request), response);
                    return;

                }

            }


            if(response instanceof HttpServletResponse) {

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

        }
    }


    private final Interceptor interceptor;

    @Autowired
    public WebConfig(Interceptor interceptor) {
        this.interceptor = interceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(interceptor)
                .addPathPatterns("/api/**")
                .excludePathPatterns("/api/public/**");

    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        registry.addResourceHandler("/assets/**")
                .addResourceLocations("/assets/")
                .setCacheControl(CacheControl.maxAge(365, TimeUnit.DAYS));

    }
}
