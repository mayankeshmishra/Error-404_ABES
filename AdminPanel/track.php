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
  <style>
    /* Set the size of the div element that contains the map */
    #map {
      height: 850px;
      /* The height is 400 pixels */
      width: 100%;
      /* The width is the width of the web page */
    }
  </style>
</head>
<script src="https://www.gstatic.com/firebasejs/7.17.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.17.1/firebase-firestore.js"></script>
<script type = module>
  const firebase = require("firebase");
  const firestore=require("firebase/firestore");
  
</script>
<body>

  <div id="map"></div>

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
        var lat = doc.data().lat;
        var lng = doc.data().long;
        
        var map = new google.maps.Map(
        document.getElementById('map'), {
          zoom: 10,
          center: {lat: 28.7041, lng: 77.1025}
        });
    
        bus_pos = new google.maps.LatLng({lat: lat, lng: lng}); 
   

      var map = new google.maps.Map(
        document.getElementById('map'), {
          zoom: 18,
          center: bus_pos
        });
      // The marker, positioned at Uluru
      var marker = new google.maps.Marker({
        position: bus_pos,
        map: map,
        title: 'Hello World!'
      });
      content = "<?php echo $bus_no;?>";
      var infowindow = new google.maps.InfoWindow({
        content: content,
        maxWidth: 200
      });
      marker.addListener('click', function () {
        infowindow.open(map, marker);
      });
    });

  </script>
  <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbj-HZAEaeYL6m3Dqol-2ADW67uXUG8vU">
    </script>
</body>

</html>