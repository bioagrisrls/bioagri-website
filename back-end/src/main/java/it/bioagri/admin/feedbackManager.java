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

package it.bioagri.admin;

import it.bioagri.models.Feedback;
import it.bioagri.models.FeedbackStatus;
import it.bioagri.persistence.DataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class feedbackManager {


    private final DataSource dataSource;


    public feedbackManager(DataSource dataSource) {
        this.dataSource = dataSource;
    }


    @PostMapping("/admin/feedbacks/update/status")
    public void updateStatus(@RequestParam  long id, @RequestParam FeedbackStatus feedbackStatus) {

        dataSource.update(
                """
                    UPDATE shop_feedback 
                    SET  status = ?
                    WHERE id = ?
                    """,
                s -> {
                    s.setInt(1,feedbackStatus.ordinal());
                    s.setLong(2, id);
                });

    }


    @GetMapping("/admin/feedbacks")
    public String getAllPendingFeedbacks(ModelMap model){

        List<CustomFeedback> customFeedbacks = new ArrayList<>();

        for(Feedback feedback : dataSource.getFeedbackDao().findAll()){

            if(feedback.getStatus() == FeedbackStatus.WAIT_FOR_REVISION) {

                String[] date = feedback.getCreatedAt().toString().split(" |\\.");

                customFeedbacks.add(new CustomFeedback(

                        feedback.getId(),
                        feedback.getProduct(dataSource).get().getName(),
                        feedback.getUser(dataSource).get().getName(),
                        feedback.getDescription(),
                        date[0],
                        date[1]


                ));
            }
        }

        model.addAttribute("feedbacks",customFeedbacks);

        return "/admin/feedbacks";

    }





}

