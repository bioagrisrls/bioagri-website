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
 * @param container {HTMLElement || string}
 * @param pushState {boolean}
 */
const uiNavigateURL = (url, title = document.title, container = document.documentElement, pushState = true) => {

    if(!url)
        throw new Error('URL cannot be null');


    if (window.history && window.history.pushState) {


        let prog = $('#ui-navigation-progress-bar').show()
            .css('width', '33%')
            .attr('aria-valuenow', '33');


        fetch(url)
            .then((response) => response.text())
            .then((response) => {

                if (container === document.documentElement) {

                    $(container).html($(response).html());

                }else {

                    $.each($(response), (i, e) => {

                        if($(e).is('script'))
                            eval($(e).html());

                        if ($(container).id !== $(e).id)
                            return;

                        $(container).html($(e).html());

                    });


                }

                prog.css('width', '66%')
                    .attr('aria-valuenow', '66');


            }).then(() => Component.run(container))
              .then(() => prog.hide())
              .then(() => $(document).trigger('ui-ready'))

            .catch(reason => {

                console.error(reason);

                $('body').append(`
                    <div id="ui-navigation-error" class="alert alert-danger alert-dismissible fixed-bottom fade show" role="alert">
                        <strong>Ops!</strong> Seems there is no internet connection here :(
                        <button type="button" class="btn-close" onclick="$('#ui-navigation-error').alert('close')" aria-label="Close"></button>
                    </div>
                `);

            })


        if(pushState)
            window.history.pushState({}, title, url);

        document.title = title;

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

        uiNavigateURL(e.currentTarget.href, `${e.currentTarget.title || e.currentTarget.textContent}`, '#ui-navigation-container');

    });

    $('body').append(`
        <div class="ui-navigation-progress progress fixed-top">
            <div id="ui-navigation-progress-bar" class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
    `);


    $(document).trigger('ui-ready');

});

window.onpopstate = (e) => {
    uiNavigateURL(document.location.href, document.title, '#ui-navigation-container', false);
}