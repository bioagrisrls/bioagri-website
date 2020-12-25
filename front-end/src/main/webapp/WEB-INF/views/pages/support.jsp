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


<section id="ui-navigation-container" ui-title="${locale.page_support} &ndash; ${locale.info_title}">

    <!-- Header -->
    <ui-header id="ui-header"></ui-header>

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="support"></ui-navbar>

    <!-- Support -->
    <section ui-animated>

        <!-- Support Header -->
        <ui-parallax id="ui-parallax-3" ui:src="/assets/img/about/header.jpg" ui:reserve="300px">
            <div class="ui-container">

                <div class="row">

                    <div class="col-auto ui-text-block ui-support-header ui-support-shadow">
                        <h1 class="display-6 pt-3">${ locale.support_title }</h1>
                    </div>

                </div>

            </div>
        </ui-parallax>

        <br>
        <br>

        <div class="ui-container">

            <!-- Breadcrumb -->
            <ui-breadcrumb id="ui-breadcrumb-1" ui:current="${locale.page_support}"></ui-breadcrumb>

        </div>

        <br>
        <br>

        <div class="ui-container">

            <!-- Contact Info -->
            <section>
                <div class="ui-container">
                    <div class="row">
                        <div class="col-12 ui-support-contact-info">
                            <div class="text-center">
                                <h6 class="display-8"> ${ locale.support_contact_info_title } </h6>
                                <h1 class="display-5"><span> ${ locale.support_contact_info_subtitle_start } </span><b> ${ locale.support_contact_info_subtitle_end } </b></h1>
                                <img class="mt-3" src="/assets/img/support/decorator.jpg">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 col-md-4">
                            <div class="ui-support-contact-info-icon rounded">

                            </div>
                        </div>
                        <div class="col-12 col-md-4">

                        </div>
                        <div class="col-12 col-md-4">

                        </div>
                    </div>
                </div>
            </section>

        </div>

    </section>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>