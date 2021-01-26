<%--
  ~ MIT License
  ~
  ~ Copyright (c) 2020 BioAgri S.r.l.s.
  ~
  ~ Permission is hereby granted, free of charge, to any person obtaining a copy
  ~ of this software and associated documentation files (the "Software"), to deal
  ~ in the Software without restriction, including without limitation the rights
  ~ to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  ~ copies of the Software, and to permit persons to whom the Software is
  ~ furnished to do so, subject to the following conditions:
  ~
  ~ The above copyright notice and this permission notice shall be included in all
  ~ copies or substantial portions of the Software.
  ~
  ~ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  ~ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  ~ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  ~ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  ~ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  ~ OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  ~ SOFTWARE.
  ~
  --%>

<%--@elvariable id="components" type="java.util.Map"--%>
<%--@elvariable id="locale" type="java.util.Map"--%>
<%--@elvariable id="reference" type="java.lang.String"--%>


<script defer>

    Component.register('ui-registration', (id, props) => new class extends FormComponent {

        constructor() {
            super(id, {

                $header: ``,

                $footer: `
                    <hr>
                    <div class="text-center">
                        <button onclick="googleAuthenticate('` + id.id + `')" class="btn-auth-google"><span class="mdi mdi-google"></span></button>
                        <button class="btn-auth-facebook"><span class="mdi mdi-facebook"></span></button>
                        <button class="btn-auth-twitter"><span class="mdi mdi-twitter"></span></button>
                    </div>
                `,

                $submit: {
                    value: `${locale.registration_button}`,
                    align: 'center',
                    style: 'btn-lg btn-block ui-font-title-primary'
                },



                auth: {
                    type: 'hidden',
                    value: 'AUTH_SERVICE_INTERNAL'
                },

                token: {
                    type: 'hidden'
                },

                username: {
                    type: 'email',
                    label: "${locale.registration_username}",
                    pattern: /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/,
                    required: true,
                    autocomplete: 'email',
                    size: 128,
                    wrong: "${locale.registration_username_wrong}"
                },

                password: {
                    type: 'password',
                    label: "${locale.registration_password}",
                    minlength: 8,
                    pattern: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/,
                    required: true,
                    autocomplete: 'new-password',
                    size: 128,
                },

                name: {
                    type: 'text',
                    label: '${locale.registration_name}',
                    required: true,
                    autocomplete: 'given-name',
                    maxlength: 32
                },

                surname: {
                    type: 'text',
                    label: '${locale.registration_surname}',
                    required: true,
                    autocomplete: 'family-name',
                    maxlength: 32
                },

                gender: {
                    type: 'select',
                    label: '${locale.registration_gender}',
                    required: true,
                    autocomplete: 'sex',
                    options: [
                        { key: '${locale.registration_gender_female}',    value: 'FEMALE'     },
                        { key: '${locale.registration_gender_male}',      value: 'MALE'       },
                        { key: '${locale.registration_gender_other}',     value: 'OTHER'      },
                        { key: '${locale.registration_gender_undefined}', value: 'UNDEFINED'  },
                    ]
                },

                birth: {
                    type: 'date',
                    label: '${locale.registration_birth}',
                    required: true,
                    autocomplete: 'bday'
                },

                phone: {
                    type: 'tel',
                    label: '${locale.registration_phone}',
                    required: true,
                    autocomplete: 'tel',
                    minlength: 9,
                    maxlength: 11,
                    size: 11
                },

                legals: {
                    type: 'switch',
                    label: `${locale.registration_legal}`,
                    style: 'my-5',
                    required: true
                },


            });
        }

        onReady(state) {
            this.state = { $state: 'need-registration' };
        }


        onSubmit(data) {

            const hash = (str) => crypto.subtle
                .digest("SHA-512", new TextEncoder().encode(str))
                .then(buf => Array.prototype.map.call(new Uint8Array(buf), i => ('00' + i.toString(16)).slice(-2)).join(''));


            return (data.auth === 'AUTH_SERVICE_INTERNAL'
                    ? hash(data.password)
                    : new Promise(resolve => resolve(data.password))
            ).then(password => api('/auth/signup', 'POST', {

                    id          : 0,
                    mail        : data.username,
                    password    : password,
                    status      : 'WAIT_FOR_MAIL',
                    role        : 'CUSTOMER',
                    name        : data.name,
                    surname     : data.surname,
                    gender      : (data.gender || 'PREFER_NOT_SAID').toUpperCase(),
                    phone       : data.phone || '',
                    birth       : data.birth || '',
                    auth        : data.auth,
                    createdAt   : new Date().toISOString(),
                    updatedAt   : new Date().toISOString(),

                }, false)
                    .then(response => authenticate(data.username, password, false, data.token)
                        .then(response => {

                            if (window.history.length)
                                window.history.back();
                            else
                                navigate('/home');

                        })
                    )

            ).catch(reason => {

                switch (reason) {

                    case 400:
                        return this.state = {$state: 'wrong', $reason: ['name', 'surname', 'phone']};
                    case 406:
                        return this.state = {$state: 'wrong', $reason: ['username']};
                    default:
                        return this.state = {$state: 'error', $reason: reason};

                }

            });

        }

    });

</script>
