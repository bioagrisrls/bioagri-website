<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>products</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/assets/admin/plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/assets/admin/css/adminlte.min.css">
    <!-- summernote -->
    <link rel="stylesheet" href="/assets/admin/plugins/summernote/summernote-bs4.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="/assets/admin/css/input.css">
</head>


<body class="hold-transition sidebar-mini layout-fixed">



<div class="wrapper">

    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="dashboard" class="nav-link">Home</a>
            </li>
        </ul>

    </nav>
    <!-- /.navbar -->

    <%@include  file="sidebar.jsp" %>

    <div class="row d-flex justify-content-center py-5 pl-5">
        <div class="col-6">
            <div class="card card-success">
                <div class="card-header">
                    <h3 class="card-title">Carica Prodotto</h3>
                </div>
                <!-- /.card-header -->
                <!-- form start -->
                <form action="/admin/update/product" method="post">
                    <input value = "${productData.id}"  type="hidden" class="form-control" name="id">
                    <div class="card-body">
                        <div class="form-group">
                            <label>Nome</label>
                            <input value = "${productData.name}" class="form-control" name="name" placeholder="nome prodotto">
                        </div>
                        <div class="form-group">
                            <label>Prezzo</label>
                            <input value = "${productData.price}" class="form-control" name="price" placeholder="prezzo">
                        </div>
                        <div class="form-group">
                            <label>Giacenza</label>
                            <input value = "${productData.stock}"class="form-control" name="stock" placeholder="giacenza">
                        </div>
                        <div class="form-group">
                            <label>Categoria</label>
                            <div class="overflow-auto" style = "height:120px;" >
                                <c:forEach var="category" items="${categories}">
                                    <c:choose>
                                        <c:when test = "${fn:contains(productCategories, category.name)}">
                                            <input checked type="checkbox" id = "category" name="category" value="${category.id}">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" id = "category" name="category" value="${category.id}">
                                        </c:otherwise>
                                    </c:choose>
                                    <label for="category">${category.name}</label><br>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Tag</label>
                            <div>
                                <div class="overflow-auto" style = "height:120px;" >
                                    <c:forEach var="tag" items="${tags}">
                                        <c:choose>
                                            <c:when test = "${fn:contains(productTags, tag.hashtag)}">
                                                <input checked type="checkbox" id = "tag" name="tag" value="${tag.id}">
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" id = "tag" name="tag" value="${tag.id}">
                                            </c:otherwise>
                                        </c:choose>
                                        <label for="tag">${tag.hashtag}</label><br>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Descrizione Breve</label>
                            <input value = "${productData.info}" class="form-control" name="info" placeholder="Descrizione Breve">
                        </div>
                        <div class="form-group">
                            <label>Sconto</label>
                            <input value = "${productData.discount}" class="form-control" name="discount" placeholder="Sconto">
                        </div>

                        <div class="form-group">
                            <label>Stato</label>
                            <div>
                                <select class="form-control" name="status">
                                    <option value="AVAILABLE">DISPONIBILE</option>
                                    <option value="NOT_AVAILABLE">NON DISPONIBILE</option>
                                    <option value="AVAILABLE_SOON">DISPONIBILE A BREVE</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputFile">File</label>
                            <div class="input-group">
                                <div class="custom-file">
                                    <input name = "files" type="file" multiple class="custom-file-input"  accept=".jpg, .jpeg, .png" id="exampleInputFile">
                                    <label class="custom-file-label" for="exampleInputFile">Scegli File</label>
                                </div>
                                <div class="input-group-append">
                                    <span class="input-group-text" id="">Carica</span>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="form-group">
                            <textarea id="compose-textarea" name="description" class="form-control"></textarea>
                        </div>
                    </div>
                    <!-- /.card-body -->
                    <div class="card-footer float-right">
                        <button type="submit" class="btn btn-primary">Aggiorna</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
    <!-- /.card -->

    <!-- /.content -->
</div>
<!-- /.content-wrapper -->
<footer class="main-footer">
    <strong>Copyright &copy; <a href="http://adminlte.io">Bioagri Shop</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
    </div>
</footer>

</div>

<!-- jQuery -->
<script src="/assets/admin/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/assets/admin/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/assets/admin/js/adminlte.min.js"></script>
<!-- Summernote -->
<script src="/assets/admin/plugins/summernote/summernote-bs4.min.js"></script>
<!-- Page Script -->
<script>
    $(function() {
        $('#compose-textarea').summernote('code', `${productData.description}`);
    })
</script>

</body>

</html>