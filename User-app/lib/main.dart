import 'dart:async';

import 'package:chale_chalo/Authentication/otpScreen.dart';
import 'package:chale_chalo/IntroViews/IntroView.dart';
import 'package:chale_chalo/SerchDestination/searchDestination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailgun/mailgun.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import 'Constants/constants.dart';

void main() => runApp(
  MaterialApp(
    title: 'Navigation Basics',
    home: MyHomePage(),
  ),
);
var H, W, T;

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePageHome();
  }
}

class MyHomePageHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePageHome> {
  var x = 0.0;
  var context1;
  var smsSending = true;
  var sendingReport = "Sending Emergency Report";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  animate() {
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        x = .15;
        navigate();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    context1 = context;
    H = MediaQuery
        .of(context)
        .size
        .height;
    W = MediaQuery
        .of(context)
        .size
        .width;
    T = MediaQuery
        .of(context)
        .textScaleFactor * H - 200;
    print(T);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Stack(
          children: [
            Container(
              child: Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  height: H * x,
                  width: H * x,
                  child: Image.asset("assets/logo.png"),
                ),
              ),
            ),
            Positioned(
              right: H * .02,
              top: H * .05,
              child: emergency(context),
            )
          ],
        ),
        bottomNavigationBar: Container(
            height: H * .1,
            child: SpinKitRing(
              color: YELLOW,
              lineWidth: H * .002,
              size: H * .04,
            )),
      ),

    );
  }

  navigate() {
    Future.delayed(Duration(seconds: 2), () {
      FireBase.auth.currentUser().then((value) {
        if (value == null) {
          Navigator.pushAndRemoveUntil(context1, MaterialPageRoute(
              builder: (ctx) => Intro()
          ), (route) => false);
        }
        else {
          Navigator.pushAndRemoveUntil(context1, MaterialPageRoute(
              builder: (ctx) => SearchDestination()
          ), (route) => false);

        }
      });
    });
  }

  // ticketVerifiedStream(String transactionId) async {
  //   var db = Firestore.instance;
  //   await for (var snapshot in db.collection("AllUsers").document(
  //       "+917905084484")
  //       .snapshots()) {
  //     for (var i in snapshot.data["allBookings"]) {
  //       if (i["transactionId"] == transactionId && i["isVerified"] == true) {
  //         print("You can now navigate");
  //       }
  //     }
  //   }
  // }

  Widget emergency(context) {
    return Container(
      height: H * .05,
      width: W * .55,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(H),
      ),
      child: GestureDetector(
        onTap: () {
          showDialog(context: context, builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(H * .02)),
              title: Text("Emergency Alert!", textAlign: TextAlign.center,),
              content: Container(
                width: W,
                height: H * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Do you really want to report emergency.",
                      textAlign: TextAlign.center,),
                    Text(
                      "Fake report will result a serious action against you.",
                      textAlign: TextAlign.center,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(ctx);
                          },
                          child: Container(
                            width: W * .25,
                            height: H * .04,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: H * .01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(H),
                                color: Colors.black
                            ),
                            child: Text(
                              "NO", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var ctx1;
                            Navigator.pop(ctx);
                            showDialog(context: context,
                                builder: (ctx2) {
                                  ctx1 = ctx2;
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            H * .02)),
                                    title: Text(sendingReport,
                                      textAlign: TextAlign.center,),
                                    content: StatefulBuilder(
                                      builder: (stateContext, setState) {
                                        return Container(
                                            height: H * .1,
                                            child: SpinKitRing(
                                              color: Colors.black,
                                              size: H * .05,
                                              lineWidth: H * .003,
                                            ));
                                      },
                                    ),
                                  );
                                });
                            var mailgun = MailgunMailer(
                                domain: "sandboxd2b482b8e25e491fa0f8d48dd0edd898.mailgun.org",
                                apiKey: "1592c4e8c965a881adc322dfe504d9ad-ffefc4e4-0cf24894");
                            mailgun.send(
                                from: "chalechalo@gmail.com",
                                to: ["ankiisnap@gmail.com"],
                                subject: "Test email",
                                text: "Hello World").then((value) {
                              print(value.message);
                            });
                            var twilioFlutter = TwilioFlutter(
                                accountSid: 'AC7fbf2f1200e9786e6ee7eb3b4cadfed0',
                                // replace *** with Account SID
                                authToken: '4ae0d018ca9e1593f625193468e0e001',
                                // replace xxx with Auth Token
                                twilioNumber: '+12565734690' // replace .... with Twilio Number
                            );
                            var numbers = ["+919555656766", "+919569550325"];
                            for (var i = 0; i < numbers.length; i++) {
                              Future.delayed(Duration(seconds: 3), () {
                                twilioFlutter.sendSMS(
                                    toNumber: numbers[i],
                                    messageBody: 'hello world').then((value) {
                                  print(value.toString());
                                });
                              });
                            }

                            Future.delayed(Duration(seconds: 7), () {
                              var db = Firestore.instance;
                              db.collection("DelhiBus")
                                  .document("UK07BR1628")
                                  .get()
                                  .then((value) {
                                var emergency = value.data["Emergency"];
                                emergency.add(PHONE);
                                db.collection("DelhiBus")
                                    .document("UK07BR1628")
                                    .updateData(
                                    {"Emergency": emergency}
                                )
                                    .whenComplete(() {
                                  Navigator.pop(ctx1);
                                  showDialog(context: context, builder: (ctx) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              H * .02)),
                                      title: Text("Emergency Report Sent",
                                        textAlign: TextAlign.center,),
                                      content: Container(
                                        height: H * .25,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            Text("Thank you for reporting!",
                                              textAlign: TextAlign.center,),
                                            SizedBox(height: H * .01,),
                                            Text(
                                                "We have sent your ride details and live location link with -"),
                                            Text("+918808289700,"),
                                            Text("+919555656766 and"),
                                            Text("Admin"),
                                            SizedBox(height: H * .01,),
                                            Text("We will respond to you soon"),

                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                });
                              });
                            });
                          },
                          child: Container(
                            width: W * .25,
                            height: H * .04,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: H * .01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(H),
                                color: Colors.red[700]
                            ),
                            child: Text(
                              "YES", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(FontAwesomeIcons.exclamationTriangle, color: Colors.white,),
            Text("Report Emergency", style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  } 

}