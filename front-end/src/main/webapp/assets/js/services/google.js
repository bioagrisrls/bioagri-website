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


const googleClientId = '209781809708-5uqvtbr7fs9t4qs3bqnjo54b0rin6kk8.apps.googleusercontent.com';
const googleApiKey = 'AIzaSyDcF1UyP_gAhnjj3_8gnqnVBOelDDiIdQA';


/**
 * Authenticate with Google API and retrieve user information.
 * @param form {string} Component ID
 * @return {Promise<T | void>}
 */
const googleAuthenticate = (form = undefined) => {

    return gapi.load('client:auth2', () => {

        return gapi.auth2.init({ client_id: googleClientId })
            .then(() => {

                return gapi.auth2.getAuthInstance()
                    .signIn({

                        scope:
                            'https://www.googleapis.com/auth/user.birthday.read '       +
                            'https://www.googleapis.com/auth/user.gender.read '         +
                            'https://www.googleapis.com/auth/user.phonenumbers.read '   +
                            'https://www.googleapis.com/auth/userinfo.email '           +
                            'https://www.googleapis.com/auth/userinfo.profile'

                    }).then(auth => {

                        gapi.client.setApiKey(googleApiKey);

                        return gapi.client.load('https://people.googleapis.com/$discovery/rest?version=v1')
                            .then(() => {

                                return gapi.client.people.people.get({

                                    'resourceName': 'people/me',
                                    'personFields': 'birthdays,genders,names,phoneNumbers',
                                    'prettyPrint': false,

                                }).then(response => {

                                    const result = response.result;
                                    const profile = auth.getBasicProfile();
                                    const token = auth.getAuthResponse().id_token;

                                    if(form) {

                                        if(!window.components[form] || !window.components[form].onSubmit)
                                            throw new Error("Component " + form + " invalid or not found.");


                                        const extractValue = (r) => {
                                            return (r && r.value) || '';
                                        };

                                        const extractDate = (r) => {
                                            return (r && new Date (
                                                r.date.year     || 0,
                                                (r.date.month   || 0) - 1,
                                                r.date.day      || 0
                                            ).toISOString()) || '';
                                        };


                                        window.components[form].onSubmit({

                                            auth        : 'AUTH_SERVICE_EXTERNAL',
                                            service     : '<<AUTH_TYPE_GOOGLE>>',
                                            username    : profile.getEmail(),
                                            password    : token,
                                            name        : profile.getGivenName(),
                                            surname     : profile.getFamilyName(),
                                            gender      : result.genders    && extractValue(result.genders.filter (i => i.metadata.primary)[0]),
                                            phone       : result.phones     && extractValue(result.phones.filter (i => i.metadata.primary)[0]),
                                            birth       : result.birthdays  && extractDate(result.birthdays.filter (i => i.metadata.source.type === 'ACCOUNT')[0]),
                                            legals      : true,

                                        });

                                    }


                                    return {
                                        result: result,
                                        profile: profile,
                                        token: token
                                    };

                                });


                            });

                    });

            });

    }).catch(reason => { console.error("Google Authentication failed:", reason); throw reason; });

}