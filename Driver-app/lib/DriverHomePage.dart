//passenger_page_final

import 'package:chalechalo/Authentication/loginPage.dart';
import 'package:chalechalo/drawer.dart';
import 'package:chalechalo/history.dart';
import 'package:chalechalo/main.dart';
import 'package:chalechalo/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chalechalo/passengerForm/passenger.dart';
import 'package:chalechalo/passengerForm/empty_state.dart';
import 'package:chalechalo/passengerForm/form.dart';
import 'Constants/constants.dart';
import 'package:chalechalo/Add-Verify-Passengers/verifyPassenger.dart';
import 'package:chalechalo/Add-Verify-Passengers/addPassenger.dart';
class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int selectedIndex = 1;
  final widgetOptions = [
    VerifyPassenger(),
    AddPassengerPage()
  ];
 
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(child: widgetOptions.elementAt(selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle), title: Text('Verify Ticket')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add), title: Text('Add Passenger')),
          ],
          currentIndex: selectedIndex,
          fixedColor: Colors.amber,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.black,
          onTap: onItemTapped,
        ),
        
        drawer: drawer(context),
      ),
    );
  }


}
