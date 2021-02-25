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
    <!-- jQuery -->
    <script src="/assets/admin/plugins/jquery/jquery.min.js"></script>

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
    <%@include  file="sidebar.jsp" %>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Ordini</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="dashboard">Home</a></li>
                            <li class="breadcrumb-item active">Ordini</li>
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div>
        </div>
        <!-- /.content-header -->
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row d-flex justify-content-center">
                    <div class="col-md-12">

                        <div class="card">
                            <div class="card-header border-transparent">
                                <h3 class="card-title">Ultimi Ordini</h3>

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
                                            <th style="min-width:100px;">ID ordine</th>
                                            <th>Nome</th>
                                            <th>Stato</th>
                                            <th>Indirizzo</th>
                                            <th>Citt&agrave</th>
                                            <th>Provincia</th>
                                            <th>CAP</th>
                                            <th>Id Transazione</th>
                                            <th>Tipo Transazione</th>
                                            <th>Numero Spedizione</th>
                                            <th>Info Aggiuntive</th>
                                        </tr>
                                        </thead>
                                        <tbody class="text-center">

                                        <c:forEach var="order" items="${orders}">
                                        <tr>

                                            <td><p>${order.order.id}</p></td>
                                            <td>${order.item}</td>
                                            <c:if test="${order.order.status == 'PROCESSING'}">
                                                <td><span class="badge badge-info">Elaborazione</span></td>
                                            </c:if>
                                            <c:if test="${order.order.status == 'SENT'}">
                                                <td><span class="badge badge-primary">Spedito</span></td>
                                            </c:if>
                                            <c:if test="${order.order.status == 'RECEIVED'}">
                                                <td><span class="badge badge-success">Consegnato</span></td>
                                            </c:if>
                                            <c:if test="${order.order.status == 'ABORTED'}">
                                                <td><span class="badge badge-danger">Annullato</span></td>
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
                                <h3 class="card-title">Ordini in Attesa</h3>

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
                                            <th style="min-width:100px;">ID ordine</th>
                                            <th>Nome</th>
                                            <th>Stato</th>
                                            <th>Indirizzo</th>
                                            <th>Citt&agrave</th>
                                            <th>Provincia</th>
                                            <th>CAP</th>
                                            <th>Id Transazione</th>
                                            <th>Tipo Transazione</th>
                                            <th>Numero Spedizione</th>
                                            <th>Info Aggiuntive</th>
                                            <th class="px-5">Invia</th>
                                        </tr>
                                        </thead>
                                        <tbody class="text-center">
                                        <c:forEach var = "pendingOrder" items="${pendingOrders}">
                                        <tr>
                                            <td><p>${pendingOrder.order.id}</p></td>
                                            <td>${pendingOrder.item}</td>
                                            <td><span class="badge badge-warning">Attesa</span></td>
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
                                            <td><button onclick="addShipmentNumber()" type="button" class="btn btn-success" data-whatever="${pendingOrder.order.id}" data-toggle="modal" data-target="#orderModal">Invia</button></td>
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