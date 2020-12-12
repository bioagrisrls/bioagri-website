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

package it.bioagri.models;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public final class User {

    private final long id;
    private final String mail;
    private final String password;
    private final UserStatus status;
    private final UserRole role;
    private final String name;
    private final String surname;
    private final UserGender gender;
    private final String phone;
    private final Date birth;
    private final Timestamp createdAt;
    private final Timestamp updatedAt;
    private final List<Product> wishList;
    private final List<Feedback> feedbacks;
    private final List<Ticket> tickets;


    public User(long id, String mail, String password, UserStatus status, UserRole role, String name, String surname, UserGender gender, String phone, Date birth, Timestamp createdAt, Timestamp updatedAt, List<Product> wishList, List<Feedback> feedbacks, List<Ticket> tickets) {
        this.id = id;
        this.mail = mail;
        this.password = password;
        this.status = status;
        this.role = role;
        this.name = name;
        this.surname = surname;
        this.gender = gender;
        this.phone = phone;
        this.birth = birth;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.wishList = wishList;
        this.feedbacks = feedbacks;
        this.tickets = tickets;
    }

    public long getId() {
        return id;
    }

    public String getMail() {
        return mail;
    }

    public String getPassword() {
        return password;
    }

    public UserStatus getStatus() {
        return status;
    }

    public UserRole getRole() {
        return role;
    }

    public String getName() {
        return name;
    }

    public String getSurname() {
        return surname;
    }

    public UserGender getGender() {
        return gender;
    }

    public String getPhone() {
        return phone;
    }

    public Date getBirth() {
        return birth;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    @JsonIgnore
    public List<Product> getWishList() {
        return wishList;
    }

    @JsonIgnore
    public List<Feedback> getFeedbacks() {
        return feedbacks;
    }

    @JsonIgnore
    public List<Ticket> getTickets() {
        return tickets;
    }

}
