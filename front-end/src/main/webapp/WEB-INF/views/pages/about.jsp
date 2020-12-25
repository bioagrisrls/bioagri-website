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
<jsp:include page="/WEB-INF/components/common/breadcrumb/breadcrumb.controller.jsp"/>
<jsp:include page="/WEB-INF/components/image/parallax/parallax.controller.jsp"/>


<section id="ui-navigation-container" ui-title="${locale.page_about} &ndash; ${locale.info_title}">

    <!-- Header -->
    <ui-header id="ui-header"></ui-header>

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="about"></ui-navbar>

    <!-- About -->
    <section ui-animated>

        <!-- About Header -->
        <ui-parallax id="ui-parallax-3" ui:src="/assets/img/about/header.jpg" ui:reserve="300px">
            <div class="ui-container ui-about-header float-start">
                <h1>${ locale.about_title }</h1>
            </div>
        </ui-parallax>

        <br>
        <br>

        <div class="ui-container">

            <!-- Breadcrumb -->
            <ui-breadcrumb id="ui-breadcrumb-1" ui:current="${locale.page_about}"></ui-breadcrumb>

        </div>

        <br>
        <br>

        <div class="ui-container">


            <!-- About Presentation -->
            <div class="row align-items-center">

                <div class="col-md ui-about-presentation">
                    <ul class="list-unstyled">
                        <li>
                            <h6> ${ locale.about_presentation_title } </h6>
                            <h1><span> ${ locale.about_presentation_subtitle_start } </span><b> ${ locale.about_presentation_subtitle_end } </b></h1>
                            <img class="mt-3" src="/assets/img/about/decorator.jpg">
                            <p class="mt-3"> ${ locale.about_presentation_body } </p>
                        </li>
                    </ul>
                </div>

                <div class="col-md text-center">
                    <img class="ui-about-rounded-image ui-about-shadow" src="/assets/img/about/field.jpg">
                </div>

            </div>


            <br>
            <br>
            <br>
            <br>
            <br>


            <!-- About History -->

            <!-- History Head -->
            <div class="row align-items-center text-center justify-content-center">
                <div class="col-md ui-about-history-header">

                    <header>${ locale.history_subtitle }</header>
                    <h1 >${ locale.history_title }</h1>

                    <br>

                    <img class="ui-about-shadow" src="/assets/img/about/field.jpg">

                </div>
            </div>


            <!-- History Body -->
            <div class="row align-items-center justify-content-center">


                <!-- Left -->
                <div class="col col-5 ">

                    <div class="ui-about-history-mb ui-about-history-left" ui-animated-hover ui-animated-scroll>
                        <div>
                            <h1>2018</h1>
                            <header></header>
                        </div>

                        <p>Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                    </div>

                    <div class="ui-about-history-mb ui-about-history-left" ui-animated-hover ui-animated-scroll>
                        <div>
                            <h1>2018</h1>
                            <header></header>
                        </div>

                        <p>Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                    </div>

                    <div class="ui-about-history-mb ui-about-history-left" ui-animated-hover ui-animated-scroll>
                        <div>
                            <h1>2018</h1>
                            <header></header>
                        </div>

                        <p>Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                    </div>

                </div>


                <!-- Center -->
                <div class="col col-2 ui-about-history-center">
                    <div class="ui-about-history-divider"></div>
                </div>


                <!-- Right -->
                <div class="col col-5">

                    <div class="ui-about-history-mb ui-about-history-mt ui-about-history-right" ui-animated-hover ui-animated-scroll>
                        <div>
                            <h1>2018</h1>
                            <header></header>
                        </div>

                        <p>Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                    </div>

                    <div class="ui-about-history-mb ui-about-history-right" ui-animated-hover ui-animated-scroll>
                        <div>
                            <h1>2018</h1>
                            <header></header>
                        </div>

                        <p>Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                    </div>

                    <div class="ui-about-history-right" ui-animated-hover ui-animated-scroll>
                        <div>
                            <h1>2018</h1>
                            <header></header>
                        </div>

                        <p>Il Centro Cuore vede la luce nel 2006 in una mattina di Agosto per la necessità di svolgere degli esami a pazienti già cardio operati i quali avevano difficoltà estreme ad effettuare un semplice elettrocardiogramma.</p>
                    </div>

                </div>

            </div>


            <br>
            <br>
            <br>
            <br>
            <br>


            <!-- About Cards -->
            <div class="row">

                <div class="col-md mb-5">

                    <div class="ui-about-card-container text-white">
                        <img class="ui-about-shadow img-fluid w-100" src="/assets/img/about/field.jpg">
                        <div class="ui-about-card-overlay p-3">
                            <p>Last updated 3 mins ago.</p>
                            <h3>This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</h3>
                        </div>
                    </div>

                </div>

                <div class="col-md">

                    <div class="card mt-0 mb-5 mx-auto" ui-animated-hover>
                        <div class="card-body ui-about-shadow">
                            <h5 class="card-title">Card title</h5>
                            <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                        </div>
                    </div>

                    <div class="card mt-0 mb-5 mx-auto" ui-animated-hover>
                        <div class="card-body ui-about-shadow">
                            <h5 class="card-title">Card title</h5>
                            <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                        </div>
                    </div>

                    <div class="card mt-0 mb-0 mx-auto" ui-animated-hover>
                        <div class="card-body ui-about-shadow">
                            <h5 class="card-title">Card title</h5>
                            <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                        </div>
                    </div>

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
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>