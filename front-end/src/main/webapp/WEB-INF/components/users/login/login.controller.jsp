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

    Component.register('ui-login', (id, props) => new class extends FormComponent {

        constructor() {
            super(id, {

                auth: {
                    type: 'hidden',
                    value: 'AUTH_SERVICE_INTERNAL'
                },

                token: {
                    type: 'hidden'
                },

                username: {
                    type: 'email',
                    label: "Indirizzo email", // FIXME
                    pattern: /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/,
                    required: true,
                    size: 128, // FIXME
                    wrong: "Username wrong! (FIXME)"
                },

                password: {
                    type: 'password',
                    label: "Password", // FIXME
                    minlength: 8,
                    pattern: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/,
                    required: true,
                    size: 128,
                    wrong: "Password wrong! (FIXME)"
                },

                store: {
                    type: 'switch',
                    label: "Resta connesso" // FIXME
                },

                $submit: {
                    value: 'Login',
                    align: 'center'
                }, // FIXME


                $title: 'Accedi (FIXME)'

            });
        }


        onReady(state) {

            authenticated()
                .then(() => api('/users/' + sessionStorage.getItem('X-Auth-UserInfo-Id'))
                    .then(response => this.state = { $state: 'ok', $userInfo: response })
                )
                .catch(() => this.state = { $state: 'need-login' });


            $(document).on('auth-connection-occurred', () => {
                if(this.running) {
                    api('/users/' + sessionStorage.getItem('X-Auth-UserInfo-Id'))
                        .then(response => this.state = { $state: 'ok', $userInfo: response });
                }
            });

            $(document).on('auth-disconnection-occurred', () => {
                if(this.running) {
                    this.state = { $state: 'need-login' }
                }
            });

        }

        onSubmit(data) {

            const hash = (str) => crypto.subtle
                .digest("SHA-512", new TextEncoder().encode(str))
                .then(buf => Array.prototype.map.call(new Uint8Array(buf), i => ('00' + i.toString(16)).slice(-2)).join(''));

            return (data.auth === 'AUTH_SERVICE_INTERNAL'
                    ? hash(data.password)
                    : new Promise(resolve => resolve(data.password))
            ).then(password => authenticate(data.username, password, data.store, data.token)
                    .then(response => api('/users/' + response.userId)
                    .then(response => this.state = { $state: 'ok', $userInfo: response }))
            ).catch(reason => {

                switch(reason) {
                    case 401:
                        return this.state = { $state: 'wrong', $reason: [ 'username' ] };
                    case 403:
                        return this.state = { $state: 'wrong', $reason: [ 'password' ] };
                    default:
                        return this.state = { $state: 'error', $reason: reason };
                }

            });

        }

    });

</script>
