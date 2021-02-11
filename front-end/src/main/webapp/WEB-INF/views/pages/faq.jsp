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



<section id="ui-navigation-container" ui-title="${locale.page_faq} &ndash; ${locale.info_title}">

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="faq"></ui-navbar>



    <br>
    <br>
    <br>
    <br>
    <br>
    <br>


    <section class="bg-light">

        <div class="ui-faq-header">

            <div class="ui-faq-header-content">

                <div class="ui-faq-header-block">

                    <ui-image id="ui-faq-header-image"
                              class="ui-faq-header-image"
                              ui:animation="slideInLeft"
                              ui:src="/assets/img/faq/faq.webp"
                              ui:width="100%"
                              ui:height="320px"
                              ui:position="center"
                              ui:size="contain"></ui-image>

                    <h1 ui-animated-scroll="slideInRight">${locale.faq_header}</h1>

                </div>
            </div>

        </div>

    </section>


    <br>

    <div class="mx-5" ui-animated="slideInLeft">

        <!-- Breadcrumb -->
        <ui-breadcrumb id="ui-breadcrumb-189" ui:current="${locale.page_faq}"></ui-breadcrumb>

    </div>



    <!-- FAQ -->
    <section class="ui-container bg-white text-dark" ui-animated>

        <br>
        <br>
        <br>

        <article>
            <div class="accordion accordion-flush" id="faq-accordion-1">
                <h1>${locale.faq_covid_title}</h1>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed text-dark" type="button" data-bs-toggle="collapse" data-bs-target="#faq-1-1">
                            ${locale.faq_covid_1_subtitle}
                        </button>
                    </h2>
                    <div id="faq-1-1" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-1">
                        <div class="accordion-body">
                            ${locale.faq_covid_1_content}
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-1-2">
                            ${locale.faq_covid_2_subtitle}
                        </button>
                    </h2>
                    <div id="faq-1-2" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-1">
                        <div class="accordion-body">
                            ${locale.faq_covid_2_content}
                        </div>
                    </div>
                </div>

            </div>

            <br>
            <br>
            <h1>${locale.faq_product_title}</h1>
            <div class="accordion accordion-flush" id="faq-accordion-2">

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-2-1">
                            ${locale.faq_product_1_subtitle}
                        </button>
                    </h2>
                    <div id="faq-2-1" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-2">
                        <div class="accordion-body">
                            ${locale.faq_product_1_content}
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-2-2">
                            ${locale.faq_product_2_subtitle}
                        </button>
                    </h2>
                    <div id="faq-2-2" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-2">
                        <div class="accordion-body">
                            ${locale.faq_product_2_content}
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-2-3">
                            ${locale.faq_product_3_subtitle}
                        </button>
                    </h2>
                    <div id="faq-2-3" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-2">
                        <div class="accordion-body">
                            ${locale.faq_product_3_content}
                        </div>
                    </div>
                </div>

            </div>

            <br>
            <br>
            <h1>${locale.faq_payment_title}</h1>
            <div class="accordion accordion-flush" id="faq-accordion-3">

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-3-1">
                            ${locale.faq_payment_1_subtitle}
                        </button>
                    </h2>
                    <div id="faq-3-1" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-3">
                        <div class="accordion-body">
                            ${locale.faq_payment_1_content}
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-3-2">
                            ${locale.faq_payment_2_subtitle}
                        </button>
                    </h2>
                    <div id="faq-3-2" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-3">
                        <div class="accordion-body">
                            ${locale.faq_payment_2_content}
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-3-3">
                            ${locale.faq_payment_3_subtitle}
                        </button>
                    </h2>
                    <div id="faq-3-3" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-3">
                        <div class="accordion-body">
                            ${locale.faq_payment_3_content}
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-3-4">
                            ${locale.faq_payment_4_subtitle}
                        </button>
                    </h2>
                    <div id="faq-3-4" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-3">
                        <div class="accordion-body">
                            ${locale.faq_payment_4_content}
                        </div>
                    </div>
                </div>

            </div>

            <br>
            <br>
            <h1>${locale.faq_shipping_title}</h1>
            <div class="accordion accordion-flush" id="faq-accordion-4">

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-4-1">
                            ${locale.faq_shipping_1_subtitle}
                        </button>
                    </h2>
                    <div id="faq-4-1" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-4">
                        <div class="accordion-body">
                            ${locale.faq_shipping_1_content}
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-4-2">
                            ${locale.faq_shipping_2_subtitle}
                        </button>
                    </h2>
                    <div id="faq-4-2" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-4">
                        <div class="accordion-body">
                            ${locale.faq_shipping_2_content}
                        </div>
                    </div>
                </div>

            </div>

            <br>
            <br>
            <h1>${locale.faq_other_title}</h1>
            <div class="accordion accordion-flush" id="faq-accordion-5">

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-5-1">
                            ${locale.faq_other_1_subtitle}
                        </button>
                    </h2>
                    <div id="faq-5-1" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-5">
                        <div class="accordion-body">
                            ${locale.faq_other_1_content}
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-5-2">
                            ${locale.faq_other_2_subtitle}
                        </button>
                    </h2>
                    <div id="faq-5-2" class="accordion-collapse collapse" data-bs-parent="#faq-accordion-5">
                        <div class="accordion-body">
                            ${locale.faq_other_2_content}
                        </div>
                    </div>
                </div>

            </div>
        </article>

        <br>
        <br>
        <br>
        <br>
        <br>

    </section>


    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="faq"></ui-footer>

</section>