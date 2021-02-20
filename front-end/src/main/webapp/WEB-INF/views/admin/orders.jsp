<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@include  file="orderModal.jsp" %>
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
        </ul>
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
                    <li class="nav-item has-treeview">
                        <a href="dashboard" class="nav-link">
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
                        <a href="orders" class="nav-link active">
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
                                            <th>additional info</th>
                                        </tr>
                                        </thead>
                                        <tbody class="text-center">

                                        <c:forEach var="order" items="${orders}">
                                        <tr>

                                            <td><a href="invoice">${order.order.id}</a></td>
                                            <td>${order.item}</td>
                                            <c:if test="${order.order.status == 'PROCESSING'}">
                                                <td><span class="badge badge-info">Processing</span></td>
                                            </c:if>
                                            <c:if test="${order.order.status == 'SENT'}">
                                                <td><span class="badge badge-primary">Shipped</span></td>
                                            </c:if>
                                            <c:if test="${order.order.status == 'RECEIVED'}">
                                                <td><span class="badge badge-success">Delivered</span></td>
                                            </c:if>
                                            <c:if test="${order.order.status == 'ABORTED'}">
                                                <td><span class="badge badge-danger">Aborted</span></td>
                                            </c:if>

                                            <td><div class="sparkbar" data-color="#00a65a" data-height="20">
                                                    ${fn:replace(fn:replace(order.order.address, 'null,', ''),'null', '')}
                                                </div>
                                            </td>
                                            <td>${order.order.city}</td>
                                            <td>${order.order.province}</td>
                                            <td>${order.order.zip}</td>
                                            <td>${order.order.transactionId}</td>
                                            <td>${order.order.transactionType}</td>
                                            <td>${order.order.shipmentNumber}</td>
                                            <td>${order.order.additionalInfo}</td>
                                        </tr>
                                        </c:forEach>
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
                                            <th>additional info</th>
                                            <th class="px-5">send</th>
                                        </tr>
                                        </thead>
                                        <tbody class="text-center">
                                        <c:forEach var = "pendingOrder" items="${pendingOrders}">
                                        <tr>
                                            <td><a href="invoice">${pendingOrder.order.id}</a></td>
                                            <td>${pendingOrder.item}</td>
                                            <td><span class="badge badge-warning">Pending</span></td>
                                            <td>
                                                <div class="sparkbar" data-color="#00a65a" data-height="20">
                                                    ${fn:replace(fn:replace(pendingOrder.order.address, 'null,', ''),'null', '')}
                                                </div>
                                            </td>
                                            <td>${pendingOrder.order.city}</td>
                                            <td>${pendingOrder.order.province}</td>
                                            <td>${pendingOrder.order.zip}</td>
                                            <td>${pendingOrder.order.transactionId}</td>
                                            <td>${pendingOrder.order.transactionType}</td>
                                            <td>${pendingOrder.order.shipmentNumber}</td>
                                            <td>${pendingOrder.order.additionalInfo}</td>
                                            <td><button onclick="addShipmentNumber()" type="button" class="btn btn-success" data-whatever="${pendingOrder.order.id}" data-toggle="modal" data-target="#orderModal">send</button></td>
                                        </tr>
                                        </c:forEach>
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
</body>

</html>