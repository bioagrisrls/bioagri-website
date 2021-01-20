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
                    api('/products/' + (props.id || '') + '/images'),
                    api('/products/' + (props.id || '') + '/tags'),

                ]).then(response => {

                    return {
                        product: response[0].status === 'fulfilled' ? response[0].value : {},
                        image: response[1].status === 'fulfilled' ? response[1].value[0] : '${locale.card_not_avaliable}',
                        tags: response[2].status === 'fulfilled' ? response[2].value : {},
                        view: props.view || 'block',
                        wish: props.wish || true,
                        cart: props.cart || true,
                        likes: props.likes || true,
                        addCart: `${locale.card_add_cart}`,
                        addWish: `${locale.card_add_wish}`,
                    };
                })
            )
        }

        onRender() {
            return `${components.products_card}`
        }

        onWishClicked() {

            const icon = document.querySelector('#heart-icon-' + this.state.product.id);

            authenticated().then(() => {

                    if (this.state.likes === true){
                        api("/users/" + sessionStorage.getItem("X-Auth-UserInfo-Id") + "/wishlist/" + this.state.product.id, 'DELETE', {}, false);
                        this.setState({likes: false}, false)
                    }
                    else {
                        api("/users/" + sessionStorage.getItem("X-Auth-UserInfo-Id") + "/wishlist/" + this.state.product.id, 'POST', {}, false);
                        this.setState({likes: true}, false)
                    }

                    icon.classList.toggle('mdi-heart-outline');
                    icon.classList.toggle('mdi-heart');

                }).catch(() => requestUserAuthentication());

        }


    })

</script>
