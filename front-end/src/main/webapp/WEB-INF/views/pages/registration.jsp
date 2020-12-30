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

<jsp:include page="/WEB-INF/components/common/header/header.controller.jsp" />
<jsp:include page="/WEB-INF/components/common/navbar/navbar.controller.jsp" />
<jsp:include page="/WEB-INF/components/common/footer/footer.controller.jsp" />
<jsp:include page="/WEB-INF/components/common/form/form.controller.jsp" />
<jsp:include page="/WEB-INF/components/users/login/login.controller.jsp" />
<jsp:include page="/WEB-INF/components/users/registration/registration.controller.jsp" />
<jsp:include page="/WEB-INF/components/shopping/cart/cart.controller.jsp" />
<jsp:include page="/WEB-INF/components/image/parallax/parallax.controller.jsp" />
<jsp:include page="/WEB-INF/components/image/image/image.controller.jsp" />
<jsp:include page="/WEB-INF/components/products/card/card.controller.jsp" />
<jsp:include page="/WEB-INF/components/signin/google/google.controller.jsp" />



<section id="ui-navigation-container" ui-title="${locale.page_registration} &ndash; ${locale.info_title}">

    <!-- Header -->
    <ui-header id="ui-header"></ui-header>

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="home"></ui-navbar>


    <section ui-animated>

        <!-- Page Header -->
        <ui-parallax id="ui-parallax-registration-header" ui:src="/assets/img/about/header.jpg" ui:reserve="300px">
            <div class="ui-container">
                <div class="row">
                    <div class="col-12 ui-about-header">
                        <h1 class="display-6 p-3">${locale.page_registration}</h1>
                    </div>
                </div>
            </div>
        </ui-parallax>


        <br>
        <br>
        <br>
        <br>

        <div class="ui-container">
            <div class="bg-light shadow border w-50 w-lg-100 mx-auto my-5" ui-animated="backInUp">
                <div class="my-5">

                    <!-- Registration Logo -->
                    <div class="d-flex justify-content-center">
                        <img src="${ locale.nav_logo }" width="64" height="64" />
                    </div>

                    <!-- Registration Slogan -->
                    <h4 class="text-center display-6">${ locale.registration_slogan_title }</h4>
                    <p class="text-center display-7">${ locale.registration_slogan_subtitle }</p>

                    <div class="p-5">

                        <!-- Registration Form -->
                        <ui-registration id="ui-registration"></ui-registration>

                        <!-- Other Access -->
                        <div class="d-flex justify-content-center">
                            <ul class="list-unstyled">

                                <li><h6 class="text-center display-8 pb-3">${ locale.registration_body }</h6></li>

                                <!-- Google -->
                                <li><ui-signin-google id="ui-signin-google"></ui-signin-google></li>

                                <!-- Facebook -->

                                <!-- Instagram -->

                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <br>
        <br>
        <br>
        <br>

    </section>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>




