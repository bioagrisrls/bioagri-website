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

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import it.bioagri.models.UserRole;
import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.SessionScope;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.StringJoiner;
import java.util.UUID;

@Component
@SessionScope
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.NONE)
public class AuthToken {

    private String token;
    private Timestamp timestamp;
    private Long userId;
    private UserRole userRole;


    public AuthToken() {
        this.token = null;
        this.timestamp = null;
        this.userId = 0L;
        this.userRole = UserRole.CUSTOMER;
    }

    @JsonProperty
    public String getToken() {
        return token;
    }

    @JsonProperty
    public Timestamp getTimestamp() {
        return timestamp;
    }

    @JsonProperty
    public Long getUserId() {
        return userId;
    }

    @JsonProperty
    public UserRole getUserRole() {
        return userRole;
    }

    public void setToken(String token) {
        this.token = token;
    }


    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }


    @JsonIgnore
    public boolean isLoggedIn() {
        return !userId.equals(0L);
    }


    @JsonIgnore
    public boolean isExpired() {

        if(!isLoggedIn())
            return false;

        return timestamp.before(Timestamp.from(Instant.now().minus(30, ChronoUnit.MINUTES)));

    }



    public AuthToken generateToken(Long userId, UserRole userRole) {

        setToken(UUID.randomUUID().toString());
        setTimestamp(Timestamp.from(Instant.now()));
        setUserId(userId);
        setUserRole(userRole);

        return this;

    }

    public AuthToken generateToken() {
        return generateToken(getUserId(), getUserRole());
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", AuthToken.class.getSimpleName() + "[", "]")
                .add("token='" + token + "'")
                .add("timestamp=" + timestamp)
                .add("userId=" + userId)
                .add("userRole=" + userRole)
                .toString();
    }
}
