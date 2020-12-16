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

package it.bioagri.api;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

public class ApiResponseStatus extends RuntimeException {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(ApiResponseStatus.class);
    private final HttpStatus status;

    public ApiResponseStatus(HttpStatus status) {
        this.status = status;
    }

    public ApiResponseStatus(int status) {
        this.status = HttpStatus.resolve(status);
    }

    public HttpStatus getStatus() {
        return status;
    }


    @ControllerAdvice
    static class ApiExceptionAdvice {

        @ExceptionHandler(ApiResponseStatus.class)
        @ResponseBody
        public ResponseEntity<String> handle(ApiResponseStatus e) {

            if(logger.isTraceEnabled() && !e.getStatus().is2xxSuccessful())
                logger.trace("Got a not successful status {}", e.getStatus());

            return ResponseEntity.status(e.getStatus()).build();

        }

    }

}
