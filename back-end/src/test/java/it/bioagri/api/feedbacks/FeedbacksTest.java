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
import io.restassured.path.json.JsonPath;
import it.bioagri.api.auth.AuthTest;
import org.junit.jupiter.api.Test;
import org.springframework.test.context.event.annotation.AfterTestMethod;

class FeedbacksTest {

    private String createAs(String username,  String productId, String userId, int expectedCode) {
        return RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .body(String.format(
                        """
                        {
                            "userId"     : "%s",  
                            "title"       : "TestFeedback",
                            "vote"        : "5",
                            "id"          : "0",
                            "description" : "descriptionTest",
                            "updatedAt"  : "2014-01-01T23:28:56.782Z",
                            "createdAt"  : "2014-01-01T23:28:56.782Z",
                            "productId"  : "%s"           
                        }
                        """,userId,productId)
                )
                .post("/feedbacks")
                .then()
                .statusCode(expectedCode)
                .extract()
                .header("Location");

    }



    void findAll() {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("user@test.com", "123"))
                .spec(AuthTest.getSpecs())
                .get("/feedbacks/")
                .then()
                .statusCode(200);

    }


    @AfterTestMethod("create")
    void findById(String feedbackId, int expectedCode) {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate("admin@test.com", "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .get("/feedbacks/" + feedbackId )
                .then()
                .statusCode(expectedCode);
    }


    @AfterTestMethod("create")
    void update(String feedbackId, String username, String userId, int expextedCode) {

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .body(
                        """
                        {
                            "userId"     : "%s",  
                            "title"       : "TestFeedback",
                            "vote"        : "1",
                            "id"          : "%s",
                            "description" : "descriptionTest",
                            "updatedAt"  : "2014-01-01T23:28:56.782Z",
                            "createdAt"  : "2014-01-01T23:28:56.782Z",
                            "productId"  : "3"           
                        }
                        """.formatted(userId, feedbackId)
                )
                .put("/feedbacks/" + feedbackId)
                .then()
                .statusCode(expextedCode)
                .extract()
                .header("Location");

    }


    void deleteAll(int expectedCode) {

        RestAssured.given()
                .header("X-Auth-Token",  AuthTest.authenticate("admin@test.com", "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .delete("/feedbacks")
                .then()
                .statusCode(expectedCode);
    }


    @AfterTestMethod("create")
    void deleteById(String username, String feedbackId, int expectedCode) {

        RestAssured.given()
                .header("X-Auth-Token",  AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .delete("/feedbacks/" + feedbackId )
                .then()
                .statusCode(expectedCode);

    }



    public void launchAllMethodsAs(String username) {

        String userId = AuthTest.authenticate(username, "123").getString("userId");
        String feedbackId = createAs(username, "3", userId, 201).split("/")[3];

        if(feedbackId == null)
            return;

        findById(feedbackId,200);
        update(feedbackId, username,userId, 201);
        deleteById(feedbackId, username, 204);
        deleteAll(204);


    }


    public void createWithNotAuthorizedUser(){

        String userId = AuthTest.authenticate("user@test.com", "123").getString("userId");
        createAs("user@test.com", "3", userId + 1, 403);

    }



    public void updateWithNotAuthorizedUser(){

        String userIdX = AuthTest.authenticate("user@test.com", "123").getString("userId");
        String userIdY = AuthTest.authenticate("user2@test.com", "123").getString("userId");

        String feedbackY = createAs("user2@test.com", "3", userIdY, 201).split("/")[3];


        update(feedbackY, "user@test.com", userIdX, 403);

    }

    @Test
    public void deleteWithNotAuthorizedUser(){

        String userIdY = AuthTest.authenticate("user2@test.com", "123").getString("userId");
        String feedbackY = createAs("user2@test.com", "3", userIdY, 201).split("/")[3];
        deleteById("user@test.com", feedbackY , 403);

    }


    public void launchAllmethod(){

        launchAllMethodsAs("admin@test.com");
        launchAllMethodsAs("user@test.com");

    }





}