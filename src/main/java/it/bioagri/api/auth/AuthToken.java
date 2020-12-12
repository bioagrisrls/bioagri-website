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
import com.fasterxml.jackson.annotation.JsonProperty;
import it.bioagri.api.ApiPermissionException;
import it.bioagri.api.ApiPermissionHandler;
import it.bioagri.api.ApiPermissionType;
import it.bioagri.api.ApiPermissionOperation;
import it.bioagri.models.UserRole;
import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.SessionScope;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.AbstractMap;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Component
@SessionScope
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.NONE)
public class AuthToken {

    private final static Map<Map.Entry<ApiPermissionType, ApiPermissionOperation>, ApiPermissionHandler> permissionsHandler;

    static {

        permissionsHandler = new HashMap<>() {{

            put(new SimpleImmutableEntry<>(ApiPermissionType.USER, ApiPermissionOperation.CREATE), ApiPermissionHandler.granted());
            put(new SimpleImmutableEntry<>(ApiPermissionType.USER, ApiPermissionOperation.READ  ), ApiPermissionHandler.granted());
            put(new SimpleImmutableEntry<>(ApiPermissionType.USER, ApiPermissionOperation.WRITE ), ApiPermissionHandler.denied());
            put(new SimpleImmutableEntry<>(ApiPermissionType.USER, ApiPermissionOperation.DELETE), ApiPermissionHandler.denied());
            put(new SimpleImmutableEntry<>(ApiPermissionType.USER, ApiPermissionOperation.UPDATE), ApiPermissionHandler.denied());

            put(new SimpleImmutableEntry<>(ApiPermissionType.WISHLIST, ApiPermissionOperation.CREATE), ApiPermissionHandler.denied());
            put(new SimpleImmutableEntry<>(ApiPermissionType.WISHLIST, ApiPermissionOperation.READ  ), ApiPermissionHandler.denied());
            put(new SimpleImmutableEntry<>(ApiPermissionType.WISHLIST, ApiPermissionOperation.WRITE ), ApiPermissionHandler.denied());
            put(new SimpleImmutableEntry<>(ApiPermissionType.WISHLIST, ApiPermissionOperation.DELETE), ApiPermissionHandler.denied());
            put(new SimpleImmutableEntry<>(ApiPermissionType.WISHLIST, ApiPermissionOperation.UPDATE), ApiPermissionHandler.denied());

        }};

    }


    private String token;
    private Timestamp timestamp;
    private Long userId;
    private UserRole userRole;


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


    public boolean isExpired() {

        return  token == null           ||
                timestamp == null       ||
                token.isEmpty()         ||
                timestamp.before(Timestamp.from(Instant.now().minus(30, ChronoUnit.MINUTES)));

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


    public void checkPermission(ApiPermissionType type, ApiPermissionOperation operation) {

        if(getUserRole().equals(UserRole.CUSTOMER)) {

            if(!permissionsHandler.get(new AbstractMap.SimpleImmutableEntry<>(type, operation)).handle(type, operation, this))
                throw new ApiPermissionException();

        }

    }


}
