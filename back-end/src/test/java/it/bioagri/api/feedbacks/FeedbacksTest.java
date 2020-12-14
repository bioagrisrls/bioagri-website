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

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import static org.junit.jupiter.api.Assertions.*;

class FeedbacksTest {

    private String createAs(String username,  int productId, int userId, int expectedCode) {
        return RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123"))
                .spec(AuthTest.getSpecs())
                .body(String.format(
                        """
                        {
                            "userId"     : "%d",  
                            "title"       : "TestFeedback",
                            "vote"        : "5",
                            "id"          : "0",
                            "description" : "descriptionTest",
                            "updatedAt"  : "2014-01-01T23:28:56.782Z",
                            "createdAt"  : "2014-01-01T23:28:56.782Z",
                            "productId"  : "%d"           
                        }
                        """,userId,productId)
                )
                .post("/feedbacks")
                .then()
                .statusCode(expectedCode)
                .extract()
                .header("Location");

    }

    @Test
    public void createFeedback() {

        createAs("user@test.com", 3,1,201);
        createAs("admin@test.com", 3,6,201);

    }


    @Test
    void findAll() {

        //var feedbackId = createAs("admin@test.com", 201).split("/")[3];

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("user@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .get("/feedbacks/")
                .then()
                .statusCode(200);

    }

    @Test
    void findById() {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("admin@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .get("/feedbacks/" + "4" )
                .then()
                .statusCode(200);

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("user@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .get("/feedbacks/" + "4" )
                .then()
                .statusCode(200);
    }

    @Test
    void update() {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("admin@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .body(
                        """
                        {
                            "userId"     : "1",  
                            "title"       : "TestFeedback",
                            "vote"        : "1",
                            "id"          : "0",
                            "description" : "descriptionTest",
                            "updatedAt"  : "2014-01-01T23:28:56.782Z",
                            "createdAt"  : "2014-01-01T23:28:56.782Z",
                            "productId"  : "1"           
                        }
                        """
                )
                .put("/feedbacks/3")
                .then()
                .statusCode(201)
                .extract()
                .header("Location");

    }

    @Test
    void deleteAll() {
        // Just skip...
    }

    @Test
    void deleteById() {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("admin@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .delete("/feedbacks/" + "4" )
                .then()
                .statusCode(204);

    }
}