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



<section id="ui-navigation-container" ui-title="${locale.page_policy} &ndash; ${locale.info_title}">

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="policy"></ui-navbar>



    <br>
    <br>
    <br>
    <br>
    <br>
    <br>


    <section class="bg-light">

        <div class="ui-policy-header">

            <div class="ui-policy-header-content">

                <div class="ui-policy-header-block">

                    <ui-image id="ui-policy-header-image"
                              class="ui-policy-header-image"
                              ui:animation="slideInLeft"
                              ui:src="/assets/img/policy/policy.webp"
                              ui:width="100%"
                              ui:height="320px"
                              ui:position="center"
                              ui:size="contain"></ui-image>

                    <h1 ui-animated-scroll="slideInRight">${locale.policy_header}</h1>

                </div>
            </div>

        </div>

    </section>


    <br>

    <div class="mx-5" ui-animated="slideInLeft">

        <!-- Breadcrumb -->
        <ui-breadcrumb id="ui-breadcrumb-1" ui:current="${locale.page_policy}"></ui-breadcrumb>

    </div>



    <!-- Support -->
    <section class="ui-container" ui-animated>

        <br>
        <br>

        <article>
            ${locale.info_policy}
        </article>

    </section>


    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="policy"></ui-footer>

</section>