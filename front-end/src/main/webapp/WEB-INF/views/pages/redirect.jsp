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



<section id="ui-navigation-container" ui-title="${locale.page_about} &ndash; ${locale.info_title}">

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="about"></ui-navbar>


    <br>
    <br>
    <br>
    <br>
    <br>
    <br>

    <section>

        <div class="ui-about-header">

            <div class="ui-about-header-content">

                <div class="ui-about-header-block">

                    <ui-image id="ui-about-header-image"
                              class="ui-about-header-image"
                              ui:animation="slideInLeft"
                              ui:src="/assets/img/common/working.png"
                              ui:width="100%"
                              ui:height="320px"
                              ui:position="center"
                              ui:size="contain"></ui-image>

                    <h1 ui-animated-scroll="slideInRight">${locale.redirect_wait}</h1>

                </div>

            </div>

        </div>

    </section>


    <br>
    <br>
    <br>
    <br>
    <br>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="about"> </ui-footer>

</section>


<script>

    $(document).on('ui-ready', () => {

        const q = `${param.q}`;

        if(q !== '') {

            const i = JSON.parse(btoa(q));
            const { id, type, auth } = i;


            switch (type) {

                case 'user-active':

                    return api('/users/' + id + '/active', 'POST', { auth }, 'raw')
                        .finally(() => {
                            setTimeout(() => window.location = '/home', 5000);
                        });


            }



        } else {
            window.location = '/home';
        }

    });



</script>