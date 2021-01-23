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

    Component.register('ui-feedback', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id,

                Promise.all([
                    api('/feedbacks/count?sorted-by=createdAt&filter-by=productId&filter-val=' + (props.id || '')),
                    api('/feedbacks?sorted-by=createdAt&filter-by=productId&filter-val=' + (props.id || '') + '&limit=3'),
                    api('/products/' + (props.id || '') + '/images?limit=1'),
                ]).then(response => {

                    return {

                        feedbacks: response[1],
                        images: response[2],
                        users: [],
                        productId: props.id,
                        skip: 0,
                        count: response[0],

                        strings: {
                            more:       `${locale.feedbacks_more}`,
                            reviewed:   `${locale.feedbacks_reviewed}`
                        }

                    }

                }).catch(() => {})

            )
        }

        onReady(state) {

            Promise.all(this.state.feedbacks.map(i => api('/feedbacks/' + i.userId + '/owner')))
                .then(response => {
                    this.state = {
                        users: response
                    };
                });

        }

        onRender() {
            return `${components.products_feedback}`
        }


        more() {

            api('/feedbacks?sorted-by=createdAt&filter-by=productId&filter-val=' + this.state.productId + '&limit=3&skip=' + this.state.feedbacks.length)
                .then(feedbacks => feedbacks.forEach(i => this.state.feedbacks.push(i)))
                .then(() => {

                    return Promise.all(
                        this.state.feedbacks.map(i => api('/feedbacks/' + i.userId + '/owner')
                            .then(user => this.state.users.push(user))
                        )
                    );

                }).then(() => this.state = {});

       }


    });


</script>

