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



<section id="ui-navigation-container" ui-title="${locale.page_catalog} &ndash; ${locale.info_title}">


    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="catalog"></ui-navbar>




    <section>

        <div class="ui-catalog-background">
            <div></div>
        </div>

        <br>
        <br>
        <br>
        <br>
        <br>
        <br>


        <div class="mx-5 text-center">
            <ui-image id="ui-catalog-promo-image"
                      ui:src="/assets/img/catalog/promo.jpg"
                      ui:width="90%"
                      ui:height="620px"
                      ui:size="cover"
                      ui:animation="slideInRight"></ui-image>
        </div>

        <br>
        <br>

        <div class="mx-5" ui-animated="slideInLeft">

            <!-- Breadcrumb -->
            <ui-breadcrumb id="ui-breadcrumb-3" ui:current="${locale.page_catalog}"></ui-breadcrumb>

        </div>


        <br>
        <br>

        <div ui-animated-scroll="slideInUp">
            <ui-catalog id="ui-catalog"></ui-catalog>
        </div>

        <br>
        <br>
        <br>
        <br>
        <br>

    </section>


    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>