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


    <section ui-animated>

        <br>
        <br>
        <br>
        <br>
        <br>
        <br>


        <!-- Breadcrumb -->
        <ui-breadcrumb id="ui-breadcrumb-8" ui:current="${param.product}" ui:urls="/catalog" ui:path="${locale.page_catalog}"></ui-breadcrumb>


        <!-- Product Info -->
        <ui-product-info id="ui-product-info-${param.q}" ui:id="${param.q}"></ui-product-info>


        <br>
        <br>
        <br>

        <section class="ui-details-related">

            <article>

                <h2 ui-animated-scroll="slideInUp">${locale.details_products_similiar}</h2>

                <div class="ui-details-related-slider" ui-animated-scroll="slideInRight">
                    <ui-product-related id="ui-details-related-${param.q}-slider-1"></ui-product-related>
                </div>

            </article>

        </section>

        <br>
        <br>
        <br>

        <section class="ui-details-related">

            <article>

                <h2 ui-animated-scroll="slideInUp">${locale.details_products_news}</h2>

                <div class="ui-details-related-slider" ui-animated-scroll="slideInRight">
                    <ui-product-related id="ui-details-related-${param.q}-slider-2"></ui-product-related>
                </div>

            </article>

        </section>

        <br>
        <br>
        <br>
        <br>
        <br>

    </section>



    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>
