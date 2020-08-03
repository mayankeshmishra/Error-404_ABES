import 'package:flutter/material.dart';
import 'package:chalechalo/drawer.dart';
import 'package:chalechalo/Constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PassengerCount extends StatefulWidget {
  @override
  _PassengerCountState createState() => _PassengerCountState();
}

class _PassengerCountState extends State<PassengerCount> {
  //int currentStopIndex = index;
  var passengerDataAfterIndex = [];
  bool loaded = true;
  @override
  void initState() {
    super.initState();
    passengerStream(index);
  }

  passengerStream(int index) async {
    var db = Firestore.instance;
    await for (var snapshot in db
        .collection("DelhiBus")
        .document(profileData.busRegistrationNumber)
        .snapshots()) {
      if (snapshot.data["upstream"] == true) {
        passengerDataAfterIndex = [];
        for (var i = index; i < snapshot.data["Stops"].length; i++) {
          passengerDataAfterIndex.add({
            "name": snapshot.data["Stops"][i]["StopName"],
            "passenger": snapshot.data["capacity"]-snapshot.data["Stops"][i]["Passenger"]
          });
        }
      } else {
        passengerDataAfterIndex = [];
        for (var i = index - 1; i >= 0; i--) {
          passengerDataAfterIndex.add({
            "name": snapshot.data["Stops"][i]["StopName"],
            "passenger": snapshot.data["capacity"]-snapshot.data["Stops"][i]["Passenger"]
          });
        }
      }
      if (this.mounted){
 setState((){
  loaded=false;
 });
}
    }
    
  }

  Widget buildList(context) {
    emergencyContext=context;
    return ListView.builder(
        itemCount: passengerDataAfterIndex.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              leading: Text(passengerDataAfterIndex[i]['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              trailing: Text(passengerDataAfterIndex[i]['passenger'].toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.amber,
          title: Center(
            child: Text(
              'Allowed Passengers',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cached),
              onPressed: () {
                passengerStream(index);
              },
            )
          ],
        ),
        drawer: drawer(context),
        body: Container(
          color: Colors.amber[300],
          child: Column(children: <Widget>[
            Material(
              color: Colors.black,
              child: ListTile(
                leading: Text('Current Stop',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.amber,
                        fontWeight: FontWeight.w500)),
                title: Text("  :",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold)),
                trailing: Text('Palika Kendra',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Material(
              color: Colors.amber[200],
              child: ListTile(
                dense: true,
                leading: Text('Stop Name',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                trailing: Text('Allowed Passengers',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            loaded ? Center() : Expanded(child: buildList(context))
          ]),
        ),
      ),
    );
  }
}
