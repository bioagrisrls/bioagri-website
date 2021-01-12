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



<section id="ui-navigation-container" ui-title="${locale.info_title}">

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="home"></ui-navbar>


    <section class="ui-home" ui-animated>
        <img class="ui-home-background" src="/assets/img/home/background.png" alt="" />
        <div class="ui-home-content">
            <h3>High Quality</h3>
            <h1>Welcome on Bioagri!</h1>
            <div class="ui-home-order-now">
                <div class="row">
                    <div class="col-6">
                        <img src="/assets/img/home/content01.png" alt="" />
                    </div>
                    <div class="col-6">
                        <div class="row">
                            <span>Ordina ora!</span>
                        </div>
                        <div class="row">
                            <div class="ui-home-social-buttons">
                                <ul>
                                    <li><span class="mdi mdi-36px mdi-facebook"></span></li>
                                    <li><span class="mdi mdi-36px mdi-facebook"></span></li>
                                    <li><span class="mdi mdi-36px mdi-facebook"></span></li>
                                    <li><span class="mdi mdi-36px mdi-facebook"></span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>




