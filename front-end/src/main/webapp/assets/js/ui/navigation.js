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


/**
 * Navigate through pages without reloading page.
 * @param url {string}
 * @param title {string}
 * @param output {HTMLElement || string}
 */
const uiNavigateURL = (url, title = document.title, output = document.documentElement) => {

    if(!url)
        throw new Error('URL cannot be null');


    if (window.history && window.history.pushState) {

        fetch(url)
            .then((response) => response.text())
            .then((response) => {

                if (output === document.documentElement)
                    $(output).html($(response).html());

                else {
                    $.each($(response), (i, e) => {

                        if ($(output).id !== $(e).id)
                            return ;

                        $(output).html($(e).html());

                    });
                }

            }).then(() => Component.run(output));


        window.history.pushState({}, title, url);

    } else {

        console.warn("window.history not supported, fallback to window.location :(");
        window.location.href = this.href;

    }

}


$(document).ready(() => {

    $('#ui-navigation-container').on('click', '.ui-navigate',{}, (e) => {

        e.preventDefault();

        if (window.location === this.href)
            return;

        uiNavigateURL(e.target.href, `${e.target.title || e.target.textContent} -- Bioagri Shop`, '#ui-navigation-container');

    });

});

window.onpopstate = (e) => {
    uiNavigateURL(document.location.href, document.title, '#ui-navigation-container');
}