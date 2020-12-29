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


$(document).on('ui-ready', () => {

    gapi.load('auth2', () => {

        gapi.auth2.init({
            client_id: '270526632051-gbkhsqrar19bl94hvmau64nhoi5bobhm.apps.googleusercontent.com'
        }).then(
            (success) => {

                console.log(success);

                const auth2 = gapi.auth2.getAuthInstance();

                gapi.auth2.getAuthInstance().attachClickHandler('button-signin-google', {},

                    (user) => {
                        console.log(user);
                        console.log(user.getBasicProfile());
                    }, (error) => {
                        console.log(error);
                    }

                );

            },
            (error) => {

                console.log("ERROR!!", error);

            }
        )




    });

});

/**
 * On google sign-in access.
 * @param user {object}
 */
const googleOnSignIn = (user) => {

    const profile = user.getBasicProfile();

    console.log(user);
    console.log(profile);

}

const googleOnFailure = (error) => {
    console.log(error);
}

const googleSignInRender = () => {

    console.log("googleSignInRender");

    gapi.signin2.render('button-signin-google', {
        'scope': 'profile email',
        'width': 240,
        'height': 50,
        'longtitle': true,
        'theme': 'dark',
        'onsuccess': googleOnSignIn,
        'onfailure': googleOnFailure
    });

}

