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

package it.bioagri.api.categories;

import io.restassured.RestAssured;
import it.bioagri.api.auth.AuthTest;
import org.junit.jupiter.api.Test;
import org.springframework.test.context.event.annotation.AfterTestMethod;


public class CategoriesTest {

    private String createAs(String username, int expectedCode) {

        return RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123"))
                .spec(AuthTest.getSpecs())
                .body(
                        """
                        {
                            "id" : "0",
                            "name" : "TestCategory"
                        }
                        """
                )
                .post("/categories")
                .then()
                .statusCode(expectedCode)
                .extract()
                .header("Location");

    }


    @Test
    public void create() {

        createAs("user@test.com", 403);
        createAs("admin@test.com", 201);

    }



    @Test
    public void findAll() {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("user@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .get("/categories")
                .then()
                .statusCode(200);

    }


    @Test
    @AfterTestMethod("create")
    public void findById() {

        var categoryId = createAs("admin@test.com", 201).split("/")[3];

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("user@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .get("/categories/" + categoryId)
                .then()
                .statusCode(200);

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("admin@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .get("/categories/" + categoryId)
                .then()
                .statusCode(200);

    }


    @Test
    @AfterTestMethod("create")
    public void deleteAll() {
        // Just skip...
    }

    @Test
    @AfterTestMethod("findById")
    public void delete() {

        var categoryId = createAs("admin@test.com", 201).split("/")[3];

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("user@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .delete("/categories/" + categoryId)
                .then()
                .statusCode(403);

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("admin@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .delete("/categories/" + categoryId)
                .then()
                .statusCode(204);

    }

}