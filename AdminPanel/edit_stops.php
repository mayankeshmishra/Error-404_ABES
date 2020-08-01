<?php
session_start();
$city = $_SESSION['city'];
require_once 'vendor/autoload.php';
use Google\Cloud\Firestore\FirestoreClient;
if($_SERVER["REQUEST_METHOD"] == "POST"){
    $config = [
        'keyFilePath' => 'chale chalo-cf56f051c62b.json',
        'projectId' => 'chale-chalo',
      ];
      // Create the Cloud Firestore client
      $db = new FirestoreClient($config);
    $name = $_POST['member'];
    $lat = $_POST['lat'];
    $lng = $_POST['lng'];

    if($lat == null || $lng == null){
        echo "<script>alert('no data to update');";
        echo "window.location.href='update_&_del_stops.php';";
        echo  "</script>";
    }
    else{
        $i=0;
        $stops = $db->collection('Stops')->document($city);
        $snapshot = $stops->snapshot();
        if($snapshot->exists()){
            $arr = $snapshot->get('AllStops');
        }
        
        foreach($arr as $s){
            if($s['Name'] == $name){
            break;
            }
            $i++;
        }
    
        $arr[$i]['Latitude'] = floatval($lat);
        $arr[$i]['Longitude'] = floatval($lng); 
     
        $stops->update([
            ['path' => 'AllStops', 'value' => $arr]
        ]);
        echo "<script>alert('Updated Succesfully');";
        echo "window.location.href='update_&_del_stops.php';";
        echo  "</script>";
    }
}
?>