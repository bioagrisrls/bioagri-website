/*
 * MIT License
 *
 * Copyright (c) 2020 BioAgri S.r.l.s.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

'use strict';


/**
 * Shopping.js
 *
 * Events:
 *  - shopping-cart-has-changed: when a user change shopping cart items.
 *
 */

/**
 * Add item to shopping cart.
 * @param id {number}
 * @param quantity {number}
 * @param raiseEvent {boolean}
 */
const shopping_cart_add = (id, quantity, raiseEvent = true) => {

    const cache = localStorage.getItem('X-Shopping-Cart');
    const items = (cache && JSON.parse(cache)) || [];

    const item = items.find(i => i.id === id);

    if(item)
        item.quantity = quantity;
    else
        items.push({ id: id, quantity: quantity });


    localStorage.setItem('X-Shopping-Cart', JSON.stringify(items.filter(i => i.quantity > 0)));

    if(raiseEvent)
        $(document).trigger('shopping-cart-has-changed');

}

/**
 * Remove item from shopping cart.
 * @param id {number}
 * @param raiseEvent {boolean}
 */
const shopping_cart_remove = (id, raiseEvent = true) => {
    shopping_cart_add(id, 0, raiseEvent);
}


/**
 * Remove all items from shopping cart.
 */
const shopping_cart_clear = (raiseEvent = true) => {

    localStorage.setItem('X-Shopping-Cart', JSON.stringify([]));

    if(raiseEvent)
        $(document).trigger('shopping-cart-has-changed');

}


/**
 * Iterate each entry on the shopping cart
 * @param callbackfn {function}
 */
const shopping_cart_each = (callbackfn) => {

    const cache = localStorage.getItem('X-Shopping-Cart');
    const items = (cache && JSON.parse(cache)) || [];

    items.forEach(callbackfn);

}


/**
 * Iterate each entry on the shopping cart
 * @return {number}
 */
const shopping_cart_count = () => {

    const cache = localStorage.getItem('X-Shopping-Cart');
    const items = (cache && JSON.parse(cache)) || [];

    return Object.values(items).reduce((i, v) => i + (+v.quantity), 0);

}


/**
 * Iterate each entry on the shopping cart
 * @return {boolean}
 */
const shopping_cart_empty = () => {
    return shopping_cart_count() === 0;
}
