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



<section id="ui-navigation-container" ui-title="${locale.info_title}">

    <!-- Navigation Bar -->
    <ui-navbar id="ui-navbar" ui:current="home"></ui-navbar>


    <section class="ui-home" ui-animated>
        <img class="ui-home-background" src="/assets/img/home/background.webp" alt="" ui-animated="slideInRight"/>
        <div class="ui-home-content" ui-animated="slideInLeft">
            <h3>${locale.home_intro_header}</h3>
            <h1>${locale.home_intro_title}</h1>
            <p>${locale.home_intro_description}</p>
            <div class="ui-home-order-now" ui-animated="slideInUp">
                <div class="row">
                    <div class="col-sm-auto">
                        <img src="/assets/img/home/content01.webp" alt="" />
                    </div>
                    <div class="col-sm">
                        <div class="ui-home-order-content" ui-animated-hover>
                            <a class="stretched-link" href="#"><h3>${locale.home_section_order_header}</h3></a>
                            <p>${locale.home_section_order_description}</p>
                        </div>
                        <div class="ui-home-social-buttons">
                            <ul>
                                <li><a target="_blank" href="${locale.info_facebook}"><span class="mdi mdi-48px mdi-facebook"></span></a></li>
                                <li><a target="_blank" href="${locale.info_twitter}"><span class="mdi mdi-48px mdi-twitter"></span></a></li>
                                <li><a target="_blank" href="${locale.info_instagram}"><span class="mdi mdi-48px mdi-instagram"></span></a></li>
                                <li><a target="_blank" href="${locale.info_linkedin}"><span class="mdi mdi-48px mdi-linkedin"></span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <section class="ui-home-promo">

            <article>

                <h2 ui-animated-scroll="slideInUp">${locale.home_promo_last_news}</h2>

                <div class="ui-home-promo-slider" ui-animated-scroll="slideInRight">
                    <ui-product-related id="ui-home-promo-slider-related-1" ui:kind="tags" ui:id="1"></ui-product-related>
                </div>

            </article>


            <section class="bg-secondary">

                <div class="ui-home-promo-sales">

                    <div class="row">
                        <div class="col-auto" ui-animated-scroll="slideInLeft">
                            <ui-image id="ui-home-promo-first-section-start"
                                      class="ui-home-promo-section-image"
                                      ui:src="/assets/img/home/man01.webp"
                                      ui:width="220px"
                                      ui:height="320px"
                                      ui:position="center"
                                      ui:size="auto 192px"></ui-image>
                        </div>
                        <div class="col d-grid align-items-center">

                            <div>
                                <h3>${locale.home_promo_sales_subtitle}</h3>
                                <h1>${locale.home_promo_sales_title}</h1>

                                <button onclick="navigate('/catalog')">${locale.home_promo_sales_catalog}</button>
                            </div>

                        </div>
                        <div class="col-auto" ui-animated-scroll="slideInRight">
                            <ui-image id="ui-home-promo-first-section-end"
                                      class="ui-home-promo-section-image"
                                      ui:src="/assets/img/home/woman02.webp"
                                      ui:width="220px"
                                      ui:height="320px"
                                      ui:position="center"
                                      ui:size="auto 192px"></ui-image>
                        </div>
                    </div>

                </div>

            </section>

            <section class="bg-white">

                <div class="ui-home-promo-categories">

                    <h3>${locale.home_promo_categories_subtitle}</h3>
                    <h1>${locale.home_promo_categories_title}</h1>

                    <div class="row">
                        <div class="col-lg-4" ui-animated-scroll="slideInLeft">

                            <div class="row">
                                <div class="col-md-6 col-lg-12">
                                    <div class="ui-home-promo-category" ui-animated-hover="pulse">
                                        <ui-image id="ui-home-promo-second-section-1"
                                                  class="ui-home-promo-section-image"
                                                  ui:src="/assets/img/home/promo01.webp"
                                                  ui:width="340px"
                                                  ui:height="200px"
                                                  ui:position="center"
                                                  ui:size="cover"></ui-image>

                                        <h5>${locale.home_promo_insecticide_motto}</h5>
                                        <h4>${locale.home_promo_insecticide_link} &rightarrow;</h4>
                                        <a class="stretched-link" href="/catalog"></a>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-12">
                                    <div class="ui-home-promo-category" ui-animated-hover="pulse">
                                        <ui-image id="ui-home-promo-second-section-2"
                                                  class="ui-home-promo-section-image"
                                                  ui:src="/assets/img/home/promo02.webp"
                                                  ui:width="340px"
                                                  ui:height="200px"
                                                  ui:position="center"
                                                  ui:size="cover"></ui-image>
                                        <h5>${locale.home_promo_gardening_motto}</h5>
                                        <h4>${locale.home_promo_gardening_link} &rightarrow;</h4>
                                        <a class="stretched-link" href="/catalog"></a>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-4" ui-animated-scroll="slideInUp">

                            <div class="ui-home-promo-category" ui-animated-hover="pulse">
                            <ui-image id="ui-home-promo-second-section-3"
                                      class="ui-home-promo-section-image"
                                      ui:src="/assets/img/home/promo03.webp"
                                      ui:width="400px"
                                      ui:height="720px"
                                      ui:position="center"
                                      ui:size="cover"></ui-image>
                            <h5>${locale.home_promo_food_motto}</h5>
                            <h4>${locale.home_promo_food_link} &rightarrow;</h4>
                            <a class="stretched-link" href="/catalog"></a>
                        </div>

                        </div>
                        <div class="col-lg-4" ui-animated-scroll="slideInRight">

                            <div class="row">
                                <div class="col-md-6 col-lg-12">
                                    <div class="ui-home-promo-category" ui-animated-hover="pulse">
                                        <ui-image id="ui-home-promo-second-section-4"
                                                  class="ui-home-promo-section-image"
                                                  ui:src="/assets/img/home/promo04.webp"
                                                  ui:width="340px"
                                                  ui:height="200px"
                                                  ui:position="center"
                                                  ui:size="cover"></ui-image>
                                        <h5>${locale.home_promo_household_motto}</h5>
                                        <h4>${locale.home_promo_household_link} &rightarrow;</h4>
                                        <a class="stretched-link" href="/catalog"></a>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-12">
                                    <div class="ui-home-promo-category" ui-animated-hover="pulse">
                                        <ui-image id="ui-home-promo-second-section-5"
                                                  class="ui-home-promo-section-image"
                                                  ui:src="/assets/img/home/promo05.webp"
                                                  ui:width="340px"
                                                  ui:height="200px"
                                                  ui:position="center"
                                                  ui:size="cover"></ui-image>
                                        <h5>${locale.home_promo_accident_motto}</h5>
                                        <h4>${locale.home_promo_accident_link} &rightarrow;</h4>
                                        <a class="stretched-link" href="/catalog"></a>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>

            </section>


            <article>

                <h2 ui-animated-scroll="slideInUp">${locale.home_promo_product}</h2>

                <div class="ui-home-promo-slider" ui-animated-scroll="slideInRight">
                    <ui-product-related id="ui-home-promo-slider-related-2"></ui-product-related>
                </div>

            </article>


            <section class="bg-primary">

                <div class="ui-home-promo-newsletter">

                    <div class="row">

                        <div class="col-md-9 col-lg-6" ui-animated-scroll="slideInUp">

                            <h3>${locale.home_promo_newsletter_motto}</h3>
                            <h1>${locale.home_promo_newsletter_title}</h1>

                            <ui-image id="ui-home-promo-third-section-center"
                                      class="ui-home-promo-section-image-center"
                                      ui:src="/assets/img/home/newsletter1.webp"
                                      ui:width="100%"
                                      ui:height="320px"
                                      ui:position="center"
                                      ui:size="contain"></ui-image>

                            <p>
                                ${locale.home_promo_newsletter_info} <a ui-navigate href="/policy">${locale.home_promo_newsletter_info_link}</a>.
                            </p>

                            <form>
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" placeholder="${locale.home_promo_newsletter_mail}">
                                    <button class="btn btn-secondary" type="button">
                                        <span class="mdi mdi-24px mdi-chevron-right"></span>
                                    </button>
                                </div>
                            </form>

                        </div>

                    </div>

                </div>

            </section>


        </section>


    </section>

    <!-- Footer -->
    <ui-footer id="ui-footer" ui:current="home"> </ui-footer>

</section>



