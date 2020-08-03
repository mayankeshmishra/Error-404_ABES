//import 'package:chalechalodriver/account_history.dart';
// import 'package:chalechalo/profile.dart';
// import 'package:chalechalo/login.dart';
// import 'package:chalechalo/destination.dart';
// import 'package:chalechalo/ticket.dart';
// import 'package:chalechalo/history.dart';
import 'dart:async';

import 'package:chalechalo/Authentication/loginPage.dart';
import 'package:chalechalo/Constants/constants.dart';
import 'package:chalechalo/DriverHomePage.dart';
import 'package:chalechalo/changeStream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:chalechalo/payment.dart';
//import 'package:chalechalo/QRViewExample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'navigationUrl.dart';


void main() => runApp(ChaleChalo());
class ChaleChalo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ChaleChaloHome(),
    );
  }

}
BuildContext mainContext;
class ChaleChaloHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    // TODO: implement createState
    return ChaleChaloState();
  }
  // This widget is the root of your application.
}
var H,W;
class ChaleChaloState extends State<ChaleChaloHome>{
  String distance="start";
  var accuracy="";
var x=0.0;
  @override
  void initState() {
    super.initState();
    animate();

    FirebaseAuth.instance.currentUser().then((value){
      if(value!=null){
        UID=value.uid;
      }
    });
  }
  var context1;
animate() {
  Future.delayed(Duration(milliseconds: 1000), () {
    setState(() {
      x = .15;
      navigate();
    });
  });
}
  navigate(){
    Future.delayed(Duration(seconds: 2),(){
     FirebaseAuth.instance.currentUser().then((value){
       if(value==null){
         Navigator.pushAndRemoveUntil(context1, MaterialPageRoute(
             builder: (ctx)=>LoginPage()
         ), (route) => false);
       }else{
         getProfileData();
       }
     });
    });
  }
  @override
  Widget build(BuildContext context) {
  mainContext=context;
    context1=context;
    H=MediaQuery.of(context).size.height;
    W=MediaQuery.of(context).size.width;
    // TODO: implement build
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          body: Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1500),
              height: H * x,
              width: H * x,
              child: Image.asset("assets/logo.png"),
            ),
          ),
          bottomNavigationBar: Container(
              height: H * .1,
              child: SpinKitRing(
                color: YELLOW,
                lineWidth: H * .002,
                size: H * .04,
              )),
        ),

      )
    );
  }
  getProfileData(){
    Future.delayed(Duration(seconds: 0),(){
      var db=Firestore.instance;
      String x;
      print(UID);
      db.collection("Drivers").document(UID).get().then((value){
        profileData=ProfileData(value.data["name"], value.data["contact"],
            value.data["add"], value.data["BusNumber"], value.data["adhaar"],
            value.data["city"], value.data["country"], value.data["email"], value.data["licence_no"],
            "", "");
        getStops();
        getData123();
        print(profileData.busRegistrationNumber);
      });
    });
  }
  getStops(){
  var db=Firestore.instance;
  db.collection("DelhiBus").document(profileData.busRegistrationNumber).get()
  .then((value){
    print(value.data);
    stops=value.data["Stops"];
    if(value.data["upstream"]==true){
      upstream=true;
      for(var i=0;i<value.data["Stops"].length;i++){
        if(value.data["Stops"][i]["Visited"]==false){
          index=i;
          break;
        }
      }
    }
    else{
      upstream=false;
      for(var i=value.data["Stops"].length-1;i>=0;i--){
        if(value.data["Stops"][i]["Visited"]==false){
          index=i;
          break;
        }
      }
    }
    for(var i in value.data["Stops"]){
      Stops.add(i["StopName"].toString());
    }
    db.collection("Stops").document("Delhi").get().then((value){
      for(var i in Stops) {
        for (var j in value.data["AllStops"]) {
          if(i.toLowerCase().trim()==j["Name"].toString().toLowerCase().trim()){
            StopsDetail.add([
              i,
              j["Latitude"],
              j["Longitude"]
            ]);
            break;
          }
        }
        print(StopsDetail);
      }
    });
    if(mounted){
     Navigator.pushAndRemoveUntil(context1, MaterialPageRoute(
         builder: (ctx)=>DriverHomePage()
     ), (route) => false);
    }
  });
}

// getData123()async{
//   var x=0.0,y=0.0;
//   //getCurrentLocation();
//   Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
//   myLatitude=position.latitude;
//   myLongitude=position.longitude;
//   Timer.periodic(Duration(seconds: 3), (Timer t)async{
//     print("$myLatitude,$myLongitude");
//     print("Started");
//     //getCurrentLocation();
//     Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
//     myLatitude=position.latitude;
//     myLongitude=position.longitude;
//     setState(() {
//       accuracy=position.accuracy.toString();
//     });
//     if(myLatitude!=x || myLongitude!=y){
//       x=myLatitude;
//       y=myLongitude;
//       //saveLocation();
//       setState(() {
//         distance=calculateDistance(myLatitude, myLongitude,25.4670912, 81.8240464).toString();
//       });
//     }
//   });
// }


  // passengerStream(int index)async{
  //   var db=Firestore.instance;
  //   await for (var snapshot in db.collection("DelhiBus").document(profileData.busRegistrationNumber)
  //       .snapshots()){
  //       if(snapshot.data["upstream"]==true){
  //         for(var i=index+1;i<snapshot.data["Stops"].length;i++){
  //           passengerDataAfterIndex.add({"name":snapshot.data["Stops"][i]["StopName"],"passenger":snapshot.data["Stops"][i]["Passenger"]});
  //         }
  //         print(passengerDataAfterIndex);
  //       }
  //       else{
  //         for(var i=index-1;i>=0;i--){
  //           passengerDataAfterIndex.add({"name":snapshot.data["Stops"][i]["StopName"],"passenger":snapshot.data["Stops"][i]["Passenger"]});
  //         }
  //         print(passengerDataAfterIndex);
  //       }
  //   }
  // }
}
