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
<jsp:include page="/WEB-INF/components/image/parallax/parallax.controller.jsp" />
<jsp:include page="/WEB-INF/components/image/image/image.controller.jsp" />



<section id="ui-navigation-container" ui-title="${locale.info_title}">

    <!-- Header -->
    <ui-header id="ui-header"></ui-header>

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="home"></ui-navbar>


    <section ui-animated>

        <!-- Slide show -->
        <ui-parallax id="ui-parallax-1" ui:src="/assets/img/home" ui:items="parallax01.jpg,parallax02.jpg" ui:delay="5">

            <div class="ui-container p-4">

                <div class="ui-parallax-caption-item">

                    <h1 class="animate__animated animate__backInDown">
                        The Hearth Of The Farm Is The True Center Of Our Universe.
                    </h1>

                    <p class="animate__animated animate__backInUp">
                        Mauris vestibulum dolor nec lacinia facilisis. Fusce interdum sagittis volutpat. Praesent eget varius ligula, malesuada eleifend purus. Aenean euismod est at mauris mollis ultricies.
                        Morbi arcu mi, dictum eu luala, dapibus
                        interdum mollis.
                    </p>

                    <button type="button" class="btn btn-primary animate__animated animate__backInUp">Contact us</button>

                </div>

                <div class="ui-parallax-caption-item">

                    <h1 class="animate__animated animate__backInDown">
                        Animate.css v4 brought some breaking changes.
                    </h1>

                    <p class="animate__animated animate__backInUp">
                        Animate.css is a library of ready-to-use, cross-browser animations for use in your web projects.
                        Great for emphasis, home pages, sliders, and attention-guiding hints.
                    </p>

                    <button type="button" class="btn btn-primary animate__animated animate__backInUp">Reent T-MAX</button>

                </div>

            </div>

        </ui-parallax>



        <div class="ui-container">

            <section class="pt-5 pb-5">

                <!-- Banner -->
                <div class="pt-5 pb-5">
                    <ui-image id="ui-image-services-banner" ui:src="/assets/img/home/services-banner.jpg" ui:width="100%" ui:rounded></ui-image>
                </div>

                <!-- Services -->
                <div class="row">
                    <div class="col-md text-center" ui-animated-hover ui-animated-scroll><ui-image id="ui-image-services-01" class="d-block p-3" ui:src="/assets/img/home/1.png"></ui-image><h5>Best Services</h5></div>
                    <div class="col-md text-center" ui-animated-hover ui-animated-scroll><ui-image id="ui-image-services-02" class="d-block p-3" ui:src="/assets/img/home/2.png"></ui-image><h5>Farm Experiences</h5></div>
                    <div class="col-md text-center" ui-animated-hover ui-animated-scroll><ui-image id="ui-image-services-03" class="d-block p-3" ui:src="/assets/img/home/3.png"></ui-image><h5>100% Natural</h5></div>
                    <div class="col-md text-center" ui-animated-hover ui-animated-scroll><ui-image id="ui-image-services-04" class="d-block p-3" ui:src="/assets/img/home/4.png"></ui-image><h5>Farm Equipment</h5></div>
                    <div class="col-md text-center" ui-animated-hover ui-animated-scroll><ui-image id="ui-image-services-05" class="d-block p-3" ui:src="/assets/img/home/5.png"></ui-image><h5>Organic food</h5></div>
                </div>


            </section>

        </div>

        <ui-parallax id="ui-parallax-2" ui:src="/assets/img/home/parallax02.jpg" ui:reserve="400px">
            <h2>Hello World!</h2>
        </ui-parallax>

    </section>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>




