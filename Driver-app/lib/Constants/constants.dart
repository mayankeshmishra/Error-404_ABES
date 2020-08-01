import 'package:chalechalo/DriverHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color YELLOW= Colors.amber;
Color YELLOW_ACCENT= Colors.amberAccent;
Color red= Colors.red[700];
String uid;
List<String> Stops=[];
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