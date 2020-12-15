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


DELETE FROM shop_category;
DELETE FROM shop_feedback;
DELETE FROM shop_order;
DELETE FROM shop_order_product;
DELETE FROM shop_product;
DELETE FROM shop_product_category;
DELETE FROM shop_product_tag;
DELETE FROM shop_tag;
DELETE FROM shop_ticket;
DELETE FROM shop_ticket_response;
DELETE FROM shop_transaction;
DELETE FROM shop_user;
DELETE FROM shop_wish;

ALTER SEQUENCE shop_category_id_seq RESTART 1;
ALTER SEQUENCE shop_feedback_id_seq RESTART 1;
ALTER SEQUENCE shop_hashtag_id_seq RESTART 1;
ALTER SEQUENCE shop_order_id_seq RESTART 1;
ALTER SEQUENCE shop_product_id_seq RESTART 1;
ALTER SEQUENCE shop_ticket_id_seq RESTART 1;
ALTER SEQUENCE shop_ticket_response_id_seq RESTART 1;
ALTER SEQUENCE shop_transaction_id_seq RESTART 1;
ALTER SEQUENCE shop_user_id_seq RESTART 1;