<?php
session_start();
$admin_uid = $_SESSION['uid'];
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
  
  $email = $_POST['email'];
  $psw = $_POST['password'];
  $userProperties = [
        'email' => $email,
        'password' => $psw,
    ];
  $createdUser = $auth->createUser($userProperties);
  $user = $auth->getUserByEmail($email);
  $driver_uid = $user->uid;
  $stops = array();
  $bus_name = $_POST['busname'];
  $bus_no = $_POST['busname'];
  if($bus_no == null){
    $bus_no = 'no';
  }
  $city = $_SESSION["city"];
  $c = $city . "Bus";
  $driver_name = $_POST["driver1"];
  $capacity = intval($_POST["capacity"]);
  $cctv = $_POST["cctv_ip"];
  $license_no = $_POST["license"];
  $contact = $_POST["contact"];
  $stop = $_POST["member"];
  $s = intval($stop);
  $adhaar = $_POST["adhaar"];
  $add = $_POST["address"];
  $driver_city = $_POST["driver_city"];
  $country = $_POST["country"];
  $ac = $_POST["ac"];
  if($ac == 'yes'){
    $ac = true;
  }
  else{
    $ac = false;
  }
  $rating = 0;
  $noOfRating = 0;
  $navigationUrl = "";
  for ($i = 0; $i < $s; $i++) {
    $n = "member" . strval($i);
    array_push($stops, $_POST[$n]);
  }
  $inititial = $_POST["member0"];
  $i = $db->collection('Stops')->document($city);
  $snapshot = $i->snapshot();
  if($snapshot->exists()){
    $coords = $snapshot->get('AllStops');
  }
  foreach($coords as $co){

    if($co['Name'] == $inititial){
      $lat = floatval($co['Latitude']);
      $long = floatval($co['Longitude']);
    }
  }
  print($lat);
  print($long);
  $finalStops = array();
  for ($i = 0; $i < $s; $i++) {
    array_push($finalStops, ['StopName' => $stops[$i], 'Visited' => false, 'Passenger' => 0]);
  }
 
  $data = [
    'admin_uid' =>$admin_uid,
    'capacity' => $capacity,
    'cctv_ip' => $cctv,
    'upstream' => true,
    'driverName' => $driver_name,
    'license_no' => $license_no,
    'contact' => $contact,
    'Stops' => $finalStops,
    'ac' => $ac,
    'lat' => $lat,
    'long' => $long,
    'driver_uid' => $driver_uid,
    'rating' => $rating,
    'noOfRating' => $noOfRating,
    'navigationUrl' => $navigationUrl,
    'Emergency' => []
  ];

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

  $docRef = $db->collection($c)->document($bus_name);
  $set_doc = $docRef->set($data);
  $date = date("d-m-Y");
  $ticket_sub = $docRef->collection('tickets')->document($date);
  $set_sub = $ticket_sub->set($data);
  $db->collection('Drivers')->document($driver_uid)->set($driver_info);
  echo '<script language="javascript">';
  echo 'alert("Added Successfully");';
  echo 'window.location.href="bus_insert.php";';
  echo '</script>';
}
?>
