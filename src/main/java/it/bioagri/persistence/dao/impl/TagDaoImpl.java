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

import it.bioagri.models.Tag;
import it.bioagri.persistence.DataSource;
import it.bioagri.persistence.dao.TagDao;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

public class TagDaoImpl extends TagDao {

    public TagDaoImpl(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Optional<Tag> findByPrimaryKey(Long id) {

        final AtomicReference<Optional<Tag>> result = new AtomicReference<>(Optional.empty());

        getDataSource().fetch("SELECT * FROM shop_tag WHERE shop_tag.id = ?",
                s -> s.setLong(1, id),
                r -> result.set(Optional.of(new Tag(
                        r.getLong("id"),
                        r.getString("hashtag")
                )))
        );

        return result.get();

    }

    @Override
    public List<Tag> findAll() {

        final var tags = new ArrayList<Tag>();

        getDataSource().fetch("SELECT * FROM shop_tag", null,
                r -> tags.add(new Tag(
                        r.getLong("id"),
                        r.getString("hashtag")
                ))
        );

        return tags;

    }

    @Override
    public void save(Tag value) {

    }

    @Override
    public void update(Tag oldValue, Tag newValue) {

    }

    @Override
    public void delete(Tag value) {

    }

}
