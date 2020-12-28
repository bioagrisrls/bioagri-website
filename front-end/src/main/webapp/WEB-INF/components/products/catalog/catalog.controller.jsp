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

    Component.register('ui-catalog', (id, props) => new class extends StatefulComponent {

        constructor() {
            super( id,

                api("/products").then( (r1) => api("/categories")
                                .then( (r2) => api("/tags")
                                .then( (r3) =>  {

                                    return {
                                        products: r1,
                                        categories: r2,
                                        tags: r3,
                                        selectedSort : 'recentProduct',
                                        selectedView : 'card'
                                    }

                                })))
            )
        }

        onRender() {
            return `${components.products_catalog}`
        }

        onLoading() {
            return `${components.products_catalog_loading}`
        }

        onError() {
            return `${components.products_catalog_error}`
        }

        onUpdated(state) {

            const instance = this;


            $( "#toggle-group-sort" ).on('change', function() {

                instance.setState({selectedSort : this.value});

                switch (this.value) {

                    case 'recentProduct':
                        instance.setState( {products : instance.state.products.sort( (a, b) => { return a.createdAt - b.createdAt } )});
                        break;

                    case 'lowPrice':
                        instance.setState( {products : instance.state.products.sort( (a, b) => { return a.price - b.price } )});
                        break;

                    case 'highPrice':
                        instance.setState( {products : instance.state.products.sort( (a, b) => { return b.price - a.price } )});
                        break;

                    case 'alphabeticalOrder1':
                        instance.setState( {products : instance.state.products.sort( (a, b) => { return a.name.localeCompare(b.name) } )});
                        break;

                    case 'alphabeticalOrder2':
                        instance.setState( {products : instance.state.products.sort( (a, b) => { return b.name.localeCompare(a.name) } )});
                        break;

                }

            });

            $( "#toggle-group-view" ).on('change', function() {

                instance.setState({selectedView  : this.value });

            });

        }

    });

</script>
