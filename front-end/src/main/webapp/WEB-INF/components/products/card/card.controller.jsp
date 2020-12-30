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
                api("/products/" + (props.id || 0))
                        .then(r => api('/users/' + sessionStorage.getItem('X-Auth-UserInfo-Id') + '/wishlist?filter-by=id&filter-value='+props.id+'')
                        .then(r2 => {
                            return Object.assign(r,r2, {
                                $view: props.view || 'card',
                                quantity: props.quantity || 0,
                                wishlist: r2.length,
                            })})
                        )
                )
            }


        onRender() {
            return `${components.products_card}`
        }

        onLoading() {
            return `${components.products_card_loading}`
        }

        onError() {
            return `${components.products_card_error}`
        }


        onClickAddToWishList(element){
                element.toggleClass('mdi-heart-outline').toggleClass('mdi-heart');
        }

    });


</script>
