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

                api('/categories').then( r1 => api('/tags')
                                  .then( r2 =>  {

                                    return {
                                        products: [],
                                        categories: r1,
                                        tags: r2,
                                        count: 0,
                                        selectedSort : 'createdAt',
                                        selectedView : 'card',
                                        category : '',
                                        tag : '',
                                        search : '',
                                        filterByAttribute : false,
                                        hasMoreProducts : true,
                                    }

                                })));
        }

        onReady(state) {
            this.fetchNextGroup();
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

        fetchNextGroup() {

            if(this.state.hasMoreProducts) {

                let response = this.state.products;

                let p1 = '/products?skip=' + (+this.state.count + 9) + '&limit=' + this.state.count ;


                if(this.state.search !== ''){
                    p1 = p1 + '&filter-by=name&filter-val=' + '(?i)(.)*(' + this.state.search + '(.)*)';
                }

                if(this.state.category !== ''){
                    p1 = p1 + '&filter-by=categories.id&filter-val=' + this.state.category;
                }

                if(this.state.tag !== ''){
                    p1 = p1 + '&filter-by=tags.id&filter-val=' + this.state.tag;
                }


                api(p1 + '&sorted-by=' + this.state.selectedSort).then(r => {

                    r.forEach(e => response.push(e.id));

                    this.setState({products : response});

                    if (response.length < this.state.count + 9) {
                        this.setState({hasMoreProducts : false});
                    }

                    this.setState({count : response.length});

                });
            }
        }

        $selectCategory(button) {

            this.setState({
                category  : button.value,
                products : [],
                count : 0,
                hasMoreProducts : true
            });

            this.fetchNextGroup();

        }

        $selectTag(button) {

            this.setState({
                tag  : button.value,
                products : [],
                count : 0,
                hasMoreProducts : true
            });

            this.fetchNextGroup();

        }

        $search() {


            this.setState({
                products : [],
                count : 0,
                hasMoreProducts : true,
                search : $('#searchText').val(),
            })

            this.fetchNextGroup();
        }

        $searchKey(event) {

            const key = event.keyCode || event.which;

            if (key === 13) {

                this.setState({
                    products : [],
                    count : 0,
                    hasMoreProducts : true,
                    search : $('#searchText').val(),
                })

                this.fetchNextGroup();

            }
        }

        $changeSort(button) {

            this.setState({

                selectedSort : button.value,
                products : [],
                count : 0,
                hasMoreProducts : true,

            });

            this.fetchNextGroup();
        }

        $changeView(button) {
            this.setState({selectedView  : button.value });
        }

        $more(event) {

            this.fetchNextGroup();
        }

    });


</script>
