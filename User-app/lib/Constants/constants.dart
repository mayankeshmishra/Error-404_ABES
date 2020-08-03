import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mailgun/mailgun.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

const YELLOW = Color(0Xffffeb3b);
const YELLOW_DULL = Color(0Xffffd600);
Color red = Colors.red[700];
const BackgroundGradient=BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0Xfffbc02d),
        Color(0Xfffdd835),
        Color(0Xffffeb3b),
        Color(0Xffffee58),
        Color(0xfffff176),
        Color(0xfffff59d),
      ]),
);

var inputs=[];
var inputsForEmergency=["VolumeButtonEvent.VOLUME_UP","VolumeButtonEvent.VOLUME_DOWN","VolumeButtonEvent.VOLUME_UP","VolumeButtonEvent.VOLUME_DOWN"];
const PAYMENT_URL = "https://us-central1-payments-test-6606d.cloudfunctions.net/customFunctions/payment";

const ORDER_DATA = {
  "custID": "USER_1122334455",
  "custEmail": "someemail@gmail.com",
  "custPhone": "7777777777"
};

const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";
List allStops=[];
String NAME = "---";
String PHONE = "---";
String EMAIL = "---";
bool blind;
File AVTAR;
List<String> numbersForSMS = ["+919555656766"];

getNumbersToSMS() {
  var db = Firestore.instance;
  db.collection("AllUsers").document(PHONE).get().then((value) {
    numbersForSMS.add(value.data["emergencyNo1"].toString());
    numbersForSMS.add(value.data["emergencyNo2"].toString());
    numbersForSMS.add("+919555656766");
  });
}
FlutterTts flutterTts = FlutterTts();
Future speak(selectedItem) async {
  await flutterTts.setLanguage("hi-IN");
  await flutterTts.setSpeechRate(0.9);
  await flutterTts.setVolume(1.0);
  await flutterTts.setPitch(1.1);
  await flutterTts.speak(selectedItem);
}
var travelingBusNumber="";
var travelingDriverName="";
var travelingDriverNumber="";
startEmergency()async{
  speak("We have send emergency report to your emergency contact and admin");
  var mailgun = MailgunMailer(
      domain:
      "sandboxd2b482b8e25e491fa0f8d48dd0edd898.mailgun.org",
      apiKey:
      "1592c4e8c965a881adc322dfe504d9ad-ffefc4e4-0cf24894");
  mailgun
      .send(
      from: "chalechalo@gmail.com",
      to: ["ankiisnap@gmail.com"],
      subject: "Test email",
      text: "Hello World")
      .then((value) {
    print(value.message);
  });
  var twilioFlutter = TwilioFlutter(
      accountSid:
      'AC7fbf2f1200e9786e6ee7eb3b4cadfed0',
      // replace *** with Account SID
      authToken:
      '4ae0d018ca9e1593f625193468e0e001',
      // replace xxx with Auth Token
      twilioNumber:
      '+12565734690' // replace .... with Twilio Number
  );
  // var numbers = [
  //   "+919555656766",
  //   "+919569550325"
  // ];
  var db = Firestore.instance;
  var navigationUrl;
  await db
      .collection("DelhiBus")
      .document(travelingBusNumber)
      .get()
      .then((value) {
    navigationUrl = value.data["navigationUrl"];
  });
  for (var i = 0; i < numbersForSMS.length; i++) {
    Future.delayed(Duration(seconds: 4), () {
      twilioFlutter
          .sendSMS(
          toNumber: numbersForSMS[i],
          messageBody:
          'The Person with mobile number : $PHONE has reported an emergency while travelling in a bus with Registration Number : ${travelingBusNumber}, Driver Name : ${travelingDriverName}, Driver Contact No. : ${travelingDriverNumber}, & Navigation link to track the bus : $navigationUrl')
          .then((value) {
        print(value.toString());
      });
    });
  }
  Future.delayed(Duration(seconds: 7), () {
    var db = Firestore.instance;
    db
        .collection("DelhiBus")
        .document(travelingBusNumber)
        .get()
        .then((value) {
      var emergency = value.data["Emergency"];
      emergency.add(PHONE);
      db
          .collection("DelhiBus")
          .document(travelingBusNumber)
          .updateData({
        "Emergency": emergency
      }).whenComplete(() {
        Future.delayed(Duration(seconds: 2),(){
          speak("Your emergency report submitted successfully");
        });
      });
    });
  });
}
turnInputEmpty(){
  Future.delayed(Duration(seconds: 4),(){
    inputs=[];
  });

  if(inputs.length==4){
    print(inputs);
    if(inputs[0]=="up" && inputs[1]=="down" && inputs[2]=="up" && inputs[3]=="down"){
      print("####################");
      startEmergency();
    }

  }
  if(inputs.length==4){
    inputs=[];
  }
}