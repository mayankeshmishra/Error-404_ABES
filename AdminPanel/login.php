<?php
session_start();
require_once 'vendor/autoload.php';

use Google\Cloud\Firestore\FirestoreClient;
use Kreait\Firebase\Factory;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $config = [
        'keyFilePath' => 'chale chalo-cf56f051c62b.json',
        'projectId' => 'chale-chalo',
      ];
      // Create the Cloud Firestore client
      $db = new FirestoreClient($config);
    
      $factory = (new Factory)->withServiceAccount('chale chalo-cf56f051c62b.json');
      $auth = $factory->createAuth();

    // Assigning POST values to variables.
    $username = $_POST['username'];
    $password = $_POST['password'];
 
    if ($username == "admin" && $password == "admin123") {
        $_SESSION['uid'] = "master_admin";
        echo '<script language="javascript">';
        echo 'window.location.href="bus_insert.php";';
        echo '</script>';
    } 
    else{
        $signInResult = $auth->signInWithEmailAndPassword($username, $password);
        $user = $signInResult->data(); 
        $_SESSION['uid'] = $user['localId'];
        echo '<script language="javascript">';
        echo 'window.location.href="bus_insert.php";';
        echo '</script>';
    }

   
}
?>