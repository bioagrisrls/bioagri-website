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

                api('/categories')
                    .then( categories => api('/tags')
                    .then( tags => api("/users/" + sessionStorage.getItem("X-Auth-UserInfo-Id") +"/wishlist")
                    .then(wishlist => {

                        return {

                            products: [],
                            categories: categories,
                            tags: tags,
                            wishlist : wishlist,
                            iswish : 'no',
                            skip: 0,
                            count: 0,
                            selectedSort : 'createdAt',
                            selectedView : 'block',
                            category : '',
                            tag : '',
                            search : '',
                            filterByAttribute : false,
                            hasMoreProducts : true

                        }
                        }, reason =>  {

                        return {

                            products: [],
                            categories: categories,
                            tags: tags,
                            wishlist: '',
                            iswish: 'no',
                            skip: 0,
                            count: 0,
                            selectedSort: 'createdAt',
                            selectedView: 'block',
                            category: '',
                            tag: '',
                            search: '',
                            filterByAttribute: false,
                            hasMoreProducts: true
                        }
                    })

                    )));
        }

        onReady(state) {

            this.fetchNextGroup();

            $(window).one('scroll', this, function handler(e) {

                if(e.data.running) {

                    const wy = window.pageYOffset + window.innerHeight;
                    const ty = e.data.elem.offsetTop + e.data.elem.offsetHeight;

                    if (e.data.state.hasMoreProducts && (wy > ty)) {

                        e.data.fetchNextGroup().then(
                            () => $(window).one('scroll', e.data, handler));

                    } else {
                        $(window).one('scroll', e.data, handler);
                    }

                }

            });

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

        isWish(id){

            for(let i = 0; i < this.state.wishlist.length; i++){

                    if(this.state.wishlist[i].id === id)
                        return 'yes';

            }

        }

        fetchNextGroup() {

            const fetchSize = 9;
            const products = this.state.products;

            if(this.state.hasMoreProducts) {

                const query = [];

                if(this.state.search) {
                    query.push('filter-by=name');
                    query.push('filter-val=' + '(?i)(.)*(' + this.state.search + '(.)*)');
                }

                if(this.state.category) {
                    query.push('filter-by=categories.id');
                    query.push('filter-val=' + this.state.category);
                }

                if(this.state.tag) {
                    query.push('filter-by=tags.id');
                    query.push('filter-val=' + this.state.tag);
                }

                query.push('sorted-by=' + this.state.selectedSort);


                return api('/products/count?' + query.join('&'), 'GET', {}, false)
                    .then(check => check.text())
                    .then(count => {

                        if(+count === 0) {

                            this.state = {
                                hasMoreProducts: false
                            };

                        } else {

                            query.push('skip=' + this.state.skip);
                            query.push('limit=' + fetchSize);

                            api('/products?' + query.join('&'))
                                .then(response => {

                                    (response || []).forEach(e => products.push(e.id));

                                    this.state = {
                                        products: products,
                                        skip: this.state.skip + (response || []).length,
                                        count: count,
                                        hasMoreProducts: (response || []).length === fetchSize
                                    };

                                });

                        }

                    });


            }


        }

        $selectCategory(button) {

            this.setState({
                category: button.value,
                products: [],
                skip: 0,
                count: 0,
                hasMoreProducts: true
            });

            this.fetchNextGroup();

        }

        $selectTag(button) {

            this.setState({
                tag: button.value,
                products: [],
                skip: 0,
                count: 0,
                hasMoreProducts: true
            });

            this.fetchNextGroup();

        }

        $search() {


            this.setState({
                products: [],
                skip: 0,
                count: 0,
                hasMoreProducts: true,
                search: $('#searchText').val(),
            })

            this.fetchNextGroup();
        }

        $searchKey(event) {

            const key = event.keyCode || event.which;

            if (key === 13) {

                this.setState({
                    products: [],
                    skip: 0,
                    count: 0,
                    hasMoreProducts: true,
                    search: $('#searchText').val(),
                })

                this.fetchNextGroup();

            }
        }

        $changeSort(button) {

            this.setState({

                selectedSort: button.value,
                products: [],
                skip: 0,
                count: 0,
                hasMoreProducts : true,

            });

            this.fetchNextGroup();
        }

        $changeView(button) {
            this.setState({ selectedView: button.value });
        }

    });



</script>

