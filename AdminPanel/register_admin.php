<?php
session_start();
require_once 'vendor/autoload.php';

use Google\Cloud\Firestore\FirestoreClient;
use Google\Cloud\Storage\StorageClient;
use Kreait\Firebase\Factory;


if ($_SERVER['REQUEST_METHOD'] == "POST") {

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
  $name = $_POST["name"];
  $contact = $_POST["contact"];
  $adhaar = $_POST["adhaar"];
  $add = $_POST["address"];
  $city = $_POST["city"];

  $admin_info = [
    'email' => $email,
    'password' => $psw,
    'name' => $name,
    'contact' => $contact,
    'adhaar' => $adhaar,
    'add' => $add,
    'city' => $city,
  ];

  $db->collection('Admin')->document($uid)->set($admin_info);

  echo '<script language="javascript">';
  echo 'alert("Added Successfully");';
  echo 'window.location.href="register_local_admin.php";';
  echo '</script>';
}
