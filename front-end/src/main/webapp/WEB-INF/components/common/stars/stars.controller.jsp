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

    Component.register('ui-stars', (id, props) => new class extends StatefulComponent {

        constructor() {

            if(!props.vote) {

                props.id = props.id || 0;
                props.target = props.target || 'products';
                props.type = props.type || 'avg';

                super(id, api('/' + props.target + '/' + props.id + (props.target === 'products' ? '/votes/' + props.type : ''))
                    .then(response => (props.target === 'products' ? response : response.vote))
                    .then(response => {
                        return {
                            id: +props.id,
                            vote: +response,
                            clickable: props.clickable
                        }
                    }));

            } else {

                super(id, {
                    id: +props.id,
                    vote: +props.vote,
                    clickable: props.clickable
                });

            }
        }

        onRender() {
            return `${components.common_stars}`
        }

        onLoading() {
            return `${components.common_stars_loading}`
        }

        onError() {
            return `${components.common_stars_error}`
        }


        turn(index, set = false) {

            if(!this.state.clickable)
                return;

            if(index === 0)
                index = this.state.vote;


            for (let i = 1; i <= index; i++) {
                document.querySelector("#" + this.id + "-star-" + i).classList.remove('mdi-star-outline');
                document.querySelector("#" + this.id + "-star-" + i).classList.add('mdi-star');
            }


            for (let i = index + 1; i <= 5; i++) {
                document.querySelector("#" + this.id + "-star-" + i).classList.remove('mdi-star');
                document.querySelector("#" + this.id + "-star-" + i).classList.add('mdi-star-outline');
            }

            if(set) {
                this.state = {
                    vote: index
                };
            }

        }

    });


</script>
