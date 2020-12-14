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

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.UUID;


public class AuthTest {

    public static RequestSpecification getSpecs() {
        return new RequestSpecBuilder()
                .setBaseUri(RestAssured.DEFAULT_URI)
                .setPort(8080)
                .setBasePath("/api")
                .setAccept(ContentType.JSON)
                .setContentType(ContentType.JSON)
                .setSessionId(RestAssured.sessionId)
                .addFilter(new RequestLoggingFilter())
                .addFilter(new ResponseLoggingFilter())
                .build();
    }

    public static String authenticate(String username, String password) {

        var response = RestAssured.given()
                .baseUri(RestAssured.DEFAULT_URI)
                .port(8080)
                .basePath("/api")
                .accept(ContentType.JSON)
                .contentType(ContentType.JSON)
                .sessionId(UUID.randomUUID().toString())
                .body(String.format(
                        """
                        {
                            "username" : "%s",
                            "password" : "%s"
                        }  
                        """, username, password))
                .post("/auth/authenticate");



        response.then().statusCode(200);
        response.then().contentType(ContentType.JSON);


        RestAssured.sessionId = response.sessionId();

        return response.then()
                .extract()
                .jsonPath()
                .getString("token");

    }




    @Test
    public void authenticateAsUserTest() {
        authenticate("user@test.com", "123");
    }

    @Test
    public void authenticateAsAdminTest() {
        authenticate("admin@test.com", "123");
    }

    @Test
    public void authenticateAsInvalidUserTest() {
        Assertions.assertThrows(AssertionError.class,
                () -> authenticate("invalid-username@test.com", "invalid-password"));
    }


    @Test
    public void disconnectAsUserTest() {

        RestAssured.given()
                .header("X-Auth-Token", authenticate("user@test.com", "123"))
                .spec(getSpecs())
                .get("/auth/disconnect")
                .then()
                .statusCode(200);

    }

    @Test
    public void disconnectAsAdminTest() {

        RestAssured.given()
                .header("X-Auth-Token", authenticate("admin@test.com", "123"))
                .spec(getSpecs())
                .get("/auth/disconnect")
                .then()
                .statusCode(200);

    }

    @Test
    public void disconnectWithNoToken() {

        RestAssured.sessionId = UUID.randomUUID().toString();
        RestAssured.given()
                .spec(getSpecs())
                .get("/auth/disconnect")
                .then()
                .statusCode(401);

    }



}