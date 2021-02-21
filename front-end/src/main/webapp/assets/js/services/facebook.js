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


const facebookAppId = '1016981521711613';

/**
 * Authenticate with Facebook API and retrieve user information.
 * @param form {string} Component ID
 * @return {Promise<T | void>}
 */
const facebookAuthenticate = (form = undefined) => {

    return FB.login(response => {

        if(response.status === 'connected' && response.authResponse) {

            return FB.api('/me?fields=birthday,email,first_name,last_name,gender', me => {

                window.components[form].onSubmit({

                    auth        : 'AUTH_SERVICE_EXTERNAL',
                    token       : response.authResponse.accessToken,
                    username    : me.email,
                    password    : '<<AUTH_TYPE_FACEBOOK>>',
                    name        : (me.first_name || ''),
                    surname     : (me.last_name  || ''),
                    gender      : (me.gender || 'PREFER_NOT_SAID').toUpperCase(),
                    phone       : '',
                    birth       : new Date(me.birthday).toISOString(),
                    legals      : true,

                });

            });

        }

    }, {
        scope: 'public_profile,email,user_birthday,user_gender'
    });

}


window.fbAsyncInit = () => {

    FB.init({
        appId       : facebookAppId,
        oauth       : true,
        cookie      : true,
        status      : true,
        xfbml       : true,
        version     : 'v9.0'
    });

};



