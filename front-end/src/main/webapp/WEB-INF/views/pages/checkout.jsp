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
<jsp:include page="/WEB-INF/components/common/breadcrumb/breadcrumb.controller.jsp"/>
<jsp:include page="/WEB-INF/components/common/form/form.controller.jsp" />
<jsp:include page="/WEB-INF/components/users/login/login.controller.jsp" />
<jsp:include page="/WEB-INF/components/shopping/cart/cart.controller.jsp" />
<jsp:include page="/WEB-INF/components/image/parallax/parallax.controller.jsp" />
<jsp:include page="/WEB-INF/components/image/image/image.controller.jsp" />
<jsp:include page="/WEB-INF/components/products/card/card.controller.jsp" />
<jsp:include page="/WEB-INF/components/shopping/checkout/checkout.controller.jsp" />

<section id="ui-navigation-container" ui-title="${locale.page_checkout} &ndash; ${locale.info_title}">

    <!-- Header -->
    <ui-header id="ui-header"></ui-header>

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar"></ui-navbar>

    <br>
    <br>

    <div class="ui-container">

        <!-- Breadcrumb -->
        <ui-breadcrumb id="ui-breadcrumb-6" ui:current="${locale.page_checkout}" ></ui-breadcrumb>

    </div>

    <br>
    <br>

    <section ui-animated>

        <div class="ui-container">

            <!-- Checkout Tabs -->
            <ui-checkout id="ui-checkout-1"></ui-checkout>



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