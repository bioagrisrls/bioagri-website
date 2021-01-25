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

    Component.register('ui-payment', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, {

                current: 'options',

                strings: {
                    error:                   `${locale.payment_error}`,
                    back:                    `${locale.payment_return}`,
                    purchase:                `${locale.payment_purchase}`,
                    pickup:                  `${locale.payment_pickup}`,
                    otherwise:               `${locale.payment_otherwise}`,
                    paynow:                  `${locale.payment_paynow}`,
                    choose:                  `${locale.payment_choose}`,
                    italy:                   `${locale.payment_italy}`,
                    shipping_name:           `${locale.payment_shipping_name}`,
                    shipping_surname:        `${locale.payment_shipping_surname}`,
                    shipping_title:          `${locale.payment_shipping_title}`,
                    shipping_country:        `${locale.payment_shipping_country}`,
                    shipping_city:           `${locale.payment_shipping_city}`,
                    shipping_province:       `${locale.payment_shipping_province}`,
                    shipping_address:        `${locale.payment_shipping_address}`,
                    shipping_address_example:`${locale.payment_shipping_address_example}`,
                    shipping_zip:            `${locale.payment_shipping_zip}`,
                    shipping_info:           `${locale.payment_shipping_info}`,
                    shipping_info_example:   `${locale.payment_shipping_info_example}`,
                    pickup_instructions:     `${locale.payment_pickup_instructions}`,
                    pickup_disclaimer:       `${locale.payment_pickup_disclaimer}`,
                    pickup_confirm:          `${locale.payment_pickup_confirm}`,
                }

            });
        }

        onRender() {
            return `${components.shopping_payment}`
        }

        onReady(state) {
            super.onReady(state);

            paypal_sdk.Buttons({

                createOrder: (data, actions) => {

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

    });


</script>

