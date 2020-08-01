import 'dart:async';

import 'package:chale_chalo/Authentication/loginPage.dart';
import 'package:chale_chalo/Authentication/register.dart';
import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/NewUserDetail/NewUserInfo.dart';
import 'package:chale_chalo/SerchDestination/searchDestination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../main.dart';

var _PhoneNumber = "";
var cameFrom = "";
class OtpScreen extends StatefulWidget {
  OtpScreen(phoneNumber, came) {
    _PhoneNumber = phoneNumber;
    cameFrom = came;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OtpScreenState();
  }


}
enum PhoneAuthState {
  Started,
  CodeSent,
  CodeResent,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut
}

BuildContext context1;
class OtpScreenState extends State<OtpScreen> {
  bool verifyingOtp = false;
  var newNumber = "";
  var otp = "";
  var errorMssg = "";
  BuildContext _context;
  bool doneBtnStatus = false;
  var dialogErrorNumber = 0;
  var dialogErrorNumberMssg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startPhoneAuth(_PhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    context1 = context;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: YELLOW,
        body: ListView(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: H * .07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: H * .15,
                      child: Image.asset("assets/logo_black.png"),
                    ),
                    SizedBox(
                      height: H * .05,
                    ),
                    Container(
                        height: H * .08,
                        child: Text(
                          "Verify Phone Number",
                          style: TextStyle(
                              fontSize: H * .03, fontWeight: FontWeight.bold),
                        )),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(H * .02),
                      margin: EdgeInsets.symmetric(horizontal: H * .02),
                      decoration: BoxDecoration(
                          color: YELLOW_DULL,
                          borderRadius: BorderRadius.circular(H * .02),
                          boxShadow: [
                            BoxShadow(color: Colors.grey[700], blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("A 6-Digit OTP sent to your number"),
                              Text(
                                _PhoneNumber,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: H * .08,
                          ),
                          OTPTextField(
                            length: 6,
                            width: W,
                            fieldStyle: FieldStyle.box,
                            fieldWidth: W * .7 / 6,
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              otp = val;
                            },
                            onCompleted: (val) {
                              otp = val;
                            },
                          ),
                          SizedBox(
                            height: H * .03,
                          ),
                          Text(errorMssg, style: TextStyle(color: red),),
                          SizedBox(
                            height: H * .01,
                          ),
                          RaisedButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(H)),
                            child: Container(
                              width: W * .7,
                              alignment: Alignment.center,
                              height: H * .05,
                              child: (verifyingOtp)
                                  ? SpinKitRing(
                                color: YELLOW,
                                size: H * .03,
                                lineWidth: H * .003,
                              )
                                  : Text(
                                "SUBMIT",
                                style: TextStyle(
                                    fontSize: H * .025, color: YELLOW),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                verifyingOtp = true;
                              });
                              signIn();
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: H * .03),
                            child: GestureDetector(
                              onTap: () {
                                if (cameFrom == "Register") {
                                  Navigator.pushAndRemoveUntil(
                                      context, MaterialPageRoute(
                                      builder: (ctx) => Register()
                                  ), (route) => false);
                                }
                                else {
                                  Navigator.pushAndRemoveUntil(
                                      context, MaterialPageRoute(
                                      builder: (ctx) => LoginPage()
                                  ), (route) => false);
                                }
                              },
                              child: Text(
                                "Change Number",
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: H * .08,
          margin: EdgeInsets.symmetric(horizontal: H * .02),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[600], width: 2))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't Receive OTP ?  ",
                style: TextStyle(fontSize: H * .018),),
              GestureDetector(
                  onTap: () {
                    startPhoneAuth(_PhoneNumber);
                    Toast.show("New Otp sent to your number", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  },
                  child: Text("Resend OTP", style: TextStyle(fontSize: H * .018,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.blue),)),
            ],
          ),
        ),
      ),
    );
  }

  startPhoneAuth(String number) {
    instantiate(phoneNumber: number);
  }

  signIn() async {
    print(otp);
    if (otp.length != 6) {
      //  TODO: show error
      setState(() {
        errorMssg = "Invalid OTP";
        verifyingOtp = false;
      });
    }
    else {
      var value = await signInWithPhoneNumber(smsCode: otp);
    }
  }

  static var _authCredential, actualCode, phone, status;
  static StreamController<String> statusStream =
  StreamController.broadcast();
  static StreamController<PhoneAuthState> phoneAuthState =
  StreamController.broadcast();
  Stream stateStream = phoneAuthState.stream;

  instantiate({String phoneNumber}) async {
    assert(phoneNumber != null);
    phone = phoneNumber;
    print(phone);
    startAuth();
  }

  startAuth() {
    statusStream.stream
        .listen((String status) => print("PhoneAuth: " + status));
    addStatus('Phone auth started');
    FireBase.auth
        .verifyPhoneNumber(
        phoneNumber: phone.toString(),
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      setState(() {

      });
      addStatus('Code sent');
    }).catchError((error) {
      addStatus(error.toString());
    });
  }

  final PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
    actualCode = verificationId;
    addStatus("\nEnter the code sent to " + phone);
    addState(PhoneAuthState.CodeSent);
  };

  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    actualCode = verificationId;
    addStatus("\nAuto retrieval time out");
    addState(PhoneAuthState.AutoRetrievalTimeOut);
  };

  PhoneVerificationFailed verificationFailed
      (AuthException authException) {
    PhoneVerificationFailed val;
    addStatus('${authException.message}');
    addState(PhoneAuthState.Error);
    var val1 = 0;
    if (authException.message.contains('phone number')) {
      setState(() {
        errorMssg = "Invalid Number";
      });
    }
    else if (authException.message.contains('Network')) {
      setState(() {
        errorMssg = "Check Internet Connection";
      });
    }
    else {
      setState(() {
        errorMssg = "Something went wrong! Please try again";
      });
    }

    return val;
  }

  PhoneVerificationCompleted verificationCompleted =
      (AuthCredential auth) {
    addStatus('Auto retrieving verification code');

    FireBase.auth.signInWithCredential(auth).then((AuthResult value) {
      if (value.user != null) {
        addStatus(status = 'Authentication successful');
        addState(PhoneAuthState.Verified);
        onAuthenticationSuccessful();
      } else {
        addState(PhoneAuthState.Failed);
        addStatus('Invalid code/invalid authentication');
      }
    }).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus('Something has gone wrong, please try later $error');
    });
  };

  Future<String> signInWithPhoneNumber({String smsCode}) async {
    _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    FireBase.auth
        .signInWithCredential(_authCredential)
        .then((AuthResult result) async {
      addStatus('Authentication successful');
      addState(PhoneAuthState.Verified);
      onAuthenticationSuccessful();
      return "Verified";
    }).catchError((error) {
      setState(() {
        errorMssg = "Invalid Otp";
        verifyingOtp = true;
      });
      addState(PhoneAuthState.Error);
      addStatus(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
    });
    return "Not Verified";
  }

  static onAuthenticationSuccessful() async {
    if (cameFrom == "Register") {
      var db = Firestore.instance;
      db.collection("AllUsers").document(_PhoneNumber).setData({
        "name": name,
        "phoneNumber": _PhoneNumber,
        "emergencyNo1": "",
        "emergencyNo2": "",
        "email": "",
        "allBookings": [],
        "avtar": "",
        "avtarPath": "",
      }).whenComplete(() async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("name", name);
        pref.setString("phone", phoneNumber);
        Navigator.pushAndRemoveUntil(context1, MaterialPageRoute(
            builder: (ctx) => NewUserInfo()
        ), (route) => false);
      });
    }
    else {
      var db = Firestore.instance;
      db.collection("AllUsers").document(_PhoneNumber).get().then((value) {
        SharedPreferences.getInstance().then((pref) {
          pref.setString("name", value.data["name"]);
          pref.setString("phone", value.data["phoneNumber"]);
          pref.setString("DpPath", value.data["avtarPath"]);
          Navigator.pushAndRemoveUntil(context1, MaterialPageRoute(
              builder: (ctx) => SearchDestination()
          ), (route) => false);
        });
      });
    }
  }

  saveUser() async {

  }

  static addState(PhoneAuthState state) {
    print(state);
    phoneAuthState.sink.add(state);
  }

  static void addStatus(String s) {
    statusStream.sink.add(s);
    print(s);
  }

}

class FireBase {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static instantiate() {
  }
}