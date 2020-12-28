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

    Component.register('ui-navbar', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, {

                current: props.current || '',

                title: `${locale.info_title}`,
                logo: `${locale.nav_logo}`,
                home: `${locale.nav_home}`,
                catalog: `${locale.nav_catalog}`,
                about: `${locale.nav_about}`,
                support: `${locale.nav_support}`,

            });
        }


        onInit() {
            super.onInit();

            $(document).on('shopping-cart-has-changed', this, (e) => {

                $(e.data.elem).find('#ui-navbar-cart-count').each((i, e) => {

                    if(shopping_cart_empty())
                        $(e).addClass('d-none');

                    $(e).text(shopping_cart_count());

                })

            });


        }

        onRender() {
            return `${components.common_navbar}`
        }

        onUpdated(state) {
            super.onUpdated(state);
        }

    });



</script>
