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


const baseUri = "http://localhost:8080";
const basePath = "/api";


/**
 * Make a request to back-end and retrive, add, edit and delete data.
 * @param path {string}
 * @param method {string}
 * @param body {object}
 * @param returnJson {boolean}
 * @returns {Promise<Response>}
 */
const api = async (path, method = 'GET', body = {}, returnJson = true) => {

    return fetch(baseUri + basePath + path, {

        method: method,
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'include',
        redirect: 'follow',
        referrerPolicy: 'no-referrer',

        headers: {
            'X-Auth-Token': Cookies.get('X-Auth-Token'),
            'Content-Type': 'application/json',
            'Accept'      : 'application/json',
        },

        body: method !== 'GET' ? JSON.stringify(body) : null

    }).then(response => {

        if(response.headers.has('X-Auth-Token'))
            Cookies.set('X-Auth-Token', response.headers.get('X-Auth-Token'));

        if(response.status < 200 || response.status > 299)
            throw new Error(`failed: ${response.status}`);

        if(returnJson)
            return response.json();

        return response;

    });

}


/**
 * Authenticate with back-end and getting a new auth-token.
 * @param username {string}
 * @param password {string}
 * @returns {Promise<* | void>}
 */
const authenticate = async (username, password) => {

    return api('/auth/authenticate', 'POST', {
        username: username,
        password: password
    }).then(
        response => {
            Cookies.set('X-Auth-Token', response.token, {
                secure: true,
                sameSite: 'strict'
            });
            return response;
        },
        reason => {
            throw reason;
        }
    );

}


/**
 * Check if client is currently authenticated.
 * @returns {Promise<boolean>}
 */
const authenticated = async () => {

    return api('/auth/verify')
        .then(response => true)
        .catch(reason => false);

}
