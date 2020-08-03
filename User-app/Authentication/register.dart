import 'package:chale_chalo/Authentication/loginPage.dart';
import 'package:chale_chalo/Authentication/otpScreen.dart';
import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/Constants/countries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../main.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RegisterHome();
  }
}

class RegisterHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

var name = "";
var phoneNumber = "";
class RegisterState extends State<RegisterHome> {
  var errorName = 0;
  String errorNameMssg = "";
  String mainErrormssg = "";
  var countryCode = "+91";
  var showNumber = "";
  var errorPhoneNumber = 0;
  var errorPhoneMssg = "";
  String x = "Sign Up";
  bool checking = false;
  String code = '+91';
  @override
  Widget build(BuildContext context1) {
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
                      borderRadius: BorderRadius.circular(H * .02)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: H * .04, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Sign Up With Your Phone Number",
                        style: TextStyle(
                            fontSize: H * .02, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: H * .015),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(H),
                            boxShadow: [
                              BoxShadow(blurRadius: 10, color: Colors.black26)
                            ]),
                        child: TextField(
                          maxLength: 20,
                          cursorColor: Colors.black,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              labelText: "Name",
                              prefixIcon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(H),
                                  borderSide: BorderSide(
                                      color:
                                      errorName == 0 ? Colors.black : red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(H),
                                  borderSide: BorderSide(
                                      color:
                                      errorName == 0 ? Colors.black : red)),
                              labelStyle: TextStyle(
                                color: errorName == 0 ? Colors.black : red,
                                fontSize: H * .02,
                              ),
                              contentPadding: EdgeInsets.all(H * .02),
                              counterStyle: TextStyle(
                                  color: errorName == 0 ? Colors.black : red),
                              counterText: errorNameMssg),
                          onChanged: (val1) {
                            var val = val1.toString().trim();
                            setState(() {
                              var count = 0;
                              for (var i in val.split('')) {
                                if (i.contains(RegExp(r'[a-z]')) ||
                                    i.contains(RegExp(r'[A-Z]')) ||
                                    i.contains(' ')) {
                                  count++;
                                }
                              }
                              if (val.contains(RegExp(r'[0-9]'))) {
                                errorName = 1;
                                errorNameMssg = "Use valid letters only";
                              } else if (count == val.length && count > 0) {
                                name = val;
                                errorName = -0;
                                errorNameMssg = "";
                              } else if (val.isEmpty) {
                                errorName = 1;
                                errorNameMssg = "Can't left this field empty";
                              } else {
                                errorName = 1;
                                errorNameMssg = "Use valid letters only";
                              }
                            });
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _changeCountry(context1);
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
                                    phoneNumber = val.replaceAll(" ", "");
                                    showNumber = val;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: H * .01,
                      ),
                      Text(mainErrormssg, style: TextStyle(color: red),),
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
                              "SIGN UP",
                              style: TextStyle(
                                  fontSize: H * .025,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            if (errorPhoneNumber == 0 && errorName == 0
                                && phoneNumber
                                    .trim()
                                    .length != 0 && name.trim() != "") {
                              setState(() {
                                checking = true;
                              });
                              checkAlreadyRegisterd(context1);
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
                            "Already Registered? ",
                            style: TextStyle(
                                fontSize: H * .017,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context1,
                                    MaterialPageRoute(
                                        builder: (ctx) => LoginPage()));
                              },
                              child: Text(
                                "Try Sign In",
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

  checkAlreadyRegisterd(context) {
    var db = Firestore.instance;
    db.collection("AllUsers").getDocuments().then((value) {
      var count = 0;
      for (var i in value.documents) {
        if (i.documentID == phoneNumber) {
          count++;
          break;
        }
      }
      if (count != 0) {
        setState(() {
          mainErrormssg = "Already Registered. Try Sign In";
          checking = false;
        });
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (ctx) =>
                    OtpScreen(phoneNumber, "Register")
            ), (Route<dynamic> r) => false);
      }
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
