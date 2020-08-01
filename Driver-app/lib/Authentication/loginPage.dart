
import 'package:chalechalo/Constants/constants.dart';
import 'package:chalechalo/Constants/countries.dart';
import 'package:chalechalo/DriverHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final FirebaseAuth _auth=FirebaseAuth.instance;
  var errorEmail = 0;
  var errorPassword = 0;
  var errorPasswordMssg = "";
  var errorEmailMssg = "";
  var _email="";
  var _password="";
  var mainError="";
  String x = "Sign Up";
  bool checking = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      home: Scaffold(
          backgroundColor: YELLOW,
          body: Container(
            height: H,
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
                      color: YELLOW_ACCENT,
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
                      Container(

                        margin: EdgeInsets.symmetric(horizontal: H * .015),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(H),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10, color: Colors.black26)
                            ]),
                        child:TextField(
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
                        ) ,
                      ),
                      Container(

                        margin: EdgeInsets.symmetric(horizontal: H * .015),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(H),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10, color: Colors.black26)
                            ]),
                        child:TextField(
                          cursorColor: Colors.black,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              labelText: "Password",
                              prefixIcon: Icon(
                                FontAwesomeIcons.key,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(H),
                                  borderSide: BorderSide(
                                      color: errorPassword == 0
                                          ? Colors.black
                                          : red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(H),
                                  borderSide: BorderSide(
                                      color: errorPassword == 0
                                          ? Colors.black
                                          : red)),
                              labelStyle: TextStyle(
                                color: errorPassword == 0 ? Colors.black : red,
                                fontSize: H * .02,
                              ),
                              contentPadding: EdgeInsets.all(H * .02),
                              counterStyle: TextStyle(
                                  color:
                                  errorPassword == 0 ? Colors.black : red),
                              counterText: errorPasswordMssg),
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
                                _password = val;
                                errorPassword = 0;
                                errorPasswordMssg = "";
                              } else if (val.isEmpty) {
                                errorPassword = 1;
                                errorPasswordMssg =
                                "Can't left this field empty";
                              }
                            });
                          },
                        ) ,
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
                            if (_email.length != 0 && errorEmail ==
                                0 && _password.length!=0 && errorPassword==0) {
                              signIn(_email, _password);
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
                            "Unable to login? Contact to admin!",
                            style: TextStyle(
                                fontSize: H * .017,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),

                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

 signIn(String email, String password) async
  {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user=result.user;
      if(result.additionalUserInfo.isNewUser){
        setState(() {
          mainError="You have not registered yet";
        });
      }
      else{
        getProfileData();
      }
    } catch (e) {
      print(e.toString());
      if(e.toString().contains("ERROR_INVALID_EMAIL")){
        setState(() {
          mainError="Inavalid Email ID";
          checking=false;
        });
      }
      else if(e.toString().contains("ERROR_USER_NOT_FOUND")){
        setState(() {
          mainError="Email Id or Password incorrect";
          checking=false;
        });
      }
    }
  }
  getProfileData(){
    Future.delayed(Duration(seconds: 0),(){
      var db=Firestore.instance;
      String x;
      db.collection("DelhiDrivers").document(UID).get().then((value){
        profileData=ProfileData(
          value.data["Name"],
          value.data["Number"],
          value.data["BusNumber"],
          value.data["BusRegistrationNumber"],
          value.data["from"],
          value.data["to"],
        );
        getStops();
        print(profileData);
      });
    });
  }
  getStops(){
    var db=Firestore.instance;
    db.collection("DelhiBus").document(profileData.busRegistrationNumber).get()
        .then((value){
      print(value.data);
      for(var i in value.data["Stops"]){
        Stops.add(i["StopName"].toString());
      }
      db.collection("Stops").document("Delhi").get().then((value){
        for(var i in Stops) {
          for (var j in value.data["AllStops"]) {
            if(i.toLowerCase()==j["Name"].toString().toLowerCase()){
              StopsDetail.add([
                i,
                j["Latitude"],
                j["Longitude"]
              ]);
              break;
            }
          }
        }
      });
      if(mounted){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (ctx)=>DriverHomePage()
      ), (route) => false);
      }
    });
  }

}
