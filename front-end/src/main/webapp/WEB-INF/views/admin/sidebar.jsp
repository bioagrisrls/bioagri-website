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

<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <div class="brand-link">
        <img src="/assets/admin/img/logo/logo.webp"  class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">BioAgri</span>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <img src="/assets/admin/img/owner.webp" class="img-circle elevation-2" alt="User Image">
            </div>
            <div class="info">
                <p class="text-white">Salvatore Crisafulli</p>
            </div>
        </div>
        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Add icons to the links using the .nav-icon class
                 with font-awesome or any other icon font library -->
                <li class="nav-item has-treeview">
                    <a href="/admin/dashboard" id = "dashboard" class="nav-link">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>
                            Dashboard
                        </p>
                    </a>
                </li>
                </li>
                <li id = "addMenu" class="nav-item has-treeview">
                    <a href="" id = "add" class="nav-link">
                        <i class="nav-icon fas fa-plus-circle"></i>
                        <p>
                            Aggiungi
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item ml-2">
                            <a href="/admin/product" id = "product" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Prodotto</p>
                            </a>
                        </li>
                        <li class="nav-item ml-2">
                            <a href="/admin/tagscategory" id = "tagscategory" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Tag e Categorie</p>
                            </a>
                        </li>
                    </ul>
                <li class="nav-item">
                    <a href="/admin/catalog" id = "catalog" class="nav-link">
                        <i class="nav-icon fas fa-edit"></i>
                        <p>
                            Catalogo
                        </p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/admin/orders" id = "orders" class="nav-link">
                        <i class="nav-icon fas fa-clipboard-list"></i>
                        <p>
                            Ordini
                        </p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/admin/feedbacks" id = "feedbacks" class="nav-link">
                        <i class="nav-icon fas fa-star"></i>
                        <p>
                            Feedback
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

<script>

    $(document).ready(

        function (){

            var pathname = window.location.pathname.split('/admin/')[1];

            $('#'+pathname).addClass('active');

            if(pathname === 'tagscategory' || pathname === 'product')
                $('#addMenu').addClass('menu-open');


        }

    )

</script>