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



$(document).on('ui-ready', () => {

    const animate = (attribute, fallback = 'fadeIn', event = undefined, once = false, actor = undefined, condition = undefined) => {

        const $animated = $('*[' + attribute +']');


        $animated.each((i, e) => {

            if(event) {

                (actor || e).addEventListener(event, () => {

                    if (!e.hasAttribute(attribute))
                        return;

                    if ((condition && condition(e)) || (!condition)) {

                        const anim = $(e).attr(attribute) || fallback;

                        e.classList.add('animate__animated');
                        e.classList.add('animate__' + anim);

                        e.addEventListener('animationend', () => {
                            e.classList.remove('animate__animated');
                            e.classList.remove('animate__' + anim);
                        })

                        if (once) {
                            e.removeAttribute(attribute);
                        }

                    }

                });

            } else {

                e.classList.add('animate__animated');
                e.classList.add('animate__' + ($(e).attr(attribute) || fallback));

            }

        });


    }


    $('*[ui-animated-scroll]').each((i, e) => {

        if ((window.scrollY + window.innerHeight) > e.offsetTop)
            e.removeAttribute('ui-animated-scroll');

    });

    animate('ui-animated', 'fadeIn');
    animate('ui-animated-hover', 'bounce', 'mouseenter');
    animate('ui-animated-scroll', 'backInUp',  'scroll', true, window, (e) => ((window.scrollY + window.innerHeight) > e.offsetTop));

})