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

<%@ page import="java.util.List" %>
<%@ page import="java.util.function.Consumer" %>
<%@ page import="java.io.IOException" %>


<!DOCTYPE html>
<html lang="it">

    <head>
    
        <meta charset="UTF-8" />
        <meta name="description" content="" />  <!-- TODO! -->
        <meta name="author" content="Bioagri S.r.l.s." />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" />
        <meta name="theme-color" content="rgb(236, 104, 81)" /> <!-- TODO! -->
        <meta name="msapplication-navbutton-color" content="rgb(236, 104, 81)" />  <!-- TODO! -->
        <meta name="apple-mobile-web-app-status-bar-style" content="rgb(236, 104, 81)" />  <!-- TODO! -->
    
        <meta property="og:title" content="Bioagri Shop" /> <!-- TODO! -->
        <meta property="og:description" content="" />  <!-- TODO! -->
        <meta property="og:type" content="website" />
        <meta property="og:url" content="https://www.bioagrishop.it" />
        <meta property="og:image" content="/assets/favicon.png" />
    
        <link rel="profile" href="http://gmpg.org/xfn/11">
        <link rel="icon" href="/assets/favicon.png">
    
        <title>Bioagri Shop</title>
    
    
        <!-- Third-party Styles -->
        <link rel="stylesheet" href="/assets/css/third-party/material-design-icons/materialdesignicons.min.css">
        <link rel="stylesheet" href="/assets/css/third-party/animate/animate.min.css">
    
        <!-- Styles -->
        <link rel="stylesheet" href="/assets/css/ui-bootstrap.min.css">
    
    
        <!-- Third-party Dependencies -->
        <script src="/assets/js/third-party/jquery.min.js"></script>
        <script src="/assets/js/third-party/popper.min.js"></script>
        <script src="/assets/js/third-party/js.cookie.min.js"></script>
        <script src="/assets/js/third-party/bootstrap/bootstrap.min.js"></script>
        <script src="https://apis.google.com/js/api.js"></script>
        <script src="https://apis.google.com/js/platform.js"></script>
    
    
        <!-- Dependencies -->
        <script src="/assets/js/services/google.js"></script>
        <script src="/assets/js/ui/api.js"></script>
        <script src="/assets/js/ui/auth.js"></script>
        <script src="/assets/js/ui/components.js"></script>
        <script src="/assets/js/ui/shopping.js"></script>
        <script defer src="/assets/js/ui/navigation.js"></script>
        <script defer src="/assets/js/ui/animation.js"></script>

    
        <%@ include file="/WEB-INF/components/common/breadcrumb/breadcrumb.controller.jsp"      %>
        <%@ include file="/WEB-INF/components/common/footer/footer.controller.jsp"              %>
        <%@ include file="/WEB-INF/components/common/form/form.controller.jsp"                  %>
        <%@ include file="/WEB-INF/components/common/gallery/gallery.controller.jsp"            %>
        <%@ include file="/WEB-INF/components/common/header/header.controller.jsp"              %>
        <%@ include file="/WEB-INF/components/common/navbar/navbar.controller.jsp"              %>
        <%@ include file="/WEB-INF/components/common/stars/stars.controller.jsp"                %>
        <%@ include file="/WEB-INF/components/common/contact/contact.controller.jsp"            %>
        <%@ include file="/WEB-INF/components/image/image/image.controller.jsp"                 %>
        <%@ include file="/WEB-INF/components/image/parallax/parallax.controller.jsp"           %>
        <%@ include file="/WEB-INF/components/products/card/card.controller.jsp"                %>
        <%@ include file="/WEB-INF/components/products/catalog/catalog.controller.jsp"          %>
        <%@ include file="/WEB-INF/components/products/info/info.controller.jsp"                %>
        <%@ include file="/WEB-INF/components/products/stats/stats.controller.jsp"              %>
        <%@ include file="/WEB-INF/components/products/related/related.controller.jsp"          %>
        <%@ include file="/WEB-INF/components/shopping/cart/cart.controller.jsp"                %>
        <%@ include file="/WEB-INF/components/shopping/checkout/checkout.controller.jsp"        %>
        <%@ include file="/WEB-INF/components/users/login/login.controller.jsp"                 %>
        <%@ include file="/WEB-INF/components/users/registration/registration.controller.jsp"   %>

    </head>

    <body>
        <jsp:include page="${reference}" />
    </body>

</html>
