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
  $psw = $_POST['password'];
  $userProperties = [
        'email' => $email,
        'password' => $psw,
    ];
  $createdUser = $auth->createUser($userProperties);
  $user = $auth->getUserByEmail($email);
  $uid = $user->uid;
  $bus_no = $_POST["bus_no"];
  $driver_name = $_POST["driver1"];
  $license_no = $_POST["license"];
  $contact = $_POST["contact"];
  $adhaar = $_POST["adhaar"];
  $add = $_POST["address"];
  $driver_city = $_POST["driver_city"];
  $country = $_POST["country"];


  $driver_info = [
    'BusNumber' => $bus_no,
    'email' => $email,
    'password' => $psw,
    'name' => $driver_name,
    'license_no' => $license_no,
    'contact' => $contact,
    'adhaar' => $adhaar,
    'add' => $add,
    'city' => $driver_city,
    'country' => $country
  ];

  $db->collection('Drivers')->document($uid)->set($driver_info);
  if($bus_no != "None"){
  $cityRef = $db->collection("DelhiBus")->document($bus_no);
  $cityRef->update([
    ['path' => 'driverName', 'value' => $driver_name],
    ['path' => 'license_no', 'value' => $license_no],
    ['path' => 'contact', 'value' => $contact],
    ['path' => 'driver_uid', 'value' => $uid]
  ]);
  }
  echo '<script language="javascript">';
  echo 'alert("Added Successfully");';
  echo 'window.location.href="edit.php";';
  echo '</script>';
}
