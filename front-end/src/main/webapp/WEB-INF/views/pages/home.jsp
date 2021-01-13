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
        <img class="ui-home-background" src="/assets/img/home/background.png" alt="" ui-animated="slideInRight"/>
        <div class="ui-home-content" ui-animated="slideInLeft">
            <h3>${locale.home_intro_header}</h3>
            <h1>${locale.home_intro_title}</h1>
            <p>${locale.home_intro_description}</p>
            <div class="ui-home-order-now" ui-animated="slideInUp">
                <div class="row">
                    <div class="col-sm-auto">
                        <img src="/assets/img/home/content01.png" alt="" />
                    </div>
                    <div class="col-sm">
                        <div class="ui-home-order-content" ui-animated-hover>
                            <a class="stretched-link" href="#"><h3>${locale.home_section_order_header}</h3></a>
                            <p>${locale.home_section_order_description}</p>
                        </div>
                        <div class="ui-home-social-buttons">
                            <ul>
                                <li><a target="_blank" href="${locale.info_facebook}"><span class="mdi mdi-48px mdi-facebook"></span></a></li>
                                <li><a target="_blank" href="${locale.info_twitter}"><span class="mdi mdi-48px mdi-twitter"></span></a></li>
                                <li><a target="_blank" href="${locale.info_instagram}"><span class="mdi mdi-48px mdi-instagram"></span></a></li>
                                <li><a target="_blank" href="${locale.info_linkedin}"><span class="mdi mdi-48px mdi-linkedin"></span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>




