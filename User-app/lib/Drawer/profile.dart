import 'package:chale_chalo/Constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../main.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  bool editing = false;
  bool edit = false;
  bool enable = false;
  var emailController = TextEditingController();
  var emergencyNumber1 = TextEditingController();
  var emergencyNumber2 = TextEditingController();
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
  var totalBookings;
  Image qrImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              "Profile",
              style: TextStyle(color: YELLOW),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: YELLOW,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            actions: [
              (editing)
                  ? Container(
                      margin: EdgeInsets.only(right: H * .02),
                      child: SpinKitRing(
                        color: YELLOW,
                        size: H * .03,
                        lineWidth: H * .003,
                      ),
                    )
                  : IconButton(
                      icon: (edit)
                          ? Icon(
                              Icons.check,
                              color: YELLOW,
                              size: H * .04,
                            )
                          : Icon(
                              Icons.edit,
                              color: YELLOW,
                            ),
                      onPressed: () {
                        if (edit == false) {
                          setState(() {
                            enable = true;
                            edit = true;
                          });
                        } else {
                          setState(() {
                            enable = false;
                            edit = false;
                            if (!_email.contains("@")) {
                              setState(() {
                                mainError = "Invalid Email ID";
                              });
                            } else if (_phone1 == _phone2) {
                              setState(() {
                                mainError =
                                    "Please enter two different phone number";
                              });
                            } else if (errorEmail == 0 &&
                                errorPhone1 == 0 &&
                                errorPhone2 == 0 &&
                                _email != "" &&
                                _phone1 != "" &&
                                _phone2 != "") {
                              saveData();
                            } else if (_email.trim().length == 0 ||
                                _phone1.trim().length == 0 ||
                                _phone2.trim().length == 0) {
                              setState(() {
                                mainError = "Don't leave any field vacant";
                              });
                            }
                          });
                        }
                      },
                    )
            ],
          ),
          body: Center(
            child: ListView(
              children: [
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    margin: EdgeInsets.only(top: H * .005),
                    height: H * .3,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 10)
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(H * .002),
                          child: Container(
                            height: H * .18,
                            width: H * .18,
                            child: QrImage(
                              data: PHONE,
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              NAME,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: H * .028,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: H * .01,
                            ),
                            Text(
                              PHONE,
                              style: TextStyle(
                                  color: Colors.black, fontSize: H * .018),
                            ),
                            SizedBox(
                              height: H * .015,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: H * .5,
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: (totalBookings == null)
                      ? SpinKitRing(
                          color: YELLOW,
                          size: H * .05,
                          lineWidth: H * .003,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: H * .08,
                              width: W,
                              margin: EdgeInsets.symmetric(horizontal: H * .01),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(H * .025),
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Bookings",
                                    style: TextStyle(
                                        fontSize: H * .024,
                                        fontWeight: FontWeight.bold,
                                        color: YELLOW),
                                  ),
                                  Text(
                                    totalBookings.toString(),
                                    style: TextStyle(
                                        fontSize: H * .024,
                                        fontWeight: FontWeight.bold,
                                        color: YELLOW),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: H * .002,
                              color: YELLOW,
                            ),
                            Container(
                              height: H * .08,
                              width: W,
                              margin: EdgeInsets.symmetric(horizontal: H * .01),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(H * .025),
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: H * .022,
                                        fontWeight: FontWeight.bold,
                                        color: YELLOW),
                                  ),
                                  Container(
                                    width: W * .7,
                                    child: TextField(
                                      controller: emailController,
                                      enabled: enable,
                                      style: TextStyle(
                                        color: YELLOW,
                                      ),
                                      textAlign: TextAlign.end,
                                      cursorColor: YELLOW,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: YELLOW)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: YELLOW)),
                                          counterStyle: TextStyle(
                                              color: errorEmail == 0
                                                  ? Colors.black
                                                  : red),
                                          counterText: errorEmailMssg),
                                      onChanged: (val1) {
                                        var val = val1.toString().trim();
                                        setState(() {
                                          var count = 0;
                                          for (var i in val.split('')) {
                                            if (i.contains(RegExp(r'[a-z]')) ||
                                                i.contains(RegExp(r'[A-Z]')) ||
                                                i.contains(RegExp(r'[0-9]')) ||
                                                i.contains('.') ||
                                                i.contains("@")) {
                                              count++;
                                            }
                                          }
                                          if (count == val.length &&
                                              count > 0) {
                                            _email = val;
                                            errorEmail = -0;
                                            errorEmailMssg = "";
                                          } else if (val.isEmpty) {
                                            errorEmail = 1;
                                            errorEmailMssg =
                                                "Can't left this field empty";
                                          } else {
                                            errorEmail = 1;
                                            errorEmailMssg =
                                                "Use valid letters only";
                                          }
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: H * .002,
                              color: YELLOW,
                            ),
                            Container(
                              height: H * .08,
                              width: W,
                              margin: EdgeInsets.symmetric(horizontal: H * .01),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(H * .025),
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Emergency No. 1",
                                    style: TextStyle(
                                        fontSize: H * .021,
                                        fontWeight: FontWeight.bold,
                                        color: YELLOW),
                                  ),
                                  Container(
                                    width: W * .4,
                                    child: TextField(
                                      controller: emergencyNumber1,
                                      enabled: enable,
                                      style: TextStyle(color: YELLOW),
                                      textAlign: TextAlign.end,
                                      cursorColor: YELLOW,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: YELLOW)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: YELLOW)),
                                          counterStyle: TextStyle(
                                              color: errorPhone1 == 0
                                                  ? Colors.black
                                                  : red),
                                          counterText: errorPhone1Mssg),
                                      onChanged: (val1) {
                                        var val = val1.toString().trim();
                                        var count = 0;
                                        setState(() {
                                          for (var i
                                              in val.substring(1).split('')) {
                                            if (i.contains(RegExp(r'[0-9]')) ||
                                                i.contains(" ")) {
                                              count++;
                                            }
                                          }
                                          if (val.length == 0) {
                                            errorPhone1 = 1;
                                            errorPhone1Mssg =
                                                "Can,t left this field empty";
                                          } else if (val.substring(0, 1) !=
                                              "+") {
                                            errorPhone1 = 1;
                                            errorPhone1Mssg =
                                                "Type Country code also";
                                          } else if (count < val.length - 1) {
                                            errorPhone1 = 1;
                                            errorPhone1Mssg =
                                                "Use numbers only";
                                          } else if (val
                                                  .replaceAll(" ", "")
                                                  .length >
                                              15) {
                                            errorPhone1 = 1;
                                            errorPhone1Mssg =
                                                "Input is too long";
                                          } else {
                                            errorPhone1 = 0;
                                            errorPhone1Mssg = "";
                                            _phone1 = val.replaceAll(" ", "");
                                          }
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: H * .002,
                              color: YELLOW,
                            ),
                            Container(
                              height: H * .08,
                              width: W,
                              margin: EdgeInsets.symmetric(horizontal: H * .01),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(H * .025),
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Emergency No. 2",
                                    style: TextStyle(
                                        fontSize: H * .021,
                                        fontWeight: FontWeight.bold,
                                        color: YELLOW),
                                  ),
                                  Container(
                                    width: W * .45,
                                    child: TextField(
                                      controller: emergencyNumber2,
                                      enabled: enable,
                                      style: TextStyle(color: YELLOW),
                                      textAlign: TextAlign.end,
                                      cursorColor: YELLOW,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: YELLOW)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: YELLOW)),
                                          counterStyle: TextStyle(
                                              color: errorPhone2 == 0
                                                  ? Colors.black
                                                  : red),
                                          counterText: errorPhone2Mssg),
                                      onChanged: (val1) {
                                        var val = val1.toString().trim();
                                        var count = 0;
                                        setState(() {
                                          for (var i
                                              in val.substring(1).split('')) {
                                            if (i.contains(RegExp(r'[0-9]')) ||
                                                i.contains(" ")) {
                                              count++;
                                            }
                                          }
                                          if (val.length == 0) {
                                            errorPhone2 = 1;
                                            errorPhone2Mssg =
                                                "Can,t left this field empty";
                                          } else if (val.substring(0, 1) !=
                                              "+") {
                                            errorPhone2 = 1;
                                            errorPhone2Mssg =
                                                "Type Country code also";
                                          } else if (count < val.length - 1) {
                                            errorPhone2 = 1;
                                            errorPhone2Mssg =
                                                "Use numbers only";
                                          } else if (val
                                                  .replaceAll(" ", "")
                                                  .length >
                                              15) {
                                            errorPhone2 = 1;
                                            errorPhone2Mssg =
                                                "Input is too long";
                                          } else {
                                            errorPhone2 = 0;
                                            errorPhone2Mssg = "";
                                            _phone2 = val.replaceAll(" ", "");
                                          }
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              mainError,
                              style: TextStyle(color: red),
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDate() {
    var db = Firestore.instance;
    db.collection("AllUsers").document(PHONE).get().then((value) {
      setState(() {
        emailController.text = value.data['email'].toString();
        emergencyNumber1.text = value.data['emergencyNo1'].toString();
        emergencyNumber2.text = value.data['emergencyNo2'].toString();
        _email = emailController.text;
        _phone1 = emergencyNumber1.text;
        _phone2 = emergencyNumber2.text;
      });
      if (value.data["allBookings"] == "") {
        setState(() {
          totalBookings = 0;
        });
      } else {
        setState(() {
          totalBookings = value.data["allBookings"].length;
        });
      }
    });
  }

  saveData() {
    setState(() {
      editing = true;
    });
    var db = Firestore.instance;
    db.collection("AllUsers").document(PHONE).updateData({
      "email": emailController.text,
      "emergencyNo1": emergencyNumber1.text,
      "emergencyNo2": emergencyNumber2.text
    }).whenComplete(() {
      setState(() {
        editing = false;
      });
    });
  }
}
