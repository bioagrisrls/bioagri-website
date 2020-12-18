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

package it.bioagri.api.orders;

import io.restassured.RestAssured;
import io.restassured.path.json.JsonPath;
import it.bioagri.api.auth.AuthTest;
import it.bioagri.models.OrderStatus;
import org.junit.jupiter.api.Test;

import java.sql.Timestamp;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

class OrdersTest {



    JsonPath jsonPath;
    String adminIdOrder;

    String defaultValue = null;

    private String createAs(String username, String userId, int expectedCode) {

        jsonPath = AuthTest.authenticate(username, "123");

        if(userId == defaultValue)
            userId = jsonPath.getString("userId");

        return RestAssured.given()
                .header("X-Auth-Token", jsonPath.getString("token"))
                .spec(AuthTest.getSpecs())
                .body(
                        """
                        {
                        "id"        : "0",
                        "userId"    : "%s",
                        "status"    : "1",
                        "createdAt" : "2014-01-01T23:28:56.782Z",
                        "updatedAt" : "2015-01-01T23:28:56.782Z"
                        }
                        """.formatted(userId)
                )
                .post("/orders")
                .then()
                .statusCode(expectedCode)
                .extract()
                .header("Location");


    }

    private void createAdminOrders(){

        adminIdOrder = createAs("admin@test.com", defaultValue,201).split("/")[3];

    }


    private String createUserOrders() {

        return createAs("user@test.com", defaultValue, 201).split("/")[3];

    }

    private String createAlternativeOrder(){
       return createAs("user2@test.com", defaultValue, 201).split("/")[3];
    }





    private void findAll() {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("admin@test.com", "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .get("/orders")
                .then()
                .statusCode(200);

    }


    private void findById(String username, String orderId, int expectedCode) {

        if(orderId == defaultValue)
            orderId = createAs(username, defaultValue, 201).split("/")[3];
        else
            createAs(username, defaultValue, 201);

        RestAssured.given()
                .header("X-Auth-Token", jsonPath.getString("token"))
                .spec(AuthTest.getSpecs())
                .get("/orders/" + orderId)
                .then()
                .statusCode(expectedCode);

    }


    private void update(String username) {

        String idOrder = createAs(username, defaultValue, 201).split("/")[3];

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .body(
                        """
                        {
                        "id"        : "%s",
                        "userId"    : "%s",
                        "status"    : "1",
                        "createdAt" : "2001-01-01T23:28:56.782Z",
                        "updatedAt" : "2015-01-01T23:28:56.782Z"
                        }
                        """.formatted(idOrder, jsonPath.getString("userId"))
                )
                .put("/orders/" + idOrder )
                .then()
                .statusCode(201)
                .extract()
                .header("Location");

    }

    private void deleteAll(String username, int expectedCode) {

        RestAssured.given()
                .header("X-Auth-Token",  AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .delete("/orders")
                .then()
                .statusCode(expectedCode);
    }


    private void deleteById(String username, String orderId, int expectedCode) {

        if(orderId == defaultValue)
            orderId = createAs(username, defaultValue, 201).split("/")[3];

        RestAssured.given()
                .header("X-Auth-Token",  AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .delete("/orders/" + orderId)
                .then()
                .statusCode(expectedCode);

    }


    private void createWithNotAuthorizedUser(){
        createAs("user@test.com", createAlternativeOrder(), 403);
    }


    private void findByIdWithNotAuthorizedUser(){
        findById("user@test.com", createAlternativeOrder(), 403);
    }


    private void deleteByIdWithNotAuthorizedUser(){
        deleteById("user@test.com", createAlternativeOrder(), 403);
    }



    private void launchAllCrudMethodsAsAdmin(){

        createAdminOrders();
        findById("admin@test.com",defaultValue,200);
        update("admin@test.com");
        deleteById("admin@test.com", defaultValue, 204);
        deleteAll("admin@test.com", 204);

    }



    private void launchAllCrudMethodsAsUser() {

        createUserOrders();
        findById("user@test.com", defaultValue, 200);
        update("user@test.com");
        deleteById("user@test.com", defaultValue, 204);
        deleteAll("user@test.com", 204);

    }


    private void launchAllCrudMethods(){

        launchAllCrudMethodsAsAdmin();
        launchAllCrudMethodsAsUser();

    }

    private void launchAllNotAuthorizedMethods(){

        createWithNotAuthorizedUser();
        findByIdWithNotAuthorizedUser();
        deleteByIdWithNotAuthorizedUser();

    }

    @Test
    public void testAll(){

        launchAllCrudMethods();
        launchAllNotAuthorizedMethods();

    }


}