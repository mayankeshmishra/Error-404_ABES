import 'package:chale_chalo/Authentication/register.dart';
import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/Constants/countries.dart';
import 'package:chale_chalo/NewUserDetail/Avtar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class NewUserInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewUserInfoState();
  }
}

class NewUserInfoState extends State<NewUserInfo> {
  var errorEmail = 0;
  var errorEmailMssg = "";
  var errorPhone1 = 0;
  var errorPhone2 = 0;
  var errorPhone1Mssg = "";
  var errorPhone2Mssg = "";
  var _email = "";
  var _phone1 = "";
  var _phone2 = "";
  var mainError = "";
  String code1 = "+91";
  String code2 = "+91";
  bool submitting = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: YELLOW,
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: H * .1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: H * .1,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: H * .05),
                      child: Text(
                        "Personal Information",
                        style: TextStyle(
                            fontSize: H * .03, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: H * .5,
                      width: W,
                      margin: EdgeInsets.symmetric(horizontal: H * .015),
                      decoration: BoxDecoration(
                          color: YELLOW_DULL,
                          borderRadius: BorderRadius.circular(H * .02),
                          boxShadow: [
                            BoxShadow(color: Colors.grey[700], blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Please Enter Few Details"),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: H * .015),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(H),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10, color: Colors.black26)
                                ]),
                            child: TextField(
                              cursorColor: Colors.black,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText: "Email",
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.at,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(H),
                                      borderSide: BorderSide(
                                          color: errorEmail == 0
                                              ? Colors.black
                                              : red)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(H),
                                      borderSide: BorderSide(
                                          color: errorEmail == 0
                                              ? Colors.black
                                              : red)),
                                  labelStyle: TextStyle(
                                    color: errorEmail == 0 ? Colors.black : red,
                                    fontSize: H * .02,
                                  ),
                                  contentPadding: EdgeInsets.all(H * .02),
                                  counterStyle: TextStyle(
                                      color:
                                      errorEmail == 0 ? Colors.black : red),
                                  counterText: errorEmailMssg),
                              onChanged: (val1) {
                                var val = val1.toString().trim();
                                setState(() {
                                  var count = 0;
                                  for (var i in val.split('')) {
                                    if (i.contains(RegExp(r'[a-z]')) ||
                                        i.contains(RegExp(r'[A-Z]')) ||
                                        i.contains(RegExp(r'[0-9]')) ||
                                        i.contains('.') || i.contains("@")) {
                                      count++;
                                    }
                                  }
                                  if (count == val.length && count > 0) {
                                    _email = val;
                                    errorEmail = -0;
                                    errorEmailMssg = "";
                                  } else if (val.isEmpty) {
                                    errorEmail = 1;
                                    errorEmailMssg =
                                    "Can't left this field empty";
                                  } else {
                                    errorEmail = 1;
                                    errorEmailMssg = "Use valid letters only";
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
                                    _changeCountry(context, 0);
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
                                            bottomRight: Radius.circular(
                                                H * .3),),
                                          color: Colors.white70,
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          boxShadow: [
                                            BoxShadow(blurRadius: 10,
                                                color: Colors.black26)
                                          ]
                                      ),
                                      child: Text(code1, style: TextStyle(
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
                                              bottomLeft: Radius.circular(
                                                  H * .3)),
                                          borderSide: BorderSide(
                                              color: errorPhone1 == 0
                                                  ? Colors.black
                                                  : red)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(H),
                                              bottomRight: Radius.circular(H),
                                              topLeft: Radius.circular(H * .3),
                                              bottomLeft: Radius.circular(
                                                  H * .3)),
                                          borderSide: BorderSide(
                                              color: errorPhone1 == 0
                                                  ? Colors.black
                                                  : red)),
                                      labelStyle: TextStyle(
                                        color:
                                        errorPhone1 == 0 ? Colors.black : red,
                                        fontSize: H * .02,
                                      ),
                                      contentPadding: EdgeInsets.all(H * .02),
                                      counterStyle: TextStyle(
                                          color: errorPhone1 == 0
                                              ? Colors.black
                                              : red),
                                      counterText: errorPhone1Mssg),
                                  onChanged: (val1) {
                                    var val = code1 + val1.toString().trim();
                                    var count = 0;
                                    setState(() {
                                      for (var i in val.substring(1).split(
                                          '')) {
                                        if (i.contains(RegExp(r'[0-9]')) ||
                                            i.contains(" ")) {
                                          count++;
                                        }
                                      }
                                      if (val.length == 0) {
                                        errorPhone1 = 1;
                                        errorPhone1Mssg =
                                        "Can,t left this field empty";
                                      } else if (val.substring(0, 1) != "+") {
                                        errorPhone1 = 1;
                                        errorPhone1Mssg =
                                        "Type Country code also";
                                      } else if (count < val.length - 1) {
                                        errorPhone1 = 1;
                                        errorPhone1Mssg = "Use numbers only";
                                      } else if (val
                                          .replaceAll(" ", "")
                                          .length > 15) {
                                        errorPhone1 = 1;
                                        errorPhone1Mssg = "Input is too long";
                                      } else {
                                        errorPhone1 = 0;
                                        errorPhone1Mssg = "";
                                        _phone1 = val.replaceAll(" ", "");
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    _changeCountry(context, 1);
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
                                            bottomRight: Radius.circular(
                                                H * .3),),
                                          color: Colors.white70,
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          boxShadow: [
                                            BoxShadow(blurRadius: 10,
                                                color: Colors.black26)
                                          ]
                                      ),
                                      child: Text(code2, style: TextStyle(
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
                                              bottomLeft: Radius.circular(
                                                  H * .3)),
                                          borderSide: BorderSide(
                                              color: errorPhone2 == 0
                                                  ? Colors.black
                                                  : red)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(H),
                                              bottomRight: Radius.circular(H),
                                              topLeft: Radius.circular(H * .3),
                                              bottomLeft: Radius.circular(
                                                  H * .3)),
                                          borderSide: BorderSide(
                                              color: errorPhone2 == 0
                                                  ? Colors.black
                                                  : red)),
                                      labelStyle: TextStyle(
                                        color:
                                        errorPhone2 == 0 ? Colors.black : red,
                                        fontSize: H * .02,
                                      ),
                                      contentPadding: EdgeInsets.all(H * .02),
                                      counterStyle: TextStyle(
                                          color: errorPhone2 == 0
                                              ? Colors.black
                                              : red),
                                      counterText: errorPhone2Mssg),
                                  onChanged: (val1) {
                                    var val = code2 + val1.toString().trim();
                                    var count = 0;
                                    setState(() {
                                      for (var i in val.substring(1).split(
                                          '')) {
                                        if (i.contains(RegExp(r'[0-9]')) ||
                                            i.contains(" ")) {
                                          count++;
                                        }
                                      }
                                      if (val.length == 0) {
                                        errorPhone2 = 1;
                                        errorPhone2Mssg =
                                        "Can,t left this field empty";
                                      } else if (val.substring(0, 1) != "+") {
                                        errorPhone2 = 1;
                                        errorPhone2Mssg =
                                        "Type Country code also";
                                      } else if (count < val.length - 1) {
                                        errorPhone2 = 1;
                                        errorPhone2Mssg = "Use numbers only";
                                      } else if (val
                                          .replaceAll(" ", "")
                                          .length > 15) {
                                        errorPhone2 = 1;
                                        errorPhone2Mssg = "Input is too long";
                                      } else {
                                        errorPhone2 = 0;
                                        errorPhone2Mssg = "";
                                        _phone2 = val.replaceAll(" ", "");
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Text(mainError, style: TextStyle(color: red),),
                          SizedBox(
                            height: H * .05,
                          ),
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
                                child: (submitting)
                                    ? SpinKitRing(
                                  color: YELLOW,
                                  size: H * .03,
                                  lineWidth: H * .003,
                                ) : Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                      fontSize: H * .025,
                                      fontWeight: FontWeight.w700,
                                      color: YELLOW),
                                ),
                              ),
                              onPressed: () {
                                if (!_email.contains("@")) {
                                  setState(() {
                                    mainError = "Invalid Email ID";
                                  });
                                }
                                else if (_phone1 == _phone2) {
                                  setState(() {
                                    mainError =
                                    "Please enter two different phone number";
                                  });
                                }
                                else if (errorEmail == 0 && errorPhone1 == 0 &&
                                    errorPhone2 == 0
                                    && _email != "" && _phone1 != "" &&
                                    _phone2 != "") {
                                  setState(() {
                                    submitting = true;
                                    saveUserDetail(context);
                                  });
                                }
                                else if (_email
                                    .trim()
                                    .length == 0 || _phone1
                                    .trim()
                                    .length == 0 || _phone2
                                    .trim()
                                    .length == 0) {
                                  setState(() {
                                    mainError = "Don't leave any field vacant";
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveUserDetail(context) {
    var db = Firestore.instance;
    db.collection("AllUsers").document(phoneNumber).updateData(
        {"emergencyNo1": _phone1, "emergencyNo2": _phone2, "email": _email})
        .whenComplete(() {
      setState(() {
        submitting = false;
      });
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (ctx) => Avtar()
      ), (route) => false);
    });
  }

  Future<void> _changeCountry(context, code) async {
    var filteredCountries = countries;
    var ind = code;
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
                                      (ind == 0) ? code1 =
                                      filteredCountries[index]['dial_code']
                                          : code2 =
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
