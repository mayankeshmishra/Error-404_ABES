import 'dart:async';

import 'package:chale_chalo/Authentication/otpScreen.dart';
import 'package:chale_chalo/IntroViews/IntroView.dart';
import 'package:chale_chalo/SerchDestination/searchDestination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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


}