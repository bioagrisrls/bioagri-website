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

package it.bioagri.api.products;

import io.restassured.RestAssured;
import it.bioagri.api.auth.AuthTest;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ProductsTest {

    public static String createAs(String username,  int expectedCode) {
        return RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .body(
                        """
                                {

                                    "id"         : "0",
                                    "name"       : "productTest",
                                    "description": "descriptionTest",
                                    "price"      : "100",
                                    "stock"      : "20",
                                    "status"     : "1",
                                    "updatedAt"  : "2014-01-01T23:28:56.782Z",
                                    "createdAt"  : "2014-01-01T23:28:56.782Z"
                                          
                                }
                                """
                )
                .post("/products")
                .then()
                .statusCode(expectedCode)
                .extract()
                .header("Location");
    }


    @Test
    public void createUserAsAdmin(){
        createAs("admin@test.com",201);
    }

    @Test
    public void createUserAsUser(){
        createAs("user@test.com",403);
    }

    @Test
    void findAll(String username) {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .get("/products/")
                .then()
                .statusCode(200);

    }


    @Test
    public void findAllAs(){

        findAll("admin@test.com");


    }

    @Test
    private void findById(String username) {

        String productId = createAs("admin@test.com", 201).split("/")[3];

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .get("/products/3")
                .then()
                .statusCode(200);

    }


    @Test
    public void findbyIdTest(){
        findById("user@test.com");
    }


    @Test
    void update() {
    }

    @Test
    void deleteAll() {
    }

    @Test
    void delete() {
    }
}