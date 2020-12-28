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
                let p = []

                switch (this.value) {

                    case 'recentProduct':
                        p = instance.state.products.sort( function(a, b){ return a.createdAt - b.createdAt });
                        instance.setState({products : p });
                        break;

                    case 'lowPrice':
                        p = instance.state.products.sort( function(a, b){ return a.price - b.price });
                        instance.setState({products : p });
                        break;

                    case 'highPrice':
                        p = instance.state.products.sort( function(a, b){ return b.price - a.price });
                        instance.setState({products : p });
                        break;

                    case 'alphabeticalOrder1':
                        p = instance.state.products.sort( function(a, b){ return a.name.localeCompare(b.name)});
                        instance.setState({products : p });
                        break;

                    case 'alphabeticalOrder2':
                        p = instance.state.products.sort( function(a, b){ return b.name.localeCompare(a.name)});
                        instance.setState({products : p });
                        break;

                }

            });

            $( "#toggle-group-view" ).on('change', function() {

                console.log(this.value);
                instance.setState({selectedView  : this.value });

            });

        }

    });

</script>
