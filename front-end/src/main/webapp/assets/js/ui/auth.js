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
 * @param triggerEvent {boolean}
 * @returns {Promise<* | void>}
 */
const authenticate = async (username, password, store = false, token = '', triggerEvent = true) => {

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


            if(triggerEvent)
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
 * @param triggerEvent {boolean}
 * @returns {Promise<* | void>}
 */
const disconnect = async (redirectToHome= true, triggerEvent = true) => {

    return api('/auth/disconnect', 'POST', {}, false).then(
        response => {

            sessionStorage.clear();

            localStorage.removeItem('X-Auth-Username');
            localStorage.removeItem('X-Auth-Password');

            if(redirectToHome)
                navigate('/');


            if(triggerEvent)
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
 * @param triggerEvent {boolean}
 * @returns {Promise<* | void>}
 */
const authenticated = async (triggerEvent = true) => api('/auth/verify', 'GET', {}, false).catch(reason => {

    if(localStorage.getItem('X-Auth-Username')) {

        return authenticate(

            localStorage.getItem('X-Auth-Username'),
            localStorage.getItem('X-Auth-Password'),
            false,
            '',
            triggerEvent

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


const requestUserAuthentication = () => {

    const el = document.getElementById('ui-authentication-modal');
    const md = new bootstrap.Modal(el, {});

    md.show();

    $(document).on('auth-connection-occurred', () => {
        md.hide();
    });

};


$(document).ready(() => ((body) => {

    $(body).append(`
        <div class="modal fade" id="ui-authentication-modal">
          <div class="modal-dialog modal-dialog-centered modal-fullscreen-lg-down">
            <div class="modal-content">
              <div class="modal-header">
                <h5 id="ui-authentication-modal-title" class="modal-title"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
              </div>
              <div class="modal-body">
                <div class="px-5 py-3">
                  <ui-login id="ui-authentication-modal-login" ui:bind-1="#ui-authentication-modal-title:$title"></ui-login>
                </div>
              </div>
            </div>
          </div>
        </div>
    `);


}) (document.body));
