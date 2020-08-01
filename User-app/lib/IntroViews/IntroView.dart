import 'package:chale_chalo/Authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'pages.dart';

class Intro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IntroState();
  }
}

class IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: IntroViewsFlutter(
          pages,
          skipText: Text(
            "Skip",
            style: TextStyle(color: Colors.black),
          ),
          doneText: Text(
            "Done",
            style: TextStyle(color: Colors.black),
          ),
          onTapDoneButton: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Register(),
              ),
              (r) => false, //MaterialPageRoute
            );
          },
          onTapSkipButton: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Register(),
              ),
              (r) => false, //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
