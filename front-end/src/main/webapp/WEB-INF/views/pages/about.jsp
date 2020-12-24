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
<jsp:include page="/WEB-INF/components/image/parallax/parallax.controller.jsp"/>

<section id="ui-navigation-container">

    <!-- Header -->
    <ui-header id="ui-header"></ui-header>

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="about"></ui-navbar>

    <!-- About -->
    <section ui-animated>

        <!-- About Header -->
        <ui-parallax id="ui-parallax-3" ui:src="/assets/img/about/header.jpg" ui:reserve="300px">
            <div class="ui-about-header">
                <h2>${ locale.about_title }</h2>
            </div>
        </ui-parallax>

        <br>
        <br>

        <div class="ui-container ui-about">


            <!-- About Presentation -->
            <div class="row align-items-center">

                <div class="col-md">
                    <ul>
                        <li>
                            <h6 class="ui-about-presentation-title"> ${ locale.about_presentation_title } </h6>
                            <h1 class="ui-about-presentation-subtitle"><span > ${ locale.about_presentation_subtitle_start } </span><b> ${ locale.about_presentation_subtitle_end } </b></h1>
                            <img class="ui-about-leaf" src="/assets/img/about/decorator.jpg">
                            <p> ${ locale.about_presentation_body } </p>
                        </li>
                    </ul>
                </div>

                <div class="col-md text-center">
                    <img class="ui-rounded-image" src="/assets/img/about/field.jpg">
                </div>

            </div>


            <br>
            <br>
            <br>
            <br>
            <br>


            <!-- About History -->

            <div class="row align-items-center text-center justify-content-center ui-history">
                <div class="col-md ui-history-header">

                    <header>${ locale.history_subtitle }</header>
                    <h1 >${ locale.history_title }</h1>

                    <br>

                    <img class="ui-history-image" src="/assets/img/about/field.jpg">

                </div>
            </div>

            <div class="row align-items-center justify-content-center ui-history">

                <div class="col col-5 ">

                    <div>
                        <div>
                            <h1 class="ui-history-title-left">2018</h1>
                            <header class="ui-history-separator-left"></header>
                        </div>

                        <p class="ui-history-body-left">Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                    </div>

                </div>

                <div class="col col-2 ui-history-center">
                    <div class="ui-history-divider"></div>
                </div>

                <div class="col col-5">

                    <div>
                        <div>
                            <h1 class="ui-history-title-right">2018</h1>
                            <header class="ui-history-separator-right"></header>
                        </div>

                        <p class="ui-history-body-right">Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                    </div>

                </div>

            </div>

        </div>

    </section>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>