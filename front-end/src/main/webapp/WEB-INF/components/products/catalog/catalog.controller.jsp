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

                api('/products?limit=9').then( (r1) => api('/categories')
                                        .then( (r2) => api('/tags')
                                        .then( (r3) => api('/products/count?limit=9', 'GET', {}, false).then( (r) => r.text() )
                                        .then( (r4) =>  {

                                            return {
                                                products: r1,
                                                categories: r2,
                                                tags: r3,
                                                count: r4,
                                                selectedSort : 'recentProduct',
                                                selectedView : 'card',
                                                category : 'noneCategory',
                                                tag : 'noneTag',
                                                search : 'noneSearch',
                                                productsCategories : new Map(),
                                                productsTags : new Map(),
                                            }

                                        }))))
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

        onReady(state) {

            const instance = this;

            this.state.products.forEach( (e) => {

                api('/products/' + e.id + '/categories').then( (r1) =>

                    api('/products/' + e.id + '/tags').then( (r2) => {
                        instance.setState({productsCategories: instance.state.productsCategories.set(e.id, r1)});
                        instance.setState({productsTags: instance.state.productsTags.set(e.id, r2)});
                    })
                )
            });

        }

        onUpdated(state) {

            const instance = this;


            $( '#toggle-group-sort' ).on('change', function() {

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


            $( '#toggle-group-view' ).on('change', function() {

                instance.setState({selectedView  : this.value });

            });


            $( '.category-item' ).click( function() {

                instance.setState({category  : this.id });

            });


            $( '.tag-item' ).click( function() {

                instance.setState({tag : this.id });

            });


            $( '#more-item' ).click( function() {

                api('/products?skip=' + instance.state.count + '&limit=' + (+instance.state.count + 9) ).then((r1) => {

                    r1.forEach( (e) => {

                        instance.state.products.push(e);

                        api('/products/' + e.id + '/categories').then((r2) =>

                            api('/products/' + e.id + '/tags').then((r3) => {
                                instance.setState({productsCategories: instance.state.productsCategories.set(e.id, r2)});
                                instance.setState({productsTags: instance.state.productsTags.set(e.id, r3)});
                            })

                        )

                    });

                    instance.state.count = instance.state.products.length;

                })
            });

        }

    });


</script>
