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
import it.bioagri.api.categories.CategoriesTest;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ProductCategoriesTest {



    public static String createAs(String username,  int expectedCode) {

        //String productId = ProductsTest.createAs(username,201).split("/")[3];
        //String categoryId = CategoriesTest.createAs(username, 201).split("/")[3];

        return RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .put("/products/25/categories/28")
                .then()
                .statusCode(expectedCode)
                .extract()
                .header("Location");
    }

    @Test
    public void createAsTest(){
        createAs("admin@test.com", 201);
    }


    @Test
    void findAll(String username) {

        String id = ProductsTest.createAs(username,201).split("/")[3];

        RestAssured.given()
                .header("X-Auth-Token", AuthTest.authenticate(username, "123").getString("token"))
                .spec(AuthTest.getSpecs())
                .get("/products/" + id +"/categories")
                .then()
                .statusCode(200);


    }


    @Test
    public void findAllTest(){

        findAll("admin@test.com");

    }

}