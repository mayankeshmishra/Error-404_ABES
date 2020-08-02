<?php
 session_start();
 $city = $_SESSION['city'];
 $c = $city."Bus";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $bus_no = $_POST['bus_no'];
}
?>
<!DOCTYPE html>
<html>
<head>
  
</head>
<script src="https://www.gstatic.com/firebasejs/7.17.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.17.1/firebase-firestore.js"></script>
<script type = module>
  const firebase = require("firebase");
  const firestore=require("firebase/firestore");
  // import * as firebase from "/firebase/app";
  // import "/firebase/firestore";
</script>
<body>


<script type="text/javascript">

  firebase.initializeApp({
    apiKey: "AIzaSyDRu3-68z3OssKRNJgKXA82pCY3QljHjPo",
    authDomain: "chale-chalo.firebaseapp.com",
    databaseURL: "https://chale-chalo.firebaseio.com",
    projectId: "chale-chalo",
    storageBucket: "chale-chalo.appspot.com",
    messagingSenderId: "56180449204",
    appId: "1:56180449204:web:55d77c1f95e60ee7a19ce1",
    measurementId: "G-S3C7HQHM1B"
});

var db = firebase.firestore();
db.collection("<?php echo $c;?>").doc("<?php echo $bus_no;?>")
    .onSnapshot(function(doc) {
        var ip = doc.data().cctv_ip_address;
        window.open(ip);
    });

  </script>
  
</body>

</html>