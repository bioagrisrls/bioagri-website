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

    Component.register('ui-product-info', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id,

                Promise.all([
                    api('/products/' + (props.id || '')),
                    api('/products/' + (props.id || '') + '/categories'),
                    api('/products/' + (props.id || '') + '/tags'),
                    api('/products/' + (props.id || '') + '/votes/avg', 'GET', {}, 'text'),
                ]).then(response => {

                    return {

                        product:    response[0],
                        categories: response[1],
                        tags:       response[2],
                        average:    response[3],
                        like:       'false',

                        current: 'feedbacks',


                        strings: {
                            description:  `${locale.details_description}`,
                            iva:          `${locale.details_iva}`,
                            liked:        `${locale.details_liked}`,
                            like:         `${locale.details_like}`,
                            cart:         `${locale.details_cart}`,
                            feedbacks:    `${locale.details_feedbacks}`
                        },


                    }

                }).catch(reason => navigate('/catalog'))

            );

        }

        onRender() {
            return `${components.products_info}`
        }


        feedbacks() {
            this.state = { current: 'feedbacks' };
        }

        description() {
            this.state = { current: 'description' };
        }


    });


</script>

