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

    Component.register('ui-shopping-cart', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, {
                items: {},
                price: 0,
                shipment: 10, // FIXME
                total: 0,
                count: 0,
            });
        }

        onInit() {
            $(document).on('shopping-cart-has-changed', this, (e) => {
                if(e.data.running) {
                    e.data.state = { count: shopping_cart_count() };
                }
            });
        }

        onRender() {
            return `${components.shopping_cart}`
        }

        getPrice(items, addend = 0) {
            return Object.values(items).reduce((i, v) => i + v.price * v.quantity, addend).toFixed(2);
        }

    });

    /* TODO: Remove this */
    shopping_cart_add(1, 2, false);
    shopping_cart_add(2, 2, false);
    shopping_cart_add(3, 2, false);
    shopping_cart_add(4, 2, false);

</script>