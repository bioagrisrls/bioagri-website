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

package it.bioagri.api.auth;

import ch.qos.logback.classic.Logger;
import it.bioagri.models.User;
import it.bioagri.persistence.DataSource;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;


@RestController
@RequestMapping("/api/auth")
public final class Auth {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(Auth.class);

    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public Auth(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @PostMapping("authenticate")
    public ResponseEntity<AuthToken> authenticate(HttpSession session, @RequestBody AuthLogin authLogin) {

        logger.trace("Authentication attempt with {}", authLogin);

        if(authLogin.getUsername().isEmpty())
            return ResponseEntity.badRequest().build();

        if(authLogin.getPassword().isEmpty())
            return ResponseEntity.badRequest().build();

        User user;
        if((user = dataSource.authenticate(authLogin)) == null)
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();


        return ResponseEntity.ok(authToken.generateToken(user.getId(), user.getRole()));

    }

    @RequestMapping("disconnect")
    public void disconnect(HttpSession session) {

        logger.trace("Authentication closed from {}", authToken);

        authToken.setUserId(null);
        authToken.setUserRole(null);
        authToken.setToken(null);
        authToken.setTimestamp(null);

        session.invalidate();

    }

}
