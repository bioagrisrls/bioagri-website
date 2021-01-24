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

    Component.register('ui-gallery', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, api('/products/' + (props.id || '') + '/images')
                .then(response => {

                    return {
                        images: response,
                        current: 0
                    }

                })
                .catch(reason => {

                    if(reason === 404) {
                        return {
                            images: [ '${locale.card_not_available}' ],
                            current: 0
                        }
                    }

                    console.error("error when loading ui-gallery: ", reason);
                    throw reason;

                })
            );
        }


        onRender() {
            return `${components.common_gallery}`
        }

        next() {
            this.state = { current: (+this.state.current + 1) % +this.state.images.length };
        }

        prev() {
            const mod = (n, m) => ((n % m) + m) % m;
            this.state = { current: mod(+this.state.current - 1, +this.state.images.length) };
        }

        go(id) {
            this.state = { current: id };
        }


    });



</script>
