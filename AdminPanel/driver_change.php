<!--
=========================================================
 Material Dashboard - v2.1.1
=========================================================

 Product Page: https://www.creative-tim.com/product/material-dashboard
 Copyright 2019 Creative Tim (https://www.creative-tim.com)
 Licensed under MIT (https://github.com/creativetimofficial/material-dashboard/blob/master/LICENSE.md)

 Coded by Creative Tim

=========================================================

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. -->

<!DOCTYPE html>
<html lang="en">
<?php
session_start();
$uid = $_SESSION['uid'];
require_once 'vendor/autoload.php';

use Google\Cloud\Firestore\FirestoreClient;
use Google\Cloud\Storage\StorageClient;
?>
<!-- <%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%> -->

<head>
    <meta charset="utf-8" />
    <link rel="shortcut icon" href="img/LOGO.jfif" type="image/x-icon" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>
        Admin Bus Stop
    </title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
    <!-- CSS Files -->
    <link href="assets/css/material-dashboard.css?v=2.1.1" rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="assets/demo/demo.css" rel="stylesheet" />
    <script langusage="javascript">
        window.history.forward(1);
        browser.cache.offline.enable = false;

        function noBack() {
            window.history.forward(1);
            location.replace("index.jsp");
        }
        self.close()
    </script>
</head>


<body class="">
    <div class="wrapper ">
        <div class="sidebar" data-color="purple" data-background-color="white" data-image="assets/img/sidebar-1.jpg">
            <!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | azure | green | orange | danger"

        Tip 2: you can also add an image using data-image tag
    -->
            <div class="logo">
                <a href="index.jsp" class="simple-text logo-normal">
                    Bus Stop
                </a>
            </div>
            <div class="sidebar-wrapper">
                <ul class="nav">
                    <?php if ($uid == "master_admin") { ?>
                        <li class="nav-item   ">
                            <a class="nav-link" href="register_local_admin.php">
                                <i class="material-icons">person</i>
                                <p>REGISTER LOCAL ADMIN</p>
                            </a>
                        </li>
                    <?php } ?>

                    <li class="nav-item  ">
                        <a class="nav-link" href="bus_stop.php">
                            <i class="material-icons">dashboard</i>
                            <p>ADD STOP</p>
                        </a>
                    </li>
                    <li class="nav-item   ">
                        <a class="nav-link" href="update_&_del_stops.php">
                            <i class="material-icons">edit</i>
                            <p>EDIT STOPS</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="bus_insert.php">
                            <i class="material-icons">directions_bus</i>
                            <p>ADD BUS</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="buses.php">
                            <i class="material-icons">content_paste</i>
                            <p>BUSSES</p>
                        </a>
                    </li>
                    <li class="nav-item   ">
                        <a class="nav-link" href="edit_bus.php">
                            <i class="material-icons">library_books</i>
                            <p>EDIT BUS ROUTES</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="driver_insert.php">
                            <i class="material-icons">bubble_chart</i>
                            <p>ADD DRIVERS</p>
                        </a>
                    </li>
                    <li class="nav-item active  ">
                        <a class="nav-link" href="driver_change.php">
                            <i class="material-icons">loop</i>
                            <p>CHANGE DRIVER</p>
                        </a>
                    </li>
                    <li class="nav-item   ">
                        <a class="nav-link" href="emergency.php">
                            <i class="material-icons">Emergency</i>
                            <p>EMERGENCY</p>
                        </a>
                    </li>
                    <li class="nav-item   ">
                        <a class="nav-link" href="logout.php">
                            <i class="material-icons">logout</i>
                            <p>LOGOUT</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="main-panel">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top ">
                <div class="container-fluid">

                    <button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="navbar-toggler-icon icon-bar"></span>
                        <span class="navbar-toggler-icon icon-bar"></span>
                        <span class="navbar-toggler-icon icon-bar"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end">
                        <form class="navbar-form">
                            <div class="input-group no-border">
                                <input type="text" value="" class="form-control" placeholder="Search...">
                                <button type="submit" class="btn btn-white btn-round btn-just-icon">
                                    <i class="material-icons">search</i>
                                    <div class="ripple-container"></div>
                                </button>
                            </div>
                        </form>
                        <ul class="navbar-nav">


                            <li class="nav-item dropdown">
                                <a class="nav-link" href="#pablo" id="navbarDropdownProfile" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="material-icons">person</i>
                                    <p class="d-lg-none d-md-block">
                                        Account
                                    </p>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownProfile">
                                    <a class="dropdown-item" href="#">Profile</a>
                                    <a class="dropdown-item" href="#">Settings</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="index.jsp" onclick="noBack(); return false;">Logout</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <!-- End Navbar -->
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header card-header-primary">
                                    <h4 class="card-title">CHANGE DRIVERS</h4>
                                    <p class="card-category">Select Driver</p>
                                </div>
                                <?php
                                $City = array();
                                $config = [
                                    'keyFilePath' => 'chale chalo-cf56f051c62b.json',
                                    'projectId' => 'chale-chalo',
                                ];
                                // Create the Cloud Firestore client
                                $db = new FirestoreClient($config);

                                $CityRef = $db->collection('City')->document('City');
                                $snapshot = $CityRef->snapshot();
                                if ($snapshot->exists()) {
                                    $c = $snapshot->get('AllCity');
                                }
                                foreach ($c as $C) {
                                    array_push($City, $C);
                                }
                                ?>
                                <form method="post">
                                    <div class="col-md-3">
                                        <select id="City" class="form-control" name="city">
                                            <option>Choose City</option>
                                            <?php foreach ($City as $d) {
                                            ?>
                                                <option><?php echo $d; ?></option>
                                            <?php }
                                            ?>

                                        </select>
                                        <button type="submit" class="btn btn-primary" name="post">Submit</button>
                                    </div>
                                </form>
                                <div class="card-body">
                                    <form action="edit_driver.php" method="post">
                                        <div class="row">
                                            <?php

                                            if ($_SERVER["REQUEST_METHOD"] == "POST") {
                                                $b = array();
                                                $city = $_POST['city'];
                                                $c = $city . "Bus";
                                                $config = [
                                                    'keyFilePath' => 'chale chalo-cf56f051c62b.json',
                                                    'projectId' => 'chale-chalo',
                                                ];       // Create the Cloud Firestore client
                                                $db = new FirestoreClient($config);
                                                $BusRef = $db->collection($c)->documents();
                                                foreach ($BusRef as $S) {
                                                    array_push($b, $S->id());
                                                }
                                            }
                                            ?>
                                            <select class="form-control" name="bus_no">
                                                <option>Bus No.</option>
                                                <option>None</option>
                                                <?php foreach ($b as $d) {
                                                ?>
                                                    <option><?php echo $d; ?></option>
                                                <?php } ?>
                                            </select>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Name</label>
                                                    <input type="text" class="form-control" name="driver" id="name" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Email</label>
                                                    <input type="text" class="form-control" name="email" id="email" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Password</label>
                                                    <input type="text" class="form-control" name="password" id="password" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Adhaar No.</label>
                                                    <input type="text" class="form-control" name="adhaar" id="adhaar" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">License No.</label>
                                                    <input type="text" class="form-control" name="license" id="license" required>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Address</label>
                                                    <input type="text" class="form-control" name="add" id="add" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">City</label>
                                                    <input type="text" class="form-control" name="driver_city" id="driver_city" required>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Country</label>
                                                    <input type="text" class="form-control" name="country" id="country" required>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="bmd-label-floating">Contact No.</label>
                                                    <input type="text" class="form-control" name="contact" id="contact" required>
                                                </div>
                                            </div>
                                        </div>
                                        <a class="btn btn-primary pull-right" href="driver_insert.php">Add New Driver</a>
                                        <button type="submit" class="btn btn-primary pull-right" name="post">Change</button>
                                        <div class="clearfix"></div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header card-header-primary">
                                    <h4 class="card-title ">SPARE DRIVERS</h4>
                                    <p class="card-category">Driver Details</p>
                                </div>

                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table" id="table">

                                            <thead class=" text-primary">
                                                <th>
                                                    Name
                                                </th>
                                                <th>
                                                    Adhaar No.
                                                </th>
                                                <th>
                                                    License No.
                                                </th>
                                                <th>
                                                    Address
                                                </th>
                                                <th>
                                                    City
                                                </th>
                                                <th>
                                                    Country
                                                </th>
                                                <th>
                                                    Contact
                                                </th>
                                                <th>
                                                    Email
                                                </th>
                                                <th style="display:none;">
                                                    Password
                                                </th>
                                            </thead>
                                            <tbody>
                                                <?php

                                                $config = [
                                                    'keyFilePath' => 'chale chalo-cf56f051c62b.json',
                                                    'projectId' => 'chale-chalo',
                                                ];
                                                // Create the Cloud Firestore client
                                                $db = new FirestoreClient($config);

                                                $driverRef = $db->collection('Drivers');
                                                $query = $driverRef->where('BusNumber', '=', 'None');
                                                $snapshot = $query->documents();
                                                foreach ($snapshot as $driver) {
                                                ?>
                                                    <tr>
                                                        <td><?php echo $driver["name"]; ?></td>
                                                        <td><?php echo $driver["adhaar"]; ?></td>
                                                        <td><?php echo $driver['license_no']; ?></td>
                                                        <td><?php echo $driver["add"]; ?></td>
                                                        <td><?php echo $driver["city"]; ?></td>
                                                        <td><?php echo $driver['country']; ?></td>
                                                        <td><?php echo $driver['contact']; ?></td>
                                                        <td><?php echo $driver['email']; ?></td>
                                                        <td style="display:none;"><?php echo $driver['password']; ?></td>
                                                    </tr>
                                                <?php
                                                }
                                                ?>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                </div>
            </div>

        </div>
    </div>

    <div class="fixed-plugin">
        <div class="dropdown show-dropdown">
            <a href="#" data-toggle="dropdown">
                <i class="fa fa-cog fa-2x"> </i>
            </a>
            <ul class="dropdown-menu">
                <li class="header-title"> Sidebar Filters</li>
                <li class="adjustments-line">
                    <a href="javascript:void(0)" class="switch-trigger active-color">
                        <div class="badge-colors ml-auto mr-auto">
                            <span class="badge filter badge-purple" data-color="purple"></span>
                            <span class="badge filter badge-azure" data-color="azure"></span>
                            <span class="badge filter badge-green" data-color="green"></span>
                            <span class="badge filter badge-warning" data-color="orange"></span>
                            <span class="badge filter badge-danger" data-color="danger"></span>
                            <span class="badge filter badge-rose active" data-color="rose"></span>
                        </div>
                        <div class="clearfix"></div>
                    </a>
                </li>
                <li class="header-title">Images</li>
                <li class="active">
                    <a class="img-holder switch-trigger" href="javascript:void(0)">
                        <img src="assets/img/sidebar-1.jpg" alt="">
                    </a>
                </li>
                <li>
                    <a class="img-holder switch-trigger" href="javascript:void(0)">
                        <img src="assets/img/sidebar-2.jpg" alt="">
                    </a>
                </li>
                <li>
                    <a class="img-holder switch-trigger" href="javascript:void(0)">
                        <img src="assets/img/sidebar-3.jpg" alt="">
                    </a>
                </li>
                <li>
                    <a class="img-holder switch-trigger" href="javascript:void(0)">
                        <img src="assets/img/sidebar-4.jpg" alt="">
                    </a>
                </li>
                <li class="button-container">
                    <a href="https://www.creative-tim.com/product/material-dashboard" target="_blank" class="btn btn-primary btn-block">Free Download</a>
                </li>
                <!-- <li class="header-title">Want more components?</li>
            <li class="button-container">
                <a href="https://www.creative-tim.com/product/material-dashboard-pro" target="_blank" class="btn btn-warning btn-block">
                  Get the pro version
                </a>
            </li> -->
                <li class="button-container">
                    <a href="https://demos.creative-tim.com/material-dashboard/docs/2.1/getting-started/introduction.html" target="_blank" class="btn btn-default btn-block">
                        View Documentation
                    </a>
                </li>
                <li class="button-container github-star">
                    <a class="github-button" href="https://github.com/creativetimofficial/material-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star ntkme/github-buttons on GitHub">Star</a>
                </li>
                <li class="header-title">Thank you for 95 shares!</li>
                <li class="button-container text-center">
                    <button id="twitter" class="btn btn-round btn-twitter"><i class="fa fa-twitter"></i> &middot; 45</button>
                    <button id="facebook" class="btn btn-round btn-facebook"><i class="fa fa-facebook-f"></i> &middot; 50</button>
                    <br>
                    <br>
                </li>
            </ul>
        </div>
    </div>
    <!--   Core JS Files   -->
    <script src="assets/js/core/jquery.min.js"></script>
    <script src="assets/js/core/popper.min.js"></script>
    <script src="assets/js/core/bootstrap-material-design.min.js"></script>
    <script src="assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
    <!-- Plugin for the momentJs  -->
    <script src="assets/js/plugins/moment.min.js"></script>
    <!--  Plugin for Sweet Alert -->
    <script src="assets/js/plugins/sweetalert2.js"></script>
    <!-- Forms Validations Plugin -->
    <script src="assets/js/plugins/jquery.validate.min.js"></script>
    <!-- Plugin for the Wizard, full documentation here: https://github.com/VinceG/twitter-bootstrap-wizard -->
    <script src="assets/js/plugins/jquery.bootstrap-wizard.js"></script>
    <!--	Plugin for Select, full documentation here: http://silviomoreto.github.io/bootstrap-select -->
    <script src="assets/js/plugins/bootstrap-selectpicker.js"></script>
    <!--  Plugin for the DateTimePicker, full documentation here: https://eonasdan.github.io/bootstrap-datetimepicker/ -->
    <script src="assets/js/plugins/bootstrap-datetimepicker.min.js"></script>
    <!--  DataTables.net Plugin, full documentation here: https://datatables.net/  -->
    <script src="assets/js/plugins/jquery.dataTables.min.js"></script>
    <!--	Plugin for Tags, full documentation here: https://github.com/bootstrap-tagsinput/bootstrap-tagsinputs  -->
    <script src="assets/js/plugins/bootstrap-tagsinput.js"></script>
    <!-- Plugin for Fileupload, full documentation here: http://www.jasny.net/bootstrap/javascript/#fileinput -->
    <script src="assets/js/plugins/jasny-bootstrap.min.js"></script>
    <!--  Full Calendar Plugin, full documentation here: https://github.com/fullcalendar/fullcalendar    -->
    <script src="assets/js/plugins/fullcalendar.min.js"></script>
    <!-- Vector Map plugin, full documentation here: http://jvectormap.com/documentation/ -->
    <script src="assets/js/plugins/jquery-jvectormap.js"></script>
    <!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
    <script src="assets/js/plugins/nouislider.min.js"></script>
    <!-- Include a polyfill for ES6 Promises (optional) for IE11, UC Browser and Android browser support SweetAlert -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>
    <!-- Library for adding dinamically elements -->
    <script src="assets/js/plugins/arrive.min.js"></script>
    <!--  Google Maps Plugin    -->
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
    <!-- Chartist JS -->
    <script src="assets/js/plugins/chartist.min.js"></script>
    <!--  Notifications Plugin    -->
    <script src="assets/js/plugins/bootstrap-notify.js"></script>
    <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
    <script src="assets/js/material-dashboard.js?v=2.1.1" type="text/javascript"></script>
    <!-- Material Dashboard DEMO methods, don't include it in your project! -->
    <script src="assets/demo/demo.js"></script>

    <script>
        $(document).ready(function() {
            $().ready(function() {
                $sidebar = $('.sidebar');

                $sidebar_img_container = $sidebar.find('.sidebar-background');

                $full_page = $('.full-page');

                $sidebar_responsive = $('body > .navbar-collapse');

                window_width = $(window).width();

                fixed_plugin_open = $('.sidebar .sidebar-wrapper .nav li.active a p').html();

                if (window_width > 767 && fixed_plugin_open == 'Dashboard') {
                    if ($('.fixed-plugin .dropdown').hasClass('show-dropdown')) {
                        $('.fixed-plugin .dropdown').addClass('open');
                    }

                }

                $('.fixed-plugin a').click(function(event) {
                    // Alex if we click on switch, stop propagation of the event, so the dropdown will not be hide, otherwise we set the  section active
                    if ($(this).hasClass('switch-trigger')) {
                        if (event.stopPropagation) {
                            event.stopPropagation();
                        } else if (window.event) {
                            window.event.cancelBubble = true;
                        }
                    }
                });

                $('.fixed-plugin .active-color span').click(function() {
                    $full_page_background = $('.full-page-background');

                    $(this).siblings().removeClass('active');
                    $(this).addClass('active');

                    var new_color = $(this).data('color');

                    if ($sidebar.length != 0) {
                        $sidebar.attr('data-color', new_color);
                    }

                    if ($full_page.length != 0) {
                        $full_page.attr('filter-color', new_color);
                    }

                    if ($sidebar_responsive.length != 0) {
                        $sidebar_responsive.attr('data-color', new_color);
                    }
                });

                $('.fixed-plugin .background-color .badge').click(function() {
                    $(this).siblings().removeClass('active');
                    $(this).addClass('active');

                    var new_color = $(this).data('background-color');

                    if ($sidebar.length != 0) {
                        $sidebar.attr('data-background-color', new_color);
                    }
                });

                $('.fixed-plugin .img-holder').click(function() {
                    $full_page_background = $('.full-page-background');

                    $(this).parent('li').siblings().removeClass('active');
                    $(this).parent('li').addClass('active');


                    var new_image = $(this).find("img").attr('src');

                    if ($sidebar_img_container.length != 0 && $('.switch-sidebar-image input:checked').length != 0) {
                        $sidebar_img_container.fadeOut('fast', function() {
                            $sidebar_img_container.css('background-image', 'url("' + new_image + '")');
                            $sidebar_img_container.fadeIn('fast');
                        });
                    }

                    if ($full_page_background.length != 0 && $('.switch-sidebar-image input:checked').length != 0) {
                        var new_image_full_page = $('.fixed-plugin li.active .img-holder').find('img').data('src');

                        $full_page_background.fadeOut('fast', function() {
                            $full_page_background.css('background-image', 'url("' + new_image_full_page + '")');
                            $full_page_background.fadeIn('fast');
                        });
                    }

                    if ($('.switch-sidebar-image input:checked').length == 0) {
                        var new_image = $('.fixed-plugin li.active .img-holder').find("img").attr('src');
                        var new_image_full_page = $('.fixed-plugin li.active .img-holder').find('img').data('src');

                        $sidebar_img_container.css('background-image', 'url("' + new_image + '")');
                        $full_page_background.css('background-image', 'url("' + new_image_full_page + '")');
                    }

                    if ($sidebar_responsive.length != 0) {
                        $sidebar_responsive.css('background-image', 'url("' + new_image + '")');
                    }
                });

                $('.switch-sidebar-image input').change(function() {
                    $full_page_background = $('.full-page-background');

                    $input = $(this);

                    if ($input.is(':checked')) {
                        if ($sidebar_img_container.length != 0) {
                            $sidebar_img_container.fadeIn('fast');
                            $sidebar.attr('data-image', '#');
                        }

                        if ($full_page_background.length != 0) {
                            $full_page_background.fadeIn('fast');
                            $full_page.attr('data-image', '#');
                        }

                        background_image = true;
                    } else {
                        if ($sidebar_img_container.length != 0) {
                            $sidebar.removeAttr('data-image');
                            $sidebar_img_container.fadeOut('fast');
                        }

                        if ($full_page_background.length != 0) {
                            $full_page.removeAttr('data-image', '#');
                            $full_page_background.fadeOut('fast');
                        }

                        background_image = false;
                    }
                });

                $('.switch-sidebar-mini input').change(function() {
                    $body = $('body');

                    $input = $(this);

                    if (md.misc.sidebar_mini_active == true) {
                        $('body').removeClass('sidebar-mini');
                        md.misc.sidebar_mini_active = false;

                        $('.sidebar .sidebar-wrapper, .main-panel').perfectScrollbar();

                    } else {

                        $('.sidebar .sidebar-wrapper, .main-panel').perfectScrollbar('destroy');

                        setTimeout(function() {
                            $('body').addClass('sidebar-mini');

                            md.misc.sidebar_mini_active = true;
                        }, 300);
                    }

                    // we simulate the window Resize so the charts will get updated in realtime.
                    var simulateWindowResize = setInterval(function() {
                        window.dispatchEvent(new Event('resize'));
                    }, 180);

                    // we stop the simulation of Window Resize after the animations are completed
                    setTimeout(function() {
                        clearInterval(simulateWindowResize);
                    }, 1000);

                });
            });
        });
    </script>
    <script>
        var table = document.getElementById('table');

        for (var i = 1; i < table.rows.length; i++) {
            table.rows[i].onclick = function() {
                //rIndex = this.rowIndex;
                document.getElementById("name").value = this.cells[0].innerHTML;
                document.getElementById("adhaar").value = this.cells[1].innerHTML;
                document.getElementById("license").value = this.cells[2].innerHTML;
                document.getElementById("add").value = this.cells[3].innerHTML;
                document.getElementById("driver_city").value = this.cells[4].innerHTML;
                document.getElementById("country").value = this.cells[5].innerHTML;
                document.getElementById("contact").value = this.cells[6].innerHTML;
                document.getElementById("email").value = this.cells[7].innerHTML;
                document.getElementById("password").value = this.cells[8].innerHTML;

            };
        }
    </script>
</body>

</html>