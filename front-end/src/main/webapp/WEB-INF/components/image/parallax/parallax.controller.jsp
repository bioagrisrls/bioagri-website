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

    Component.register('ui-parallax', (id, props) => new class extends StatefulComponent {

        constructor() {
            super(id, {

                src: props.src || '',
                reserve: props.reserve || '100vh',
                delay: (props.delay * 1000) || 3000,

                items: (props.items && props.items.split(',')) || [],
                previous: (props.items && props.items.split(',').length - 1) || 0,
                current: 0,

            });
        }

        onRender() {
            return `${components.image_parallax}`
        }


        onUpdated(state) {

            if(!state.items)
                throw new Error("items cannot be null");

            if(state.items.length === 0) {

                $(this.elem).find('#ui-parallax-image-current').css({
                    backgroundImage: 'linear-gradient(gray, gray), url(' + state.src + ')',
                    height: state.reserve
                })

            } else {

                $(this.elem).find('#ui-parallax-image-current').css({
                    backgroundImage: 'linear-gradient(gray, gray), url(' + state.src + '/' + state.items[state.current] + ')',
                    height: state.reserve,
                })
                    .toggleClass('animate__animated')
                    .toggleClass('animate__fadeIn');


                $(this.elem).find('#ui-parallax-image-previous').css({
                    backgroundImage: 'linear-gradient(gray, gray), url(' + state.src + '/' + state.items[state.previous] + ')',
                    height: state.reserve,
                    position: 'relative',
                    top: '-' + state.reserve,
                    marginBottom: '-' + state.reserve,
                })
                    .toggleClass('animate__animated')
                    .toggleClass('animate__fadeOut');


                $(this.elem).find('.ui-parallax-caption-item').each((i, e) => {

                    i === state.current
                        ? $(e).show()
                        : $(e).hide();

                })


                window.setTimeout(() => {
                    this.state = {
                        previous: state.current,
                        current: (state.current + 1) % state.items.length
                    }
                }, state.delay);

            }


            $(this.elem).find('#ui-parallax-caption-content').css({
                height: state.reserve,
                position: 'relative',
                top: '-' + state.reserve,
                marginBottom: '-' + state.reserve,
            })

        }

    });


</script>
