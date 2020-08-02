import 'dart:async';
//import 'package:chalechalo/DriverHomePage.dart';
import 'package:chalechalo/passengerForm/passenger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

Color YELLOW = Colors.amber;
Color YELLOW_ACCENT = Colors.amberAccent;
Color red = Colors.red[700];
String uid;
bool upstream;
int index;
List<String> Stops = [];
var StopsDetail = [];
var stops = [];
ProfileData profileData;
var passenger=Passenger("", "", "", "");
var UID;
var passengerDataAfterIndex=[];
class ProfileData {
  String name;
  String number;
  String address;
  String busRegistrationNumber;
  String adhaar;
  String city;
  String country;
  String email;
  String licenseNo;
  String from;
  String to;

  ProfileData(this.name, this.number, this.address, this.busRegistrationNumber,
      this.adhaar, this.city, this.country, this.email, this.licenseNo,
      this.from, this.to);

}

double myLatitude;
double myLongitude;
var STOPS="";
getData123() {
  print("getData Called");
  double x = 0, y = 0;
  getCurrentLocation();
  Timer.periodic(Duration(seconds: 2), (Timer t) {
    getCurrentLocation();
    if (myLatitude != x || myLongitude != y) {
      x = myLatitude;
      y = myLongitude;
      saveLocation();
    }
  });
}

getCurrentLocation() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
  if (_permissionGranted == PermissionStatus.granted) {
    myLongitude = _locationData.longitude;
    myLatitude = _locationData.latitude;
  } else {
    showDialog(
        context: mainContext,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(H * .02)),
            title: Text(
              "Permition Denied",
              style: TextStyle(fontSize: H * .018, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Unable to get your GPS Location, kindly enable it",
              textAlign: TextAlign.center,
            ),
            actions: [
              FlatButton(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(H)),
                child: Container(
                    alignment: Alignment.center,
                    width: W,
                    child: Text(
                      "OK",
                      style: TextStyle(color: YELLOW),
                    )),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              )
            ],
          );
        });
  }
}

saveLocation() async {
  // print(stops);
  // print(upstream);

  var db = Firestore.instance;
  await db
      .collection("DelhiBus")
      .document(profileData.busRegistrationNumber)
      .updateData(
          {"lat": myLatitude, "long": myLongitude}); //.whenComplete((){});

  if (upstream == true) {
    print("");
    print("");
    print("Comapre From Database");
    print(stops[index]);
    print("---------------------");
    //print(StopsDetail);
    var x = 0.00, y = 0.00;
    for (var j in StopsDetail) {
      print(j[0].toString().toLowerCase());
      if (j[0].toString().toLowerCase() ==
          stops[index]["StopName"].toString().toLowerCase()) {
        x = double.parse(j[1]);
        y = double.parse(j[2]);
        print("Compare To Stop Data From Shared Pref");
        print(j);
        print("");
        print("");
        break;
      }
    }
    print(calculateDistance(myLatitude, myLongitude, x, y));
    if (calculateDistance(myLatitude, myLongitude, x, y) <= 200 && STOPS!=stops[index]["StopName"]) {
      stops[index]["Visited"] = true;
      STOPS=stops[index]["StopName"];
      if (index == stops.length - 1) {
        stops[index]["Visited"] = false;
        upstream = false;
        index = stops.length - 2;
        for (var i = 0; i < stops.length; i++) {
          stops[i]["Passenger"] = 0;
          stops[i]["Visited"] = false;
        }
      }
      db.collection("DelhiBus")
          .document(profileData.busRegistrationNumber)
          .updateData({"Stops": stops, "upstream": upstream}).whenComplete(
              (){
        index++;
        print("UPDATED");
      });
    }
  } else {
    print("");
    print("");
    print("Comapre From Database");
    print(stops[index]);
    print("---------------------");
    var x = 0.00, y = 0.00;
    for (var j in StopsDetail) {
      if (j[0].toString().toLowerCase() ==
          stops[index]["StopName"].toString().toLowerCase()) {
        x = double.parse(j[1]);
        y = double.parse(j[2]);
        print("Compare To Stop Data From Shared Pref");
        print(j);
        print("");
        print("");
        break;
      }
    }
    print(calculateDistance(myLatitude, myLongitude, x, y));
    if (calculateDistance(myLatitude, myLongitude, x, y) <= 100){
      print("Calculate Distance Called");
      stops[index]["Visited"] = true;
      if (index == 0) {
        stops[index]["Visited"] = false;
        upstream = true;
        index = 1;
        for (var i = 0; i < stops.length; i++) {
          stops[i]["Passenger"] = 0;
          stops[i]["Visited"] = false;
        }
      }
      db
          .collection("DelhiBus")
          .document(profileData.busRegistrationNumber)
          .updateData({"Stops": stops, "upstream": upstream}).whenComplete(
              () {
        index--;
        print("Done");
      });
    }
  }
}

double calculateDistance(Lat1, Long1, Lat2, Lang2) {
  final Distance distance = new Distance();
  // km = 423
  final double meter = distance.as(
      LengthUnit.Meter, new LatLng(Lat1, Long1), new LatLng(Lat2, Lang2));
  return meter;
}
var emergencyContext;
var emergency=0;
emergencyStream()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  if(pref.containsKey("emergency")){
    emergency=pref.get("emergency");
  }
  var db = Firestore.instance;
  await for (var snapshot in db
      .collection("DelhiBus")
      .document(profileData.busRegistrationNumber)
      .snapshots()){
    if(snapshot.data["Emergency"].length > emergency ){
      emergency=snapshot.data["Emergency"].length;
      pref.setInt("emergency", emergency);
      showDialog(context: emergencyContext,builder: (ctx){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(H*.02)),
          title: Text("Emergency Reported",style: TextStyle(color: Colors.red),textAlign: TextAlign.center,),
          content: Text("Your bus is being monitored as someone reported an emergency. Resolve it as soon as possible",textAlign: TextAlign.center,),
        );
      });
    }else if(snapshot.data["Emergency"].length < emergency){
      emergency=snapshot.data["Emergency"].length;
      pref.setInt("emergency", emergency);
    }
    print(emergency);
  }
}