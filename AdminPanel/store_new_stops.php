<?php
session_start();
require_once 'vendor/autoload.php';

use Google\Cloud\Firestore\FirestoreClient;
use Google\Cloud\Storage\StorageClient;
use Google\Cloud\Firestore\FieldValue;


if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $b = $_SESSION["bus_no"];
  $city = $_SESSION["city"];
  $c = $city."Bus";
  $config = [
    'keyFilePath' => 'chale chalo-cf56f051c62b.json',
    'projectId' => 'chale-chalo',
  ];
  // Create the Cloud Firestore client
  $db = new FirestoreClient($config);

  $stop = $_POST["member"];


  $data = [
    'Passenger' => 0,
    'StopName' => $stop,
    'Visited' => false,
  ];

  $docRef = $db->collection($c)->document($b);
  $set_doc = $docRef->update([
    ['path' => 'Stops', 'value' => FieldValue::arrayUnion([$data])]
  ]);
}

echo '<script language="javascript">';
echo 'alert("Added Successfully");';
echo 'window.location.href="bus_insert.php";';
echo '</script>';
