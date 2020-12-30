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

<%--
  Created by IntelliJ IDEA.
  User: Davide
  Date: 29/12/2020
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>

<script defer>

    Component.register('ui-feedback-stars', (id, props) => new class extends StatefulComponent {

        constructor() {

            super(id, api("/products/"+(props.id || 0) +"/votes/avg").then(response => {
                    return {
                        feedbackavg:response,
                        clickable:props.clickable || "false",
                    };
                }));
            }

        onRender() {
            return `${components.common_feedbackStars}`
        }

        onStarClicked(star, index) {

                for (let i = 1; i <= index; i++) {
                    document.querySelector("#" + this.id + "-star-" + i).classList.remove('mdi-star-outline');
                    document.querySelector("#" + this.id + "-star-" + i).classList.add('mdi-star');
                }


                for (let i = index + 1; i <= 5; i++) {
                    document.querySelector("#" + this.id + "-star-" + i).classList.remove('mdi-star');
                    document.querySelector("#" + this.id + "-star-" + i).classList.add('mdi-star-outline');
                }

        }

    });


</script>