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

    Component.register('ui-review', (id, props) => new class extends FormComponent {

        constructor() {
            super(id, {

                $header: `
                    <div>
                        <h3>${locale.review_header}: ` + props.name + `</h3>
                    </div>
                `,

                $footer: '',
                $success: props.success,


                $submit: {
                    value: '${locale.review_send}',
                    align: 'center',
                    style: 'btn-block clear-both'
                },

                userId: {
                    type: 'hidden',
                    value: sessionStorage.getItem('X-Auth-UserInfo-Id')
                },

                productId: {
                    type: 'hidden',
                    value: props.id
                },

                vote: {
                    type: 'hidden',
                    value: ''
                },

                title: {
                    type: 'text',
                    placeholder: '${locale.review_title}',
                    required: true,
                    wrong: '${locale.review_title_wrong}'
                },

                description: {
                    type: 'textarea',
                    placeholder: '${locale.review_description}',
                    required: true,
                    wrong: '${locale.review_description_wrong}'
                },

                stars: {
                    type: 'html',
                    html: `
                        <div class="py-3">
                            <p> ${locale.review_stars} </p>
                            <ui-stars id="` + id.id + `-stars-component"
                                      ui:clickable="true"
                                      ui:vote="5"
                                      ui:bind-1="#` + id.id + `-vote:vote"></ui-stars>
                        </div>
                    `
                },

            });
        }


        onReady(state) {
            this.state = { $state: 'ready' };
        }

        onUpdated(state) {

            if(state.$state === 'ok') {

                $(document).trigger('ui-review-on-success');

                Component.render(Component.dummy(), `${components.common_notify}`, {
                    message: state.$success
                });

            }
        }


        onSubmit(data) {

            return api('/feedbacks', 'POST', {
                id:             '0',
                title:          data.title,
                description:    data.description,
                vote:           data.vote,
                productId:      data.productId,
                userId:         data.userId,
                createdAt:      new Date().toISOString(),
                updatedAt:      new Date().toISOString(),
            }, 'raw')
            .then(response => {
                this.state = { $state: 'ok' };
            })
            .catch(reason => {
                this.state = { $state: 'error', $reason: reason };
            });

        }

    });

</script>
