import 'package:chale_chalo/Authentication/otpScreen.dart';
import 'package:chale_chalo/Authentication/register.dart';
import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/Constants/countries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../main.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoginPageHome();
  }
}

class LoginPageHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<LoginPageHome> {
  var errorName = 0;
  String errorNameMssg = "";
  String mainError = "";
  var _name = "";
  var _phoneNumber = "";
  var showNumber = "";
  var errorPhoneNumber = 0;
  var errorPhoneMssg = "";
  String code = '+91';
  String x = "Sign Up";
  bool checking = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BackgroundGradient,
            child: ListView(
              children: [
                Container(
                  height: H * .25,
                  padding: EdgeInsets.all(H * .05),
                  width: W,
                  child: Image.asset("assets/logo_black.png"),
                ),
                Container(
                  height: H * .45,
                  width: W,
                  margin: EdgeInsets.symmetric(horizontal: H * .015),
                  decoration: BoxDecoration(
                      color: YELLOW_DULL,
                      boxShadow: [
                        BoxShadow(color: Colors.grey[700], blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(H * .02)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: H * .04, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Please Sign In to your account",
                        style: TextStyle(
                            fontSize: H * .02, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: H * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _changeCountry(context);
                              },
                              child: Container(
                                  width: W * .17,
                                  height: H * .065,
                                  margin: EdgeInsets.only(left: H * .015),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(H),
                                        bottomLeft: Radius.circular(H),
                                        topRight: Radius.circular(H * .3),
                                        bottomRight: Radius.circular(H * .3),),
                                      color: Colors.white70,
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      boxShadow: [
                                        BoxShadow(blurRadius: 10,
                                            color: Colors.black26)
                                      ]
                                  ),
                                  child: Text(code, style: TextStyle(
                                      fontWeight: FontWeight.bold),)
                              )),
                          SizedBox(width: W * .01,),
                          Container(
                            width: W * .69,
                            margin: EdgeInsets.only(right: H * .015),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(H),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10, color: Colors.black26)
                                ]),
                            child: TextField(
                              maxLength: 20,
                              cursorColor: Colors.black,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText: "Phone Number",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(H),
                                          bottomRight: Radius.circular(H),
                                          topLeft: Radius.circular(H * .3),
                                          bottomLeft: Radius.circular(H * .3)),
                                      borderSide: BorderSide(
                                          color: errorPhoneNumber == 0
                                              ? Colors.black
                                              : red)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(H),
                                          bottomRight: Radius.circular(H),
                                          topLeft: Radius.circular(H * .3),
                                          bottomLeft: Radius.circular(H * .3)),
                                      borderSide: BorderSide(
                                          color: errorPhoneNumber == 0
                                              ? Colors.black
                                              : red)),
                                  labelStyle: TextStyle(
                                    color:
                                    errorPhoneNumber == 0 ? Colors.black : red,
                                    fontSize: H * .02,
                                  ),
                                  contentPadding: EdgeInsets.all(H * .02),
                                  counterStyle: TextStyle(
                                      color: errorPhoneNumber == 0
                                          ? Colors.black
                                          : red),
                                  counterText: errorPhoneMssg),
                              onChanged: (val1) {
                                var val = code + val1.toString().trim();
                                var count = 0;
                                setState(() {
                                  for (var i in val.substring(1).split('')) {
                                    if (i.contains(RegExp(r'[0-9]')) ||
                                        i.contains(" ")) {
                                      count++;
                                    }
                                  }
                                  if (val.length == 0) {
                                    errorPhoneNumber = 1;
                                    errorPhoneMssg =
                                    "Can,t left this field empty";
                                  } else if (val.substring(0, 1) != "+") {
                                    errorPhoneNumber = 1;
                                    errorPhoneMssg = "Type Country code also";
                                  } else if (count < val.length - 1) {
                                    errorPhoneNumber = 1;
                                    errorPhoneMssg = "Use numbers only";
                                  } else if (val
                                      .replaceAll(" ", "")
                                      .length > 15) {
                                    errorPhoneNumber = 1;
                                    errorPhoneMssg = "Input is too long";
                                  } else {
                                    errorPhoneNumber = 0;
                                    errorPhoneMssg = "";
                                    _phoneNumber = val.replaceAll(" ", "");
                                    showNumber = val;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(mainError, style: TextStyle(color: red),),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: H * .015),
                        child: RaisedButton(
                          elevation: 20,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(H)),
                          child: Container(
                            width: W,
                            height: H * .06,
                            alignment: Alignment.center,
                            child: (checking) ?
                            SpinKitRing(
                              color: YELLOW,
                              size: H * .03,
                              lineWidth: H * .003,
                            )
                                : Text(
                              "SIGN IN",
                              style: TextStyle(
                                  fontSize: H * .025,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            //demo
                            if (_phoneNumber.length == 13 && errorPhoneNumber ==
                                0) {
                              checkNewUser(context);
                              setState(() {
                                checking = true;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: H * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not Registered Yet? ",
                            style: TextStyle(
                                fontSize: H * .017,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => Register()));
                              },
                              child: Text(
                                "Try Sign Up",
                                style: TextStyle(
                                    fontSize: H * .017,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue[700],
                                    decoration: TextDecoration.underline,
                                    letterSpacing: 1),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  checkNewUser(context) {
    var db = Firestore.instance;
    db.collection("AllUsers").getDocuments().then((value) {
      var count = 0;
      for (var i in value.documents) {
        if (i.documentID == _phoneNumber) {
          count++;
          break;
        }
      }
      if (count == 0) {
        setState(() {
          mainError = "not Registered yet, first Register yourself";
          checking = false;
        });
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (ctx) =>
                    OtpScreen(_phoneNumber, "Login")
            ), (Route<dynamic> r) => false);
      }
    });
  }

  saveTransaction() {
    var date;
    var transactionId;
    var busNumber;
    var driverName;
    var driverNumber;
    var startingStop;
    var destinationStop;
    var amount;
    var db = Firestore.instance;
    var info = [];
    db.collection("AllUsers").document(PHONE).get().then((value) {
      if (value.data["allBookings"] == "") {
        info = [];
      }
      else {
        info.add(
            {
              "transactioId": transactionId,
              "date": date,
              "amount": amount,
              "from": startingStop,
              "to": destinationStop,
              "busNumber": busNumber,
              "driverName": driverName,
              "driverNumber": driverNumber
            }
        );
      }
      db.collection("AllUsers").document(PHONE).updateData(
          {"allBookings": info}).whenComplete(() {
        ///////////////////   task to be performed after data saved
      });
    });
  }

  Future<void> _changeCountry(context) async {
    var filteredCountries = countries;
    await showDialog(
      context: context,
      child: StatefulBuilder(
        builder: (ctx1, setState) =>
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(H * .02)),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        labelText: 'Search by Country Name',
                      ),
                      onChanged: (value) {
                        setState(() {
                          filteredCountries = countries
                              .where((country) =>
                              country['name'].toLowerCase().contains(value))
                              .toList();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredCountries.length,
                        itemBuilder: (ctx, index) =>
                            Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Text(
                                    filteredCountries[index]['flag'],
                                    style: TextStyle(fontSize: H * .022),
                                  ),
                                  title: Text(
                                    filteredCountries[index]['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  trailing: Text(
                                    filteredCountries[index]['dial_code'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      code =
                                      filteredCountries[index]['dial_code'];
                                    });
                                    Navigator.of(ctx1).pop();
                                  },
                                ),
                                Divider(thickness: 1),
                              ],
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
    setState(() {});
  }
}
