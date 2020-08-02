import 'package:chalechalo/Constants/constants.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.amber, fontFamily: 'Lobster'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              width: double.infinity,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              profileData.name,
              style: TextStyle(
                color: Colors.amber,
                fontFamily: 'Roboto-boldItallic',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              profileData.number,
              style: TextStyle(
                color: Colors.amber,
                fontFamily: ' Roboto-italic',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Card(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.directions_bus, color: Colors.black),
                title: Text(
                  "Bus-Reg-No",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                trailing: Text(
                  profileData.busRegistrationNumber,
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Card(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.place, color: Colors.black),
                title: Text(
                  "From",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                trailing: Text(
                  profileData.from,
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Card(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.pin_drop, color: Colors.black),
                title: Text(
                  "To",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                trailing: Text(
                  profileData.to,
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
