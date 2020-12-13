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

package it.bioagri.persistence.dao.impl;

import it.bioagri.models.Feedback;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.FeedbackDao;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

public class FeedbackDaoImpl extends FeedbackDao {

    public FeedbackDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<Feedback> findByPrimaryKey(Long id) {

        final AtomicReference<Optional<Feedback>> result = new AtomicReference<>(Optional.empty());

        getDataSource().fetch("SELECT * FROM shop_feedback WHERE shop_feedback.id = ?",
                s -> s.setLong(1, id),
                r -> result.set(Optional.of(new Feedback(
                        r.getLong("id"),
                        r.getString("title"),
                        r.getString("description"),
                        r.getFloat("vote"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        r.getLong("user_id"),
                        r.getLong("product_id")
                )))
        );

        return result.get();

    }

    @Override
    public List<Feedback> findAll() {

        final var feedbacks = new ArrayList<Feedback>();

        getDataSource().fetch("SELECT * FROM shop_feedback", null,
                r -> feedbacks.add(new Feedback(
                        r.getLong("id"),
                        r.getString("title"),
                        r.getString("description"),
                        r.getFloat("vote"),
                        r.getTimestamp("created_at"),
                        r.getTimestamp("updated_at"),
                        r.getLong("user_id"),
                        r.getLong("product_id")
                ))
        );

        return feedbacks;

    }

    @Override
    public void save(Feedback value) {

    }

    @Override
    public void update(Feedback oldValue, Feedback newValue) {

    }

    @Override
    public void delete(Feedback value) {

    }


    @Override
    public List<Feedback> findByUserId(Long id) {

        var feedbacks = new ArrayList<Feedback>();

        getDataSource().fetch("SELECT * FROM shop_feedback WHERE shop_feedback.user_id = ?",
                s -> s.setLong(1, id),
                r -> findByPrimaryKey(r.getLong("id")).ifPresent(feedbacks::add));

        return feedbacks;

    }
}
