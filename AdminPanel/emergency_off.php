<?php
session_start();
require __DIR__ . '/vendor/autoload.php';
use Twilio\Rest\Client;
use Google\Cloud\Firestore\FirestoreClient;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $config = [
      'keyFilePath' => 'chale chalo-cf56f051c62b.json',
      'projectId' => 'chale-chalo',
    ];
    // Create the Cloud Firestore client
    $db = new FirestoreClient($config);

    $bus_no = $_POST['bus_no'];
    $city = $_SESSION['city'];
    $c = $city."Bus";

    $bus_ref = $db->collection($c)->document($bus_no);
    $snapshot = $bus_ref->snapshot();

    if($snapshot->exists()){
        $e= $snapshot->get('Emergency');
        if($e == null){
            echo '<script language="javascript">';
            echo 'alert("Emergency already Reported");';
            echo 'window.location.href="emergency.php";';
            echo '</script>';
        }
        else{
            foreach($e as $num){
                $ph_no = $num;
              
            
       
   
// Your Account SID and Auth Token from twilio.com/console
$account_sid = 'AC8f127cc08897f94573b4fb5fe825e050';
$auth_token = '91a40a7cb8046d7c0b729dc16c49c412';
// In production, these should be environment variables. E.g.:
// $auth_token = $_ENV["TWILIO_AUTH_TOKEN"]

// A Twilio number you own with SMS capabilities
$twilio_number = "+12055484734";

$client = new Client($account_sid, $auth_token);
$client->messages->create(
    // Where to send a text message (your cell phone?)
    $ph_no,
    array(
        'from' => $twilio_number,
        'body' => 'We are closing the emergency you reported.
Was your issue resolved? if not then please write to us at:
Chalechalo@gmail.com'
    )
);
echo '<script language="javascript">';
echo 'alert("Message Sent Successfully");';
echo '</script>';
            }
}
}

$bus_ref->update([
    ['path' => 'Emergency', 'value' => []],
  ]);
  echo '<script language="javascript">';
  echo 'window.location.href="emergency.php";';
  echo '</script>';

}