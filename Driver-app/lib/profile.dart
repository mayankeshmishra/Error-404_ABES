import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
              width: 100,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Richa Srivastava",
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
              "7838049418",
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
              color: Colors.white30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.directions_bus, color: Colors.amber),
                title: Text(
                  "Bus Registration Number",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
                trailing: Text(
                  "UP14 DA 4598",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
              ),
            ),
            Card(
              color: Colors.white30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.label_important, color: Colors.amber),
                title: Text(
                  "Bus Number",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
                trailing: Text(
                  "986",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
              ),
            ),
            Card(
              color: Colors.white30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.place, color: Colors.amber),
                title: Text(
                  "From",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
                trailing: Text(
                  "Dilshad Garden",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
              ),
            ),
            Card(
              color: Colors.white30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.pin_drop, color: Colors.amber),
                title: Text(
                  "To",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
                trailing: Text(
                  "Jhilmil",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
