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

    Component.register('ui-product-related', (id, props) => new class extends StatefulComponent {

        constructor() {

            let uri = '';

            switch(props.kind) {

                case "categories":
                    uri = 'filter-by=categories.id&filter-val=' + (props.id || 0);
                    break;

                case "tags":
                    uri = 'filter-by=tags.id&filter-val=' + (props.id || 0);
                    break;

            }

            super(id, api('/products?limit=15&' + uri).then(response => {
                return {
                    products: response.map(i => i.id),
                    offset: 0,
                }
            }));

        }

        onRender() {
            return `${components.products_related}`
        }


        onReady(state) {
            super.onReady(state);

            $(window).on('resize', this, (e) => {
                if(e.data.running) {
                    e.data.setState({}, false);
                }
            });

        }

        onUpdated(state) {
            super.onUpdated(state);

            const containerWidth = 1200;
            const $sub = $(this.elem).find('#' + this.id + '-sub-container');
            const $prd = $(this.elem).find('.' + this.id + '-product');

            let {
                products,
                offset
            } = this.state;


            if($sub.width() - offset < window.innerWidth)
                offset = $sub.width() - window.innerWidth;

            if(offset < 0)
                offset = 0;

            $sub.css({
                width: (products.length + 1) * $prd.width() + 'px'
            });

            $sub.css({
                left:  (window.innerWidth / 2) - (containerWidth / 2) - offset + 'px'
            });


            this.setState({ offset : offset }, false);

        }


        next() {
            this.setState({ offset: this.state.offset + (window.innerWidth / 2) }, false);
        }

        prev() {
            this.setState({ offset: this.state.offset - (window.innerWidth / 2) }, false);
        }

    });


</script>
