import 'dart:async';

import 'package:chalechalo/DriverHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

import '../main.dart';
Color YELLOW= Colors.amber;
Color YELLOW_ACCENT= Colors.amberAccent;
Color red= Colors.red[700];
String uid;
List<String> Stops=[];
var StopsDetail=[];
ProfileData profileData;
var UID;
class ProfileData{
  String name;
  String number;
  String busNumber;
  String busRegistrationNumber;
  String from;
  String to;

  ProfileData(this.name, this.number, this.busNumber,
      this.busRegistrationNumber, this.from, this.to);

}
double myLatitude;
double myLongitude;
getData123()async{
  double x=0,y=0;
  getCurrentLocation();
  Timer.periodic(Duration(seconds: 2), (Timer t){
    getCurrentLocation();
    if(myLatitude!=x || myLongitude!=y){
        x=myLatitude;
        y=myLongitude;
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
  }
  else {
    showDialog(context: mainContext,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(H * .02)),
            title: Text("Permition Denied", style: TextStyle(
                fontSize: H * .018, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
            content: Text(
              "Unable to get your GPS Location, kindly enable it",
              textAlign: TextAlign.center,),
            actions: [
              FlatButton(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(H)),
                child: Container(
                    alignment: Alignment.center,
                    width: W,
                    child: Text("OK", style: TextStyle(color: YELLOW),)),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              )
            ],
          );
        });
  }
}
saveLocation()async {
  var db=Firestore.instance;
  var upstream;
  await db.collection("DelhiBus").document(profileData.busRegistrationNumber).updateData({"lat":myLatitude,"long":myLongitude}).whenComplete(()async{
      await db.collection("DelhiBus").document(profileData.busRegistrationNumber).get().then((value){
        var stop=value.data["Stops"];
          if(value.data["upstream"]==true){
            upstream=true;
            for(var i=0;i<value.data["Stops"].length;i++){
              if(value.data["Stops"][i]["Visited"]==false){
                var x,y;
                for(var j in StopsDetail){
                  if(j[0].toString().toLowerCase()==value.data["Stops"][i]["StopName"].toString().toLowerCase()){
                    x=double.parse(j[1]);
                    y=double.parse(j[2]);
                  }
                }
                print(calculateDistance(myLatitude, myLongitude,x,y));
                if(calculateDistance(myLatitude, myLongitude,x,y)<=100){
                  stop[i]["Visited"]=true;
                  if(i==stop.length-1){
                    upstream=false;
                    for(var i=0;i<stop.length;i++){
                      stop[i]["Passenger"]=0;
                      stop[i]["Visited"]=false;
                    }
                  }
                  db.collection("DelhiBus").document(profileData.busRegistrationNumber)
                  .updateData({"AllStops":stop,"upstream":upstream}).whenComplete((){
                    print("Done");
                  });
                }
                break;
              }
            }
          }
          else{
            upstream=false;
            for(var i=value.data["Stops"].length-1;i>=0;i--){
              if(value.data["Stops"][i]["Visited"]==false){
                var x,y;
                for(var j in StopsDetail){
                  if(j[0].toString().toLowerCase()==value.data["Stops"][i]["StopName"].toString().toLowerCase()){
                    x=double.parse(j[1]);
                    y=double.parse(j[2]);
                  }
                }
                if(calculateDistance(myLatitude, myLongitude,x,y)<=50){
                  stop[i]["Visited"]=true;
                  if(i==stop.length-1){
                    upstream=true;
                    for(var i=0;i<stop.length;i++){
                      stop[i]["Passenger"]=0;
                      stop[i]["Visited"]=false;
                    }
                  }
                  db.collection("DelhiBus").document(profileData.busRegistrationNumber)
                      .updateData({"AllStops":stop,"upstream":upstream}).whenComplete((){
                    print("Done");
                  });
                }
                break;
              }
            }
          }
      });
  });
}
double calculateDistance(Lat1, Long1, Lat2, Lang2) {
  final Distance distance = new Distance();
  // km = 423
  final double meter = distance.as(LengthUnit.Meter,
      new LatLng(Lat1, Long1), new LatLng(Lat2, Lang2));
  return meter;
}