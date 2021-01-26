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

    Component.register('ui-profile', (id, props) => new class extends StatefulComponent {

        constructor() {

            super(id,
                api('/users/' + sessionStorage.getItem('X-Auth-UserInfo-Id'))
                    .then(response => {

                        return {

                            user: response,

                            strings: {
                                account:        '${locale.profile_account}',
                                name:           '${locale.profile_name}',
                                surname:        '${locale.profile_surname}',
                                mail:           '${locale.profile_mail}',
                                gender:         '${locale.profile_gender}',
                                phone:          '${locale.profile_phone}',
                                birth:          '${locale.profile_birth}',
                                status:         '${locale.profile_status}',
                                details:        '${locale.profile_details}',
                                password:       '${locale.profile_password}',
                                password_old:   '${locale.profile_password_old}',
                                password_new:   '${locale.profile_password_new}',
                                password_save:  '${locale.profile_password_save}',
                                remove:         '${locale.profile_remove}',
                                remove_warn:    '${locale.profile_remove_warn}',
                                logout:         '${locale.profile_logout}',
                                logout_warn:    '${locale.profile_logout_warn}',
                            }

                        }

                    }).catch(() => requestUserAuthentication())

            );

        }


        onReady(state) {
            super.onReady(state);

            new bootstrap.ScrollSpy(document.querySelector('#' + this.id + '-content'), {
                target: '#' + this.id + '-side'
            });

        }

        onRender() {
            return `${components.users_profile}`;
        }



        remove() {
            api('/users/' + sessionStorage.getItem('X-Auth-UserInfo-Id'), 'DELETE', {}, 'raw')
                .then(() => disconnect());
        }


    });


</script>
