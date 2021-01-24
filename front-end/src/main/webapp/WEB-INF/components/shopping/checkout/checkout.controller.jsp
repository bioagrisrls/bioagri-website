<!--
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
-->

<%--@elvariable id="components" type="java.util.Map"--%>
<%--@elvariable id="locale" type="java.util.Map"--%>
<%--@elvariable id="reference" type="java.lang.String"--%>

<script defer>

    Component.register('ui-checkout', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, {

                current: 'order',

                orderText: `${locale.checkout_tab_title_order}`,
                paymentText: `${locale.checkout_tab_title_payment}`,
                summaryText: `${locale.checkout_tab_title_summary}`,
                totalTextTop: `${locale.checkout_total_top}`,
                subTotalText: `${locale.checkout_subtotal}`,
                shipmentText: `${locale.checkout_shipment}`,
                totalTextBottom: `${locale.checkout_total_bottom}`,
                confirmOrderButton: `${locale.checkout_confirm}`,
                returnToShopping: `${locale.checkout_continue}`,
                cartText: `${locale.checkout_cart}`,
                cartProductsText: `${locale.checkout_cart_products}`,
                remindHeaderText: `${locale.checkout_remind_header}`,
                remindTopText: `${locale.checkout_remind_top}`,
                remindBottomText: `${locale.checkout_remind_bottom}`,
                orderHint: `${locale.checkout_order_hint}`,
                shipmentHint: `${locale.checkout_shipment_hint}`,
                paymentHint: `${locale.checkout_payment_hint}`,

                success: true,

            });
        }

        onRender() {
            return `${components.shopping_checkout}`
        }

        onLoading() {
            return `${components.shopping_checkout_loading}`
        }

        onError() {
            return `${components.shopping_checkout_error}`
        }

        onUpdated(state) {
            super.onUpdated(state);

            if(state.current === 'payment') {

                paypal_sdk.Buttons({

                    createOrder: (data, actions) => {

                        console.log(data, actions);

                        return Promise.all(shopping_cart_map(item => api('/products/' + item.id)))
                            .then(response => {

                                const order = {

                                    purchase_units: [{
                                        amount: {
                                            value: (+response.reduce((j, i) => j + (+i.price - ((+i.price / 100) * +i.discount)), 0)).toFixed(2),
                                            currency_code: 'EUR',
                                        }
                                    }],

                                    items: response.map(i => {
                                        return {
                                            name: i.name,
                                            unit_amount: (+i.price - ((+i.price / 100) * +i.discount)).toFixed(2),
                                            quantity: shopping_cart_count(i.id)
                                        }
                                    }),

                                    description: "Acquisto su Bioagri Shop",

                                };

                                console.log(order);

                                return actions.order.create(order);

                            });


                    },

                    onApprove: (data, actions) => {

                        return actions.order.capture().then(response => {
                            console.log('onApprove', response);
                        });

                    }

                }).render('#paypal-button-paynow');

            }

        }

        goToOrder() {
            this.setState({current: 'order'});
        }

        goToPayment() {
            this.setState({current: 'payment'});
        }

        goToSummary() {
            this.setState({current: 'summary'});
        }

    });


</script>

