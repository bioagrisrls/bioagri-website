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

'use strict';


/**
 * Auth.js
 *
 * Events:
 *  - auth-connection-occurred: when a user is authenticating;
 *  - auth-disconnection-occurred: when a user is logging out.
 *
 */


/**
 * Authenticate with back-end and getting a new auth-token.
 * @param username {string}
 * @param password {string}
 * @param store {boolean}
 * @param token {string}
 * @returns {Promise<* | void>}
 */
const authenticate = async (username, password, store = false, token = '') => {

    return api('/auth/authenticate', 'POST', {

        username    : username,
        password    : password,
        token       : token,

    }).then(
        response => {

            if(store && !token) {
                localStorage.setItem('X-Auth-Username', username);
                localStorage.setItem('X-Auth-Password', password);
            }

            sessionStorage.setItem('X-Auth-Token', response.token);
            sessionStorage.setItem('X-Auth-UserInfo-Id', response.userId);
            sessionStorage.setItem('X-Auth-UserInfo-Role', response.userRole);


            $(document).trigger('auth-connection-occurred');

            return response;

        },
        reason => {
            throw reason;
        }
    );

}

/**
 * Disconnect from back-end and clear all authentication data.
 * @param redirectToHome {boolean}
 * @returns {Promise<* | void>}
 */
const disconnect = async (redirectToHome= true) => {

    return api('/auth/disconnect', 'POST', {}, false).then(
        response => {

            sessionStorage.clear();

            localStorage.removeItem('X-Auth-Username');
            localStorage.removeItem('X-Auth-Password');

            if(redirectToHome)
                navigate('/');


            $(document).trigger('auth-disconnection-occurred');

            return response;

        },
        reason => {
            throw reason;
        }
    )

}

/**
 * Check if client is currently authenticated.
 * @returns {Promise<* | void>}
 */
const authenticated = async () => api('/auth/verify', 'GET', {}, false).catch(reason => {

    if(localStorage.getItem('X-Auth-Username')) {

        return authenticate(

            localStorage.getItem('X-Auth-Username'),
            localStorage.getItem('X-Auth-Password'),

        ).catch(reason => {

            switch (reason) {

                case 404:
                case 400:

                    localStorage.removeItem('X-Auth-Username');
                    localStorage.removeItem('X-Auth-Password');

            }

            throw reason;

        })

    }

    throw reason;

});
