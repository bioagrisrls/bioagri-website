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

    Component.register('ui-footer', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, {

                current: props.current || '',

                connected: `${locale.foo_header_connected}`,

                logo: `${locale.foo_body_logo}`,
                description: `${locale.foo_body_description}`,

                title: `${locale.info_title}`,
                menu: `${locale.foo_body_menu}`,
                home: `${locale.foo_body_home}`,
                catalog: `${locale.foo_body_catalog}`,
                about: `${locale.foo_body_about}`,
                support: `${locale.foo_body_support}`,

                util: `${locale.foo_body_util}`,
                contact: `${locale.foo_body_contact}`,
                address: `${locale.info_address}`,
                phone: `${locale.info_phone}`,
                mail: `${locale.info_email}`,
                piva: `${locale.info_piva}`,

                registration: '${locale.foo_body_registration}',
                tickets: ${locale.foo_body_tickets}'',
                faq: '${locale.foo_body_faq}',
                policy: '${locale.foo_body_policy}',

                copyright: `${locale.info_copy}`

            });
        }

        onRender() {
            return `${components.common_footer}`;
        }


    });


</script>