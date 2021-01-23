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

    /* FIXME: Make a card */
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

                        current: 'description',


                        strings: {
                            description:  `${locale.details_description}`,
                            iva:          `${locale.details_iva}`,
                            liked:        `${locale.details_liked}`,
                            like:         `${locale.details_like}`,
                            cart:         `${locale.details_cart}`,
                            feedbacks:    `${locale.details_feedbacks}`,
                            order:        `${locale.details_feedbacks_order}`,
                            disclaimer:   `${locale.details_feedbacks_disclaimer}`,
                            write:        `${locale.details_feedbacks_write}`,
                        },


                    }

                }).catch(reason => navigate('/catalog'))

            );

        }


        onReady(state) {
            super.onReady(state);

            authenticated(false)
                .then(() => this.wish())
                .catch(() => undefined);


            $(document).on('auth-connection-occurred', () => {

                if(this.running)
                    this.wish();

            });

            $(document).on('auth-disconnection-occurred', () => {

                if(this.running)
                    this.wish(true);

            });

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



        /**
         * Load/Unload Wishlist.
         * @param clear {boolean}
         */
        wish(clear = false) {

            if(clear)
                return this.state = { like: 'false' };

            else {

                api('/users/' + sessionStorage.getItem('X-Auth-UserInfo-Id') + '/wishlist?filter-by=id&filter-val=' + this.state.product.id)
                    .then(response => this.state = { like: response.length === 0 ? 'false' : 'true' })
                    .catch();

            }

        }

        /**
         * Toggle wish button.
         */
        wishToggle() {

            this.state = {
                like: this.state.like === 'true'
                    ? 'false'
                    : 'true'
            };

            if(this.state.like === 'true') {

                authenticated()
                    .then(() => api('/users/' + sessionStorage.getItem('X-Auth-UserInfo-Id') + '/wishlist/' + this.state.product.id, 'POST', {}, 'raw').catch(() => {}))
                    .then(() => Component.render(Component.dummy(), `${components.common_notify}`, { message: '<span class="mdi mdi-18px mdi-heart-plus"></span> ${locale.wish_add}' }))
                    .catch(() => requestUserAuthentication());

            } else {

                authenticated()
                    .then(() => api('/users/' + sessionStorage.getItem('X-Auth-UserInfo-Id') + '/wishlist/' + this.state.product.id, 'DELETE', {}, 'raw').catch(() => {}))
                    .then(() => Component.render(Component.dummy(), `${components.common_notify}`, { message: '<span class="mdi mdi-18px mdi-heart-minus"></span> ${locale.wish_remove}' }))
                    .catch(() => requestUserAuthentication());

            }


        }



        /**
         * Add product in shopping cart.
         */
        cart() {

            shopping_cart_add(this.state.product.id, 1);

            Component.render(Component.dummy(), `${components.common_notify}`, {
                message: '<span class="mdi mdi-18px mdi-cart-plus"></span> ${locale.cart_add}'
            });

        }


        /**
         * Write a new review.
         */
        review() {

            authenticated()

                // .then(() => api('/orders/products/count?filter-by=userId&filter-val=' + sessionStorage.getItem('X-Auth-UserInfo-Id') +
                //                                       '&filter-by=id&filter-val=' + this.state.product.id, 'GET', {}, 'text')
                //     .then(response => {
                //         if(+response === 0)
                //             throw new Error('purchase-first')
                //     }))

                .then(() => Component.render(Component.dummy(), `${components.products_review}`, {
                    id: this.state.product.id,
                    name: this.state.product.name,
                    success: `${locale.review_form_success}`
                }))

                .catch(reason => {

                    console.error(reason);

                    if(reason === 'purchase-first')
                        Component.render(Component.dummy(), `${components.common_notify}`, { message: '${locale.review_purchase_first}' });
                    else
                        requestUserAuthentication()

                });

        }


    });


</script>

