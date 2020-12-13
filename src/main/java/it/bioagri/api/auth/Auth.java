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

import it.bioagri.models.User;
import it.bioagri.persistence.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;


@RestController
@RequestMapping("/api/auth")
public final class Auth {

    private final AuthToken authToken;
    private final DataSource dataSource;

    @Autowired
    public Auth(AuthToken authToken, DataSource dataSource) {
        this.authToken = authToken;
        this.dataSource = dataSource;
    }


    @PostMapping("authenticate")
    public ResponseEntity<AuthToken> authenticate(HttpSession session, @RequestBody AuthLogin authLogin) {

        if(authLogin.getUsername().isEmpty())
            throw new AuthFailedException("username can not be null or empty");

        if(authLogin.getPassword().isEmpty())
            throw new AuthFailedException("password can not be null or empty");


        User user;
        if((user = dataSource.authenticate(authLogin)) == null)
            throw new AuthFailedException("username/password wrong");


        return ResponseEntity.ok(authToken.generateToken(user.getId(), user.getRole()));

    }

    @RequestMapping("disconnect")
    public void disconnect(HttpSession session) {

        authToken.setUserId(-1L);
        authToken.setUserRole(null);
        authToken.setToken(null);
        authToken.setTimestamp(null);

        session.invalidate();

    }

}
