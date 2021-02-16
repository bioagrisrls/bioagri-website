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
                    <div class="col-md-12">

                        <div class="card">
                            <div class="card-header border-transparent">
                                <h3 class="card-title">Latest Orders</h3>

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
                                            <th style="min-width:100px;">Order ID</th>
                                            <th>Item</th>
                                            <th>Status</th>
                                            <th>address</th>
                                            <th>City</th>
                                            <th>province</th>
                                            <th>zip</th>
                                            <th>Transaction id</th>
                                            <th>Transaction type</th>
                                            <th>shipment number</th>
                                            <th>invoice</th>
                                            <th>additional info</th>
                                        </tr>
                                        </thead>
                                        <tbody class="text-center">
                                        <tr>
                                            <td><a href="invoice">OR9842</a></td>
                                            <td>Call of Duty IV</td>
                                            <td><span class="badge badge-success">Shipped</span></td>
                                            <td>
                                                <div style="min-width:80px;" class="sparkbar" data-color="#00a65a" data-height="20">non via via,90</div>
                                            </td>
                                            <td>Rosarno</td>
                                            <td>RC</td>
                                            <td>8900</td>
                                            <td>72365102391238347</td>
                                            <td>Pypal</td>
                                            <td>3423534</td>
                                            <td><a>link</a></td>
                                            <td>scala A piano 3</td>
                                        </tr>
                                        <tr>
                                            <td><a href="invoice">OR7429</a></td>
                                            <td>iPhone 6 Plus</td>
                                            <td><span class="badge badge-danger">Delivered</span></td>
                                            <td>
                                                <div class="sparkbar" data-color="#f56954" data-height="20">via senza mani, 88</div>
                                            </td>
                                            <td>Gioia Tauro</td>
                                            <td>RC</td>
                                            <td>8900</td>
                                            <td>72365102391238347</td>
                                            <td>Pypal</td>
                                            <td>3423534</td>
                                            <td><a>link</a></td>
                                            <td>scala A piano 3</td>
                                        </tr>
                                        <tr>
                                            <td><a href="invoice">OR7429</a></td>
                                            <td>Samsung Smart TV</td>
                                            <td><span class="badge badge-info">Processing</span></td>
                                            <td>
                                                <div class="sparkbar" data-color="#00c0ef" data-height="20">via senza nome, 57 </div>
                                            </td>
                                            <td>Polistena</td>
                                            <td>RC</td>
                                            <td>8900</td>
                                            <td>72365102391238347</td>
                                            <td>Pypal</td>
                                            <td>3423534</td>
                                            <td><a>link</a></td>
                                            <td>scala A piano 3</td>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.table-responsive -->
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix">
                            </div>
                            <!-- /.card-footer -->
                        </div>
                        <!-- /.card -->
                        <!-- /.card -->
                        <div class="card">
                            <div class="card-header border-transparent">
                                <h3 class="card-title">Pending Orders</h3>

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
                                            <th style="min-width:100px;">Order ID</th>
                                            <th>Item</th>
                                            <th>Status</th>
                                            <th>address</th>
                                            <th>City</th>
                                            <th>province</th>
                                            <th>zip</th>
                                            <th>Transaction id</th>
                                            <th>Transaction type</th>
                                            <th>shipment number</th>
                                            <th>invoice</th>
                                            <th>additional info</th>
                                            <th class="px-5">send</th>
                                        </tr>
                                        </thead>
                                        <tbody class="text-center">
                                        <tr>
                                            <td><a href="invoice">OR9842</a></td>
                                            <td>Call of Duty IV</td>
                                            <td><span class="badge badge-warning">Pending</span></td>
                                            <td>
                                                <div style="min-width:80px;" class="sparkbar" data-color="#00a65a" data-height="20">non via via,90</div>
                                            </td>
                                            <td>Rosarno</td>
                                            <td>RC</td>
                                            <td>8900</td>
                                            <td>72365102391238347</td>
                                            <td>Pypal</td>
                                            <td>3423534</td>
                                            <td><a>link</a></td>
                                            <td>scala A piano 3</td>
                                            <td class="px-5">
                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModal">
                                                    send
                                                </button>
                                                <!-- Modal -->
                                                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Send</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <label class="col-form-label">inserisci codice spedizione</label>
                                                                <input type="text" class="form-control">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="button" class="btn btn-success">Save changes</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><a href="invoice">OR1848</a></td>
                                            <td>Samsung Smart TV</td>
                                            <td><span class="badge badge-warning">Pending</span></td>
                                            <td>
                                                <div class="sparkbar" data-color="#f39c12" data-height="20">via senza via, 34</div>
                                            </td>
                                            <td>Rizziconi</td>
                                            <td>RC</td>
                                            <td>8900</td>
                                            <td>72365102391238347</td>
                                            <td>Pypal</td>
                                            <td>3423534</td>
                                            <td><a>link</a></td>
                                            <td>scala A piano 3</td>
                                            <td class="px-5">
                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModal">
                                                    send
                                                </button>
                                                <!-- Modal -->
                                                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Send</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <label class="col-form-label">inserisci codice spedizione</label>
                                                                <input type="text" class="form-control">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="button" class="btn btn-success">Save changes</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><a href="invoice">OR7429</a></td>
                                            <td>iPhone 6 Plus</td>
                                            <td><span class="badge badge-warning">Pending</span></td>
                                            <td>
                                                <div class="sparkbar" data-color="#f56954" data-height="20">via senza mani, 88</div>
                                            </td>
                                            <td>Gioia Tauro</td>
                                            <td>RC</td>
                                            <td>8900</td>
                                            <td>72365102391238347</td>
                                            <td>Pypal</td>
                                            <td>3423534</td>
                                            <td><a>link</a></td>
                                            <td>scala A piano 3</td>
                                            <td class="px-5">
                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModal">
                                                    send
                                                </button>
                                                <!-- Modal -->
                                                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Send</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <label class="col-form-label">inserisci codice spedizione</label>
                                                                <input type="text" class="form-control">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="button" class="btn btn-success">Save changes</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><a href="invoice">OR7429</a></td>
                                            <td>Samsung Smart TV</td>
                                            <td><span class="badge badge-warning">Pending</span></td>
                                            <td>
                                                <div class="sparkbar" data-color="#00c0ef" data-height="20">via senza nome, 57 </div>
                                            </td>
                                            <td>Polistena</td>
                                            <td>RC</td>
                                            <td>8900</td>
                                            <td>72365102391238347</td>
                                            <td>Pypal</td>
                                            <td>3423534</td>
                                            <td><a>link</a></td>
                                            <td>scala A piano 3</td>
                                            <td class="px-5">
                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModal">
                                                    send
                                                </button>
                                                <!-- Modal -->
                                                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Send</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <label class="col-form-label">inserisci codice spedizione</label>
                                                                <input type="text" class="form-control">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="button" class="btn btn-success">Save changes</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.table-responsive -->
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer clearfix">
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
<!-- ./wrapper -->
<!-- jQuery -->
<script src="/assets/admin/plugins/jquery/jquery.min.js"></script>
<script>
    $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="/assets/admin/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Summernote -->
<script src="/assets/admin/plugins/summernote/summernote-bs4.min.js"></script>
<!-- AdminLTE App -->
<script src="/assets/admin/js/adminlte.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="/assets/admin/js/pages/dashboard.js"></script>
</body>

</html>