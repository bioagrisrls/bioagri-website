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

    Component.register('ui-gallery', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, api('/products/' + (props.id || '') + '/images').then(response => {

                    return {
                        images: response,
                        current: 0
                    }

                })
            );
        }

        onReady(state) {

        }

        onRender() {
            return `${components.common_gallery}`
        }

        onLoading() {
            return `${components.common_gallery_loading}`
        }

        onError() {
            return `${components.common_gallery_error}`
        }

        nextTo() {

            const oldItem = '#carousel-item-' + this.state.current;
            const oldContainer = '#carousel-image-container-' + this.state.current;

            $(oldItem).removeClass('active');
            $(oldContainer).removeClass('border-dark');

            const value = +this.state.current + 1;

            if(+value > (+this.state.images.length - 1))
                this.setState({current: 0}, false);
            else
                this.setState({current: +value}, false);

            const newItem = '#carousel-item-' + this.state.current;
            const newContainer = '#carousel-image-container-' + this.state.current;

            $(newItem).addClass('active');
            $(newContainer).addClass('border-dark');

        }

        prevTo() {

            const oldItem = '#carousel-item-' + this.state.current;
            const oldContainer = '#carousel-image-container-' + this.state.current;

            $(oldItem).removeClass('active');
            $(oldContainer).removeClass('border-dark');

            const value = +this.state.current - 1;

            if(+value < 0)
                this.setState({current: (+this.state.images.length - 1)}, false);
            else
                this.setState({current: +value}, false);

            const newItem = '#carousel-item-' + this.state.current;
            const newContainer = '#carousel-image-container-' + this.state.current;

            $(newItem).addClass('active');
            $(newContainer).addClass('border-dark');

        }

        goTo(i) {

            if(+i === +this.state.current)
                return;

            const oldItem = '#carousel-item-' + this.state.current;
            const oldContainer = '#carousel-image-container-' + this.state.current;

            $(oldItem).removeClass('active');
            $(oldContainer).removeClass('border-dark');

            this.setState({current: +i}, false);

            const newItem = '#carousel-item-' + this.state.current;
            const newContainer = '#carousel-image-container-' + this.state.current;

            $(newItem).addClass('active');
            $(newContainer).addClass('border-dark');

        }

    });



</script>
