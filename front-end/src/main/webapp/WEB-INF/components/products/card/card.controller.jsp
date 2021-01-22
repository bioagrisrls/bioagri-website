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

    Component.register('ui-card', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id,

                Promise.allSettled([

                    api("/products/" + (props.id || '')),
                    api('/products/' + (props.id || '') + '/tags'),
                    api('/products/' + (props.id || '') + '/votes/avg', 'GET', {}, 'text'),
                    api('/products/' + (props.id || '') + '/images'),

                ]).then(response => {

                    if(response[0].status !== 'fulfilled')
                        throw new Error('product cannot be null');

                    if(response[1].status !== 'fulfilled')
                        throw new Error('tags cannot be null');

                    if(response[2].status !== 'fulfilled')
                        throw new Error('vote-average cannot be null');


                    let image = `${locale.card_not_available}`;

                    if(response[3].status === 'fulfilled')
                        image = response[3].value[0];


                    return {

                        product:    response[0].value,
                        tags:       response[1].value,
                        average:    response[2].value,
                        image:      image,

                        view: props.view || 'block',
                        hide: props.hide || '',
                        like: props.like || 'false',

                        strings: {
                            cart:  `${locale.card_add_cart}`,
                            like:  `${locale.card_add_wish}`,
                            liked: `${locale.card_added_wish}`,
                        }

                    };

                })
            )
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
            return `${components.products_card}`
        }



        /**
         * Load/Unload Wishlist
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
         * Toggle wish button
         */
        wishToggle() {

            this.state = {
                like: this.state.like === 'true' ? 'false' : 'true'
            };

            this.raise(this.state.like
                ? 'wish-add'
                : 'wish-remove');

        }


        /**
         * Add product in shopping cart
         */
        cart() {

            shopping_cart_add(this.state.product.id, 1);

            Component.render(Component.dummy(), `${components.common_notify}`, {
                message: '<span class="mdi mdi-18px mdi-cart-plus"></span> ${locale.cart_add}'
            });

        }


    })

</script>
