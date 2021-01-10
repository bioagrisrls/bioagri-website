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

                api('/feedbacks?sorted-by=createdAt&filter-by=productId&filter-val=' + (props.id || ''))
                    .then( r1 => api('/products/' + (props.id || '') + '/images')
                    .then( r2 => {

                    return {
                        feedbacks: r1,
                        images: r2,
                        users: [],
                        productId: props.id,
                    }

                })).catch(r => {

                    console.log(r);

                }));
        }

        onReady(state) {

            this.state.feedbacks.forEach( item => {
                api('/feedbacks/' + item.userId + '/owner').then(response => {

                    this.state.users.push(response);
                    this.setState({users: this.state.users})

                });
            })

        }

        onRender() {
            return `${components.products_feedback}`
        }

    });


</script>

