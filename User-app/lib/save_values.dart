import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DBState();
  }
}

class DBState extends State<DB> {
  List<dynamic> stops = [];
  String Data = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
      body: Container(
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (val) {
                Data = val;
              },
            ),
            RaisedButton(
              child: Text("ADD"),
              onPressed: () {
                if (Data != "") {
                  split(Data, context);
                }
              },
            )
          ],
        ),
      ),
    ));
  }

  split(val, context) {
    var info = [];
    stops = [];
    info = val.split(",");
    print(info.length);
    for (var i = 0; i < info.length; i += 4) {
      print(i);
      stops.add({
        "Name": info[i + 1],
        "Latitude": info[i + 2],
        "Longitude": info[i + 3],
        "ID": info[i]
      });
//      print("${info[i]} , ${info[i+1]} , ${info[i+2]} , ${info[i+3]}");
    }

    print(stops[stops.length - 1]);
    var db = Firestore.instance;
    db
        .collection("Stops")
        .document("Delhi")
        .setData({"AllStops": stops}).whenComplete(() {
      Toast.show("Added", context, duration: Toast.LENGTH_LONG);
    });
  }
}
