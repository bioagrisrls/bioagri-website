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
                        image = response.value[0]


                    return {

                        product:    response[0].value,
                        tags:       response[1].value,
                        average:    response[2].value,
                        image:      image,

                        view: props.view || 'block',
                        hide: props.hide || '',
                        like: props.like || false,

                        strings: {
                            like: `${locale.card_add_wish}`,
                            cart: `${locale.card_add_cart}`,
                        }

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
                        api("/users/" + sessionStorage.getItem("X-Auth-UserInfo-Id") + "/wishlist/" + this.state.product.id, 'DELETE', {}, 'raw');
                        this.setState({likes: false}, false)
                    }
                    else {
                        api("/users/" + sessionStorage.getItem("X-Auth-UserInfo-Id") + "/wishlist/" + this.state.product.id, 'POST', {}, 'raw');
                        this.setState({likes: true}, false)
                    }

                    icon.classList.toggle('mdi-heart-outline');
                    icon.classList.toggle('mdi-heart');

                }).catch(() => requestUserAuthentication());

        }


    })

</script>
