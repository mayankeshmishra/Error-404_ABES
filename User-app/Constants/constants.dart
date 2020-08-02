import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
File AVTAR;
List<String> numbersForSMS = [];

getNumbersToSMS() {
  var db = Firestore.instance;
  db.collection("AllUsers").document(PHONE).get().then((value) {
    numbersForSMS.add(value.data["emergencyNo1"].toString());
    numbersForSMS.add(value.data["emergencyNo2"].toString());
    numbersForSMS.add("+919555656766");
  });
}