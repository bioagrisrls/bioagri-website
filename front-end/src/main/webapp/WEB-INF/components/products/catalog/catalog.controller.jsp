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
            super(id,

                Promise.all([
                    api('/tags'),
                    api('/categories'),
                ]).then(response => {

                    return {

                        products: [],
                        wishlist: [],
                        tags: response[0],
                        categories: response[1],

                        skip: 0,
                        count: 0,

                        sortType: 'createdAt',
                        viewType: 'block',

                        filterCategory: props.category || '',
                        filterSearch: props.search || '',
                        filterTag: props.tag || '',

                        hasMore: true,

                        strings: {
                            categories:     `${locale.catalog_side_categories}`,
                            allcategories:  `${locale.catalog_side_allcategories}`,
                            tags:           `${locale.catalog_side_tags}`,
                            alltags:        `${locale.catalog_side_alltags}`,
                            results:        `${locale.catalog_main_results}`,
                            search:         `${locale.catalog_main_search}`,
                            orderby:        `${locale.catalog_main_orderby}`,
                            views:          `${locale.catalog_main_views}`,
                            more:           `${locale.catalog_main_more}`,
                        }

                    };

                })

            );

        }

        onReady(state) {

            authenticated(false)
                .then(() => this.wish())


            $(document).on('auth-connection-occurred', () => {

                if(this.running)
                    this.wish();

            });

            $(document).on('auth-disconnection-occurred', () => {

                if(this.running)
                    this.wish(true);

            });


            this.fetch();

        }

        onRender() {
            return `${components.products_catalog}`
        }


        /**
         * Fetch next group of products applying filters.
         */
        fetch() {

            const fetchSize = 9;
            const products = this.state.products;

            if(this.state.hasMore) {

                const query = [];

                if(this.state.filterSearch) {
                    query.push('filter-by=name');
                    query.push('filter-val=' + '(?i)(.)*(' + this.state.filterSearch + '(.)*)');
                }

                if(this.state.filterCategory) {
                    query.push('filter-by=categories.id');
                    query.push('filter-val=' + this.state.filterCategory);
                }

                if(this.state.filterTag) {
                    query.push('filter-by=tags.id');
                    query.push('filter-val=' + this.state.filterTag);
                }

                query.push('sorted-by=' + this.state.sortType);


                return api('/products/count?' + query.join('&'), 'GET', {}, false)
                    .then(check => check.text())
                    .then(count => {

                        if(+count === 0) {

                            this.state = {
                                hasMore: false
                            };

                        } else {

                            query.push('skip=' + this.state.skip);
                            query.push('limit=' + fetchSize);

                            api('/products?' + query.join('&'))
                                .then(response => {

                                    (response || []).forEach(e => products.push(e.id));


                                    const window_offset = window.pageYOffset;

                                    this.state = {
                                        products: products,
                                        skip: this.state.skip + (response || []).length,
                                        count: count,
                                        hasMore: (response || []).length === fetchSize
                                    };

                                    window.scrollTo(0, window_offset);

                                });

                        }

                    });


            }


        }

        /**
         * Load/Unload Wishlist
         * @param clear {boolean}
         */
        wish(clear = false) {

            if(clear)
                return this.state = { wishlist: [] };

            else {

                api('/users/' + sessionStorage.getItem('X-Auth-UserInfo-Id') + '/wishlist')
                    .then(response => this.state = { wishlist: response })
                    .catch(() => undefined);

            }

        }

        /**
         * Apply filter to catalog
         * @param filter {string}
         * @param value {string}
         */
        applyFilter(filter, value) {

            switch(filter) {

                case 'category':
                    this.setState({
                        filterCategory: value,
                    }, false);
                    break;

                case 'tag':
                    this.setState({
                        filterTag: value,
                    }, false);
                    break;

                case 'search':
                    this.setState({
                        filterSearch: value,
                    }, false);
                    break;

                case 'order':
                    this.setState({
                        sortType: value,
                    }, false);
                    break;

                default:
                    throw new Error('Invalid filter: ' + filter);

            }


            this.setState({
                products: [],
                skip: 0,
                count: 0,
                hasMore: true
            }, false);


            this.fetch();

        }

        /**
         * Apply View type to catalog
         * @param type {string}
         */
        view(type) {
            this.state = {
                viewType: type
            };
        }

    });



</script>

