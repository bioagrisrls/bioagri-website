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

    Component.register('ui-cart', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, {

                items: {},
                shipment: 10, // FIXME
                prices: [ 0, 0 ],
                count: 0,

                strings: {
                    empty:                  `${locale.cart_empty}`,
                    title:                  `${locale.cart_title}`,
                    subtitle:               `${locale.cart_subtitle}`,
                    quantity:               `${locale.cart_quantity}`,
                    products:               `${locale.cart_products}`,
                    discount:               `${locale.cart_discount}`,
                    total:                  `${locale.cart_total}`,
                    total_no_discount:      `${locale.cart_total_no_discount}`,
                    total_with_discount:    `${locale.cart_total_with_discount}`,
                    shipment:               `${locale.cart_shipment}`,
                    shipment_free:          `${locale.cart_shipment_free}`,
                    clear:                  `${locale.cart_clear}`,
                    checkout:               `${locale.cart_checkout}`,
                }

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


        onBeforeUpdate(state) {
            super.onBeforeUpdate(state);

            this.state.count = shopping_cart_count();
            this.state.prices = [
                this.getPrice(state.items, 0),
                this.getPrice(state.items, 0, true),
                this.getPrice(state.items, state.shipment, true),
            ];

        }

        getPrice(items, addend, discount = false) {

            return Object
                .values(items)
                .reduce((i, v) => {

                    if(discount)
                        return ((+v.price - ((+v.price / 100) * +v.discount)) * shopping_cart_count(v.id)) + i;

                    return (+v.price * shopping_cart_count(v.id)) + i;

                }, +addend).toFixed(2);

        }

    });

</script>