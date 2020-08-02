<?php
session_start();
  if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $bus = $_POST["bus"];
    $_SESSION["bus_no"] = $bus;
   
    echo '<script language="javascript">';
    echo 'window.location.href="edit_bus_route.php";';
    echo '</script>';
    // header("refresh:1,url:edit_bus_route.php");
  }
  ?>