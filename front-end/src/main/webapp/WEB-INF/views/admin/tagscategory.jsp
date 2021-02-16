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
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include  file="modal.jsp" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>BioAgri | Dashboard</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/assets/admin/plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/assets/admin/css/adminlte.min.css">
  <!-- summernote -->
  <link rel="stylesheet" href="/assets/admin/plugins/summernote/summernote-bs4.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <!-- Summernote -->
  <script src="/assets/admin/plugins/summernote/summernote-bs4.min.js"></script>
  <!-- AdminLTE App -->
  <script src="/assets/admin/js/adminlte.js"></script>
  <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
  <script src="/assets/admin/js/tagscategory.js"></script>

</head>


<body class="hold-transition sidebar-mini layout-fixed">



<div class="wrapper">
  <!-- Navbar -->
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
      <li class="nav-item d-none d-sm-inline-block">
        <a href="#" class="nav-link">Contact</a>
      </li>
    </ul>

    <!-- SEARCH FORM -->
    <form class="form-inline ml-3">
      <div class="input-group input-group-sm">
        <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
        <div class="input-group-append">
          <button class="btn btn-navbar" type="submit">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
    </form>
  </nav>
  <!-- /.navbar -->
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="" class="brand-link">
      <img src="/assets/admin/img/logo/logo.webp" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">BioAgri</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="/assets/admin/img/owner.webp" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">Salvatore Crisafulli</a>
        </div>
      </div>
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
 with font-awesome or any other icon font library -->
          <li class="nav-item has-treeview menu-open">
            <a href="dashboard" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
              </p>
            </a>
          </li>
          </li>
          <li class="nav-item has-treeview">
            <a href="" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>
                catalog
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item ml-2">
                <a href="product" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>product</p>
                </a>
              </li>
              <li class="nav-item ml-2">
                <a href="tagscategory" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>tags and category</p>
                </a>
              </li>
            </ul>
          <li class="nav-item">
            <a href="orders" class="nav-link">
              <i class="nav-icon fas fa-clipboard-list"></i>
              <p>
                orders
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="feedbacks" class="nav-link">
              <i class="nav-icon fas fa-star"></i>
              <p>
                feedbacks
              </p>
            </a>
          </li>
          </li>
          </li>
          </li>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
    </div>
    <!-- /.content-header -->
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row d-flex justify-content-center">
          <div class="col-md-6">
            <!-- /.card -->
            <div class="card">
              <div class="card-header border-transparent">
                <h3 class="card-title">Categories</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0">

                <div class="table-responsive">
                  <table class="table m-0">
                    <thead>
                    <tr class="text-center">
                      <th>id</th>
                      <th>name</th>
                      <th>edit</th>
                    </tr>
                    </thead>
                    <tbody class="text-center">
                    <c:forEach var="category" items="${categories}">
                      <tr>
                        <td>${category.id}</td>
                        <td>${category.name}</td>
                        <td>
                          <button onclick="editCategorymodal()" type="button" class="btn btn-primary" data-toggle="modal" data-target="#editCategoryModal" data-whatever="${category.id}">
                            <i class="fas fa-pencil-alt"></i>
                          </button>
                        </td>
                      </tr>
                    </c:forEach>
                    </tbody>
                  </table>
                </div>
                <!-- /.table-responsive -->
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">

                <button style="float:right;" type="button" class="btn btn-success" data-toggle="modal" data-target="#addCategoryModal">
                  add
                </button>

              </div>
              <!-- /.card-footer -->
            </div>
            <!-- /.card -->

            <!-- /.card -->
            <div class="card">
              <div class="card-header border-transparent">
                <h3 class="card-title">Tags</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0">

                <div class="table-responsive">
                  <table class="table m-0">
                    <thead>
                    <tr class="text-center">
                      <th>id</th>
                      <th>name</th>
                      <th>edit</th>
                    </tr>
                    </thead>
                    <tbody class="text-center">
                    <c:forEach var="tag" items="${tags}">
                      <tr>
                        <td>${tag.id}</td>
                        <td>${tag.hashtag}</td>
                        <td>
                          <button onclick="editTagModal()" type="button" class="btn btn-primary" data-toggle="modal" data-target="#editTagModal" data-whatever="${tag.id}">
                            <i class="fas fa-pencil-alt"></i>
                          </button>
                        </td>
                      </tr>
                    </c:forEach>
                    </tbody>
                  </table>
                </div>
                <!-- /.table-responsive -->
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">

                <button style="float:right;" type="button" class="btn btn-success" data-toggle="modal" data-target="#addTagsModal">
                  add
                </button>
                <!-- Modal -->
              </div>
              <!-- /.card-footer -->
            </div>
            <!-- /.card -->

          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
    </section>
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <strong>Copyright &copy; <a href="http://adminlte.io">Bioagri Shop</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
    </div>
  </footer>
  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>

</body>

</html>