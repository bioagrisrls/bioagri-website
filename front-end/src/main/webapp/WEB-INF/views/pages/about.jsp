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

<jsp:include page="/WEB-INF/components/common/navbar/navbar.controller.jsp" />
<jsp:include page="/WEB-INF/components/common/header/header.controller.jsp" />
<jsp:include page="/WEB-INF/components/common/footer/footer.controller.jsp" />

<section id="ui-navigation-container">

    <!-- Header -->
    <ui-header id="ui-header"></ui-header>

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="about"></ui-navbar>

    <!-- About -->
    <section ui-animated>

        <div class="ui-container ui-about">

            <br>
            <br>
            <br>
            <br>

            <!-- About Header -->
            <div class="row align-items-center">

                <div class="col-md">
                    <ul>
                        <li>
                            <h6 class="ui-about-header-title"> ${ locale.about_header_title } </h6>
                            <h1 class="ui-about-header-subtitle"><span > ${ locale.about_header_subtitle_start } </span><b> ${ locale.about_header_subtitle_end } </b></h1>
                            <img class="ui-about-leaf" src="/assets/img/about/decor.jpg">
                            <p> ${ locale.about_header_body } </p>
                        </li>
                    </ul>
                </div>

                <div class="col-md text-center">
                    <img class="ui-rounded-image" src="/assets/img/about/img_rounded.jpg">
                </div>

            </div>

            <br>
            <br>

            <!-- About History -->
            <div class="row align-items-center justify-content-center ui-history">

                <div class="col-md text-center ui-history-header">

                    <header>${ locale.history_subtitle }</header>
                    <h1 >${ locale.history_title }</h1>

                    <br>

                    <img class="ui-history-image" src="/assets/img/about/img_rounded.jpg">
                    <div class="ui-history-divider align-items-center justify-content-center"></div>

                </div>


                <div class="ui-history-grid">

                    <div class="row">

                        <article class="ui-parallax-caption-center">

                            <div class="ui-history-left">
                                <div class="ui-history-title-left">
                                    <h1 class="animate__animated animate__backInDown">2006</h1>
                                </div>

                                <p class="animate__animated animate__backInDown">Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                            </div>
                            <br>

                            <div class="ui-history-right">
                                <div class="ui-history-title-right">
                                    <h1  class="animate__animated animate__backInDown">2018</h1>
                                </div>

                                <p class="animate__animated animate__backInDown">Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                            </div>

                        </article>

                    </div>

                    <br><br>
                    <br><br>
                    <br><br>
                    <br><br>

                </div>

        </div>


    </section>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>