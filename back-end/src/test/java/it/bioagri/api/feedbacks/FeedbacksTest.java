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

package it.bioagri.api.feedbacks;

import io.restassured.RestAssured;
import it.bioagri.api.auth.AuthTest;
import org.junit.jupiter.api.Test;

class FeedbacksTest {

    private String createAs(String username,  int product_id, int user_id, int expectedCode) {
        return RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123"))
                .spec(AuthTest.getSpecs())
                .body(String.format(
                        """
                        {
                            "id"          : "0",
                            "title"       : "TestFeedback",
                            "description" : "descriptionTest",
                            "vote"        : "5",
                            "product_id"  : "%d",
                            "created_at"  : "2020-12-14 16:32:23.896573",
                            "updated_at"  : "2020-12-14 17:32:23.896573",
                            "user_id"     : "%d"     
                        }
                        """,product_id, user_id)
                )
                .post("/feedbacks")
                .then()
                .statusCode(expectedCode)
                .extract()
                .header("Location");

    }

    @Test
    public void createFeedback() {

        createAs("user@test.com", 1,1,200);
        //createAs("admin@test.com", 201);

    }


    @Test
    void findAll() {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("admin@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .get("/feedbacks")
                .then()
                .statusCode(200);

    }

    @Test
    void findById() {
    }

    @Test
    void create() {
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