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

import it.bioagri.api.auth.AuthToken;
import it.bioagri.models.UserRole;

import java.util.Arrays;
import java.util.EnumSet;
import java.util.List;
import java.util.Objects;

import static it.bioagri.api.ApiPermissionActor.*;
import static it.bioagri.api.ApiPermissionOperation.*;
import static it.bioagri.api.ApiPermissionType.*;

public class ApiPermission {

    private final static List<ApiPermission> permissions;

    static {
        permissions = List.of(

                new ApiPermission(USERS, CREATE, ADMIN),
                new ApiPermission(USERS, READ,   ADMIN, USER),
                new ApiPermission(USERS, UPDATE, ADMIN, USER),
                new ApiPermission(USERS, DELETE, ADMIN, USER),

                new ApiPermission(WISHLIST, CREATE, ADMIN, USER),
                new ApiPermission(WISHLIST, READ,   ADMIN, USER),
                new ApiPermission(WISHLIST, UPDATE, ADMIN, USER),
                new ApiPermission(WISHLIST, DELETE, ADMIN, USER),

                new ApiPermission(CATEGORIES, CREATE, ADMIN),
                new ApiPermission(CATEGORIES, READ,   ADMIN, ALL),
                new ApiPermission(CATEGORIES, UPDATE, ADMIN),
                new ApiPermission(CATEGORIES, DELETE, ADMIN),

                new ApiPermission(FEEDBACKS, CREATE, ADMIN, USER),
                new ApiPermission(FEEDBACKS, READ,   ADMIN, USER),
                new ApiPermission(FEEDBACKS, UPDATE, ADMIN, USER),
                new ApiPermission(FEEDBACKS, DELETE, ADMIN, USER),

                new ApiPermission(ORDERS, CREATE, ADMIN),
                new ApiPermission(ORDERS, READ,   ADMIN, ALL),
                new ApiPermission(ORDERS, UPDATE, ADMIN),
                new ApiPermission(ORDERS, DELETE, ADMIN),

                new ApiPermission(PRODUCTS, CREATE, ADMIN),
                new ApiPermission(PRODUCTS, READ,   ADMIN, ALL),
                new ApiPermission(PRODUCTS, UPDATE, ADMIN),
                new ApiPermission(PRODUCTS, DELETE, ADMIN),

                new ApiPermission(TAGS, CREATE, ADMIN),
                new ApiPermission(TAGS, READ,   ADMIN, ALL),
                new ApiPermission(TAGS, UPDATE, ADMIN),
                new ApiPermission(TAGS, DELETE, ADMIN),

                new ApiPermission(TICKETS, CREATE, ADMIN, USER),
                new ApiPermission(TICKETS, READ,   ADMIN, USER),
                new ApiPermission(TICKETS, UPDATE, ADMIN, USER),
                new ApiPermission(TICKETS, DELETE, ADMIN, USER),

                new ApiPermission(TICKET_RESPONSES, CREATE, ADMIN),
                new ApiPermission(TICKET_RESPONSES, READ,   ADMIN, USER),
                new ApiPermission(TICKET_RESPONSES, UPDATE, ADMIN),
                new ApiPermission(TICKET_RESPONSES, DELETE, ADMIN),

                new ApiPermission(TRANSACTIONS, CREATE, ADMIN, USER),
                new ApiPermission(TRANSACTIONS, READ,   ADMIN, USER),
                new ApiPermission(TRANSACTIONS, UPDATE, ADMIN),
                new ApiPermission(TRANSACTIONS, DELETE, ADMIN)

        );
    }

    private final ApiPermissionType type;
    private final ApiPermissionOperation operation;
    private final List<ApiPermissionActor> actors;

    public ApiPermission(ApiPermissionType type, ApiPermissionOperation operation, ApiPermissionActor... actors) {
        this.type = type;
        this.operation = operation;
        this.actors = Arrays.asList(actors);
    }

    public ApiPermissionType getType() {
        return type;
    }

    public ApiPermissionOperation getOperation() {
        return operation;
    }

    public List<ApiPermissionActor> getActors() {
        return actors;
    }


    public static boolean hasPermission(ApiPermissionType type, ApiPermissionOperation operation, AuthToken authToken, Long ownerId) {

        var api = EnumSet.copyOf(permissions
                .stream()
                .filter(new ApiPermission(type, operation)::equals)
                .findFirst()
                .orElseThrow(IllegalArgumentException::new)
                .getActors());


        if(api.contains(ADMIN) && authToken.getUserRole().equals(UserRole.ADMIN))
            return true;

        if(api.contains(USER) && authToken.getUserId().equals(ownerId))
            return true;

        return api.contains(ALL);

    }

    public static void verify(ApiPermissionType type, ApiPermissionOperation operation, AuthToken authToken, Long ownerId) {

        if(!hasPermission(type, operation, authToken, ownerId))
            throw new ApiResponseStatus(403);

    }

    public static void verify(ApiPermissionType type, ApiPermissionOperation operation, AuthToken authToken) {
        verify(type, operation, authToken, -1L);
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ApiPermission that = (ApiPermission) o;
        return getType() == that.getType() &&
                getOperation() == that.getOperation();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getType(), getOperation());
    }

}
