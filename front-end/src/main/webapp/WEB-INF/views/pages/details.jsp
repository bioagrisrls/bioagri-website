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

<section id="ui-navigation-container" ui-title="${param.product} &ndash; ${locale.page_details} &ndash; ${locale.info_title}">

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ></ui-navbar>

    <br>
    <br>

    <div class="ui-container">

        <!-- Breadcrumb -->
        <ui-breadcrumb id="ui-breadcrumb-8" ui:current="${param.product}" ui:urls="/catalog" ui:path="${locale.page_catalog}"></ui-breadcrumb>

    </div>

    <br>
    <br>

    <section ui-animated>

        <div class="ui-container">

            <!-- Product Info -->
            <ui-product-info id="ui-product-info-${param.q}" ui:id="${param.q}"></ui-product-info>


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
