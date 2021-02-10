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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-tagsinput/0.8.0/bootstrap-tagsinput.css" integrity="sha512-xmGTNt20S0t62wHLmQec2DauG9T+owP9e6VU8GigI0anN7OXLip9i7IwEhelasml2osdxX71XcYm6BQunTQeQg==" crossorigin="anonymous" />

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
        <!-- Brand Logo -->
        <a href="" class="brand-link">
            <img src="/assets/admin/img/logo/logo.webp" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
                 style="opacity: .8">
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
                                <a href="category" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>category</p>
                                </a>
                            </li>
                            <li class="nav-item ml-2">
                                <a href="tags" class="nav-link">
                                    <i class="fas fa-tags nav-icon"></i>
                                    <p>tags</p>
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

    <div class = "row d-flex justify-content-center py-5 pl-5">

        <div class = "col-6">
            <div class="card card-success">
                <div class="card-header">
                    <h3 class="card-title">Carica Prodotto</h3>
                </div>
                <!-- /.card-header -->
                <!-- form start -->
                <form action="/admin/create/product" method="post">
                    <div class="card-body">
                        <div class="form-group">
                            <label>Nome</label>
                            <input class="form-control"  name="name" placeholder="nome prodotto">
                        </div>
                        <div class="form-group">
                            <label>Prezzo</label>
                            <input class="form-control" name="price" placeholder="prezzo">
                        </div>
                        <div class="form-group">
                            <label>Giacenza</label>
                            <input class="form-control"  name="stock" placeholder="giacenza">
                        </div>
                        <div class="form-group">
                            <label>category</label>
                            <div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Tag</label>
                            <input class="form-control"  name="tag" placeholder="Tag">
                        </div>
                        <div class="form-group">
                            <label>info</label>
                            <input class="form-control"  name="info" placeholder="info">
                        </div>
                        <div class="form-group">
                            <label>discount</label>
                            <input class="form-control"  name="discount" placeholder="discount">
                        </div>

                        <div class="form-group">
                            <label>Status</label>
                            <div>
                                <select class="form-control" name="status">
                                    <option value="AVAILABLE">DISPONIBILE</option>
                                    <option value="NOT_AVAILABLE">NON DISPONIBILE</option>
                                    <option value="AVAILABLE_SOON">DISPONIBILE A BREVE</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputFile">File input</label>
                            <div class="input-group">
                                <div class="custom-file">
                                    <input type="file" multiple class="custom-file-input" id="exampleInputFile">
                                    <label class="custom-file-label" for="exampleInputFile">Choose file</label>
                                </div>
                                <div class="input-group-append">
                                    <span class="input-group-text" id="">Upload</span>
                                </div>
                            </div>
                        </div>
                            <hr>
                            <div class="form-group">
                                <textarea id="compose-textarea" name="description" class="form-control"></textarea>
                            </div>
                    </div>
                    <!-- /.card-body -->
                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary">Submit</button>
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
    <strong>Copyright &copy;  <a href="http://adminlte.io">Bioagri Shop</a>.</strong>
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
<!-- ./wrapper -->
<script src="../js/bootstrap-tagsinput.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-tagsinput/0.8.0/bootstrap-tagsinput.js" integrity="sha512-VvWznBcyBJK71YKEKDMpZ0pCVxjNuKwApp4zLF3ul+CiflQi6aIJR+aZCP/qWsoFBA28avL5T5HA+RE+zrGQYg==" crossorigin="anonymous"></script>

<script>
    $(function () {
        //Add text editor
        $('#compose-textarea').summernote()
    })
</script>

</body>
</html>