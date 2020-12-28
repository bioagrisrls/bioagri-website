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

<jsp:include page="/WEB-INF/components/products/details/details.controller.jsp" />

<section id="ui-navigation-container" ui-title="${locale.info_title}">


    <div class="container ui-container">
        <div class="row">
            <div class="col-8 item-photo">
                <img  src="https://agribiositaliana.it/wp-content/uploads/2017/07/Solfato-Ferroso.png" />
            </div>
            <div class="col-4" >
                <!-- Datos del vendedor y titulo del producto -->
                <h3>Samsung Galaxy S4 I337 16GB 4G LTE Unlocked GSM Android Cell Phone</h3>
                <h5 >vendido por <a href="#">Samsung</a> · <small>(5054 ventas)</small></h5>

                <!-- Precios -->
                <h6 class="title-price"><small>PRECIO OFERTA</small></h6>
                <h3>U$S 399</h3>

                <!-- Detalles especificos del producto -->
                <div class="section">
                    <h6 class="title-attr" style="margin-top:15px;" ><small>COLOR</small></h6>
                    <div>
                        <div class="attr" ></div>
                        <div class="attr" ></div>
                    </div>
                </div>
                <div class="section">
                    <h6 class="title-attr"><small>CAPACIDAD</small></h6>
                    <div>
                        <div class="attr2">16 GB</div>
                        <div class="attr2">32 GB</div>
                    </div>
                </div>
                <div class="section">
                    <h6 class="title-attr"><small>CANTIDAD</small></h6>
                    <div>
                        <div class="btn-minus"><span class="glyphicon glyphicon-minus"></span></div>
                        <input value="1" />
                        <div class="btn-plus"><span class="glyphicon glyphicon-plus"></span></div>
                    </div>
                </div>

                <!-- Botones de compra -->
                <div class="section">
                    <button class="btn btn-success"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> Agregar al carro</button>
                    <h6><a href="#"><span class="glyphicon glyphicon-heart-empty" ></span> Agregar a lista de deseos</a></h6>
                </div>
            </div>
        </div>

        <div class = "row text-center pt-5">

                <div class="col-4">
                    <a class="ui-active">dettagli prodotto</a>
                </div>

                <div class="col-4">
                    <a class="ui-active">recensioni</a>
                </div>

                <div class="col-4">
                    <a class="ui-active">spedizione</a>
                </div>
        </div>

    </div>

</section>