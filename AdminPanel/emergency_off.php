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
    $c = $city . "Bus";

    $bus_ref = $db->collection($c)->document($bus_no);
    $snapshot = $bus_ref->snapshot();

    if ($snapshot->exists()) {
        $e = $snapshot->get('Emergency');
        if ($e == null) {
            echo '<script language="javascript">';
            echo 'alert("Emergency already Reported");';
            echo 'window.location.href="emergency.php";';
            echo '</script>';
        } else {
            foreach ($e as $num) {
                $ph_no = $num;
                echo $ph_no;
                // Your Account SID and Auth Token from twilio.com/console
                $account_sid = "AC07c0e101083d006f3174e47426eee3c8";
                $auth_token = "c71b08c34f6b13cd3a8310484fb0438d";
               
                $twilio_number = "+12024105565";

                $client = new Client($account_sid, $auth_token);
                $message=$client->messages->create(
                    // Where to send a text message (your cell phone?)
                    $ph_no,
                    array(
                        'from' => $twilio_number,
                        'body' => 'We are closing the emergency you reported.
        Was your issue resolved? if not then please write to us at:
                DigiRide@gmail.com'
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