<?php
session_start();
require_once 'vendor/autoload.php';

use Google\Cloud\Firestore\FirestoreClient;
use Google\Cloud\Storage\StorageClient;
use Kreait\Firebase\Factory;


if ($_SERVER['REQUEST_METHOD'] == "POST") {
  $city = $_SESSION["city"];
  $c = $city."Bus";
  $config = [
    'keyFilePath' => 'chale chalo-cf56f051c62b.json',
    'projectId' => 'chale-chalo',
  ];
  // Create the Cloud Firestore client
  $db = new FirestoreClient($config);

  $factory = (new Factory)->withServiceAccount('chale chalo-cf56f051c62b.json');
  $auth = $factory->createAuth();

  $email = $_POST['email'];  
  $user = $auth->getUserByEmail($email);
  $uid = $user->uid;
  $bus_no = $_POST["bus_no"];
  $driver_name = $_POST["driver"];
  $license_no = $_POST["license"];
  $adhaar = $_POST["adhaar"];
  $contact = $_POST["contact"];

  $driver = $db->collection('Drivers')->document($uid);
  $driver->update([
    ['path' => 'BusNumber', 'value' => $bus_no],
  ]);
  $p_driver = $db->collection($c)->document($bus_no);
  $snapshot = $p_driver->snapshot();
  if($snapshot->exists()){
    $p_driverRef = $snapshot->get('driver_uid'); 
  }
  $pdriver = $db->collection('Drivers')->document($p_driverRef);
  $pdriver->update([
    ['path' => 'BusNumber', 'value' => 'None'],
  ]);
  $cityRef = $db->collection($c)->document($bus_no);
  $cityRef->update([
    ['path' => 'driverName', 'value' => $driver_name],
    ['path' => 'license_no', 'value' => $license_no],
    ['path' => 'contact', 'value' => $contact],
    ['path' => 'driver_uid', 'value' => $uid]
  ]);
  
  echo '<script language="javascript">';
  echo 'alert("Updated Successfully");';
  echo 'window.location.href="driver_insert.php";';
  echo '</script>';
}
