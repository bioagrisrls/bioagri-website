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

    Component.register('ui-contact', (id, props) => new class extends FormComponent {

        constructor() {
            super(id, {

                name: {
                    type: 'text',
                    placeholder: '${locale.support_form_name}',
                    required: true,
                    maxlength: 32
                },

                surname: {
                    type: 'text',
                    placeholder: '${locale.support_form_surname}',
                    required: true,
                    maxlength: 32
                },

                email: {
                    type: 'email',
                    placeholder: '${locale.support_form_email}',
                    pattern: /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/,
                    required: true,
                    size: 128, // FIXME
                    wrong: "Username wrong! (FIXME)"
                },

                phone: {
                    type: 'tel',
                    placeholder: '${locale.support_form_phone}',
                    required: true,
                    size: 16
                },

                object: {
                    type: 'text',
                    placeholder: '${locale.support_form_subject}',
                    required: true,
                    maxlength: 32
                },
                message: {
                    type: 'textarea',
                    placeholder: '${locale.support_form_message}',
                    required: true,
                    maxlength: 512
                },

                $submit: {
                    value: `${locale.support_form_submit}`,
                    align: 'start',
                },

                $header: '',
                $footer: '',

            });
        }

        onReady(state) {
            this.state = { $state: 'ready-to-send-email' };
        }


        onSubmit(data) {
        }

    })

</script>