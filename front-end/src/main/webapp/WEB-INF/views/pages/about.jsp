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

    <section class="bg-light">

        <div class="ui-about-header">

            <div class="ui-about-header-content">

                <div class="ui-about-header-block">

                    <ui-image id="ui-about-header-image"
                              class="ui-about-header-image"
                              ui:animation="slideInLeft"
                              ui:src="/assets/img/about/aboutus.png"
                              ui:width="100%"
                              ui:height="320px"
                              ui:position="center"
                              ui:size="contain"></ui-image>

                    <h1 ui-animated-scroll="slideInRight">${locale.about_header}</h1>

                </div>

            </div>

        </div>

    </section>


    <!-- About -->
    <section class="ui-about" ui-animated>

        <br>

        <div class="mx-5" ui-animated="slideInLeft">

            <!-- Breadcrumb -->
            <ui-breadcrumb id="ui-breadcrumb-1" ui:current="${locale.page_about}"></ui-breadcrumb>

        </div>

        <br>
        <br>

        <!-- About Presentation -->
        <section>
            <div class="ui-about-presentation">

                <div class="ui-about-presentation-title">
                    <h4>${locale.about_presentation_subtitle}</h4>
                    <h1>${locale.about_presentation_title}</h1>
                    <p class="mt-3"> ${ locale.about_presentation_body } </p>
                </div>

                <div class="ui-about-presentation-image">
                    <ui-image id="ui-about-owner"
                              ui:animation="slideInLeft"
                              ui:src="/assets/img/about/owner.jpg"
                              ui:width="100%"
                              ui:height="320px"
                              ui:position="center"
                              ui:size="contain"></ui-image>
                </div>

            </div>
        </section>


        <br>
        <br>
        <br>
        <br>
        <br>


        <!-- About History -->
        <section class="ui-about-history">

            <!-- History Head -->
            <div class="ui-about-history-header">

                <h4>${locale.about_history_subtitle}</h4>
                <br>
                <h1>${locale.about_history_title}</h1>

                <br>

                <div class="ui-about-history-image">
                    <ui-image id="ui-about-shop"
                              ui:animation="slideInLeft"
                              ui:src="/assets/img/about/shop.jpeg"
                              ui:width="100%"
                              ui:height="100%"
                              ui:position="center"
                              ui:size="cover"></ui-image>
                </div>

            </div>


            <!-- History Body -->
            <div class="ui-history-body">


                <div class="ui-history-body-row">

                    <div class="ui-history-body-left" ui-animated-hover ui-animated-scroll>

                        <h1>${locale.about_history_1_year}</h1>
                        <p>${locale.about_history_1_event}</p>

                    </div>

                    <div class="ui-history-body-right" ui-animated-hover ui-animated-scroll>

                    </div>

                </div>

                <div class="ui-history-body-row">

                    <div class="ui-history-body-left" ui-animated-hover ui-animated-scroll>

                    </div>

                    <div class="ui-history-body-right" ui-animated-hover ui-animated-scroll>

                        <h1>${locale.about_history_2_year}</h1>
                        <p>${locale.about_history_2_event}</p>

                    </div>

                </div>

                <div class="ui-history-body-row">

                    <div class="ui-history-body-left" ui-animated-hover ui-animated-scroll>

                        <h1>${locale.about_history_3_year}</h1>
                        <p>${locale.about_history_3_event}</p>

                    </div>

                    <div class="ui-history-body-right" ui-animated-hover ui-animated-scroll>

                    </div>

                </div>

                <div class="ui-history-body-row">

                    <div class="ui-history-body-left" ui-animated-hover ui-animated-scroll>

                    </div>

                    <div class="ui-history-body-right" ui-animated-hover ui-animated-scroll>

                        <h1>${locale.about_history_4_year}</h1>
                        <p>${locale.about_history_4_event}</p>

                    </div>

                </div>

                <div class="ui-history-body-row">

                    <div class="ui-history-body-left" ui-animated-hover ui-animated-scroll>

                        <h1>${locale.about_history_5_year}</h1>
                        <p>${locale.about_history_5_event}</p>

                    </div>

                    <div class="ui-history-body-right" ui-animated-hover ui-animated-scroll>

                    </div>

                </div>

            </div>

        </section>

    </section>

    <br>
    <br>
    <br>
    <br>
    <br>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="about"> </ui-footer>

</section>