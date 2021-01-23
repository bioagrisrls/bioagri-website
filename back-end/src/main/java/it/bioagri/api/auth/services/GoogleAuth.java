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

package it.bioagri.api.auth.services;

import ch.qos.logback.classic.Logger;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

public class GoogleAuth implements AuthExternalService {

    private final static Logger logger = (Logger) LoggerFactory.getLogger(GoogleAuth.class);


    private final String clientId;

    public GoogleAuth(String clientId) {
        this.clientId = clientId;
    }

    @Override
    public boolean verify(String username, String token) {

        GoogleIdTokenVerifier idTokenVerifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new JacksonFactory())
                .setAudience(Collections.singletonList(clientId))
                .build();

        try {

            GoogleIdToken idToken = idTokenVerifier.verify(token);
            GoogleIdToken.Payload payload = idToken.getPayload();

            logger.debug("External Authentication <{}> attempt from {} <{}> (verified: {})",
                    GoogleAuth.class.getSimpleName(),
                    payload.get("name"),
                    payload.getEmail(),
                    payload.getEmailVerified());


            if(!payload.getEmailVerified())
                return false;

            return payload.getEmail().equals(username);


        } catch (GeneralSecurityException | IOException e) {
            logger.error(e.getMessage(), e);
        }


        return false;

    }

}
