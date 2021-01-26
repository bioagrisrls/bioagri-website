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

    Component.register('ui-order', (id, props) => new class extends StatefulComponent {

        constructor() {

            super(id,
                authenticated()
                    .then(() => api('/orders')
                        .then(orders => {

                            return Promise.all(orders.map(i => api('/orders/' + i.id + '/products')))
                                .then(products => {

                                    return {
                                        orders: orders || [],
                                        products: products || [],

                                        strings: {
                                            empty:      `${locale.order_empty}`,
                                            title:      `${locale.order_title}`,
                                            number:     `${locale.order_number}`,
                                            date:       `${locale.order_date}`,
                                            status:     `${locale.order_status}`,
                                            quantity:   `${locale.order_quantity}`,
                                            review:     `${locale.details_feedbacks_write}`
                                        }
                                    }

                                });

                        })
                    ).catch(() => requestUserAuthentication())
            );

        }


        onRender() {
            return `${components.shopping_order}`;
        }



        /**
         * Write a new review.
         */
        review(id) {

            authenticated()
                .then(() => api('/products/' + id))
                .then((product) => Component.render(Component.dummy(), `${components.products_review}`, {
                    id: product.id,
                    name: product.name,
                    success: `${locale.review_form_success}`
                }))

                .catch(reason => {

                    if(reason === 'purchase-first')
                        Component.render(Component.dummy(), `${components.common_notify}`, { message: '${locale.review_purchase_first}' });
                    else
                        requestUserAuthentication()

                });

        }


    });


</script>
