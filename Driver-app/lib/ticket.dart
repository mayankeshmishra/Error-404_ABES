import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TicketPage extends StatelessWidget {
  final appTitle = 'Destination';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyTicketPage(title: appTitle),
    );
  }
}

class MyTicketPage extends StatelessWidget {
  final String title;
  MyTicketPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
        style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: Image.asset('assets/logo_black.png'),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(

        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),)
                    ),
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.directions_bus, color: Colors.amber),
                title: Text(
                  "Ticket",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 20,
                      color: Colors.amber),
                ),
              ),
            ),Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(),
              margin: EdgeInsets.symmetric( horizontal: 25.0),
              child: ListTile(
                leading: Text(
                  "Bus Number \n 796",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
                title: Text(
                  "Aman Sharma",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 17,
                      color: Colors.amber),
                ),
                trailing: Text(
                  "20 July 2020 \n 19:26",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
              ),
            ),Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(),
              margin: EdgeInsets.symmetric( horizontal: 25.0),
              child: ListTile(
                leading: Text(
                  "Rajendra Chowk",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
                title: Icon(Icons.arrow_forward, color: Colors.amber),
                trailing: Text(
                  "Dilshad Garden",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
              ),
            ),Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0))
                    ),
              margin: EdgeInsets.symmetric( horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.people, color: Colors.amber),
                title: Text(
                  "1 Adult",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
                trailing: Text(
                  "Paid: \$900",
                  style: TextStyle(
                      fontFamily: ' Roboto-italic',
                      fontSize: 15,
                      color: Colors.amber),
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  onPressed: () {},
                  textColor: Colors.black87,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.amber,
                          Colors.orange,
                          Colors.amber,
                        ],
                      ),
                    ),
                    padding:
                    const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                    child:
                    const Text('Proceed', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: 30,
                bottom: 10,
              ),
              color: Colors.amber,
              child: Column(
                children: <Widget>[
                  Container(
                    width:100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(
                          'assets/driver.png',
                      ),
                        fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    'Mayankesh Mishra',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '8634374634',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.black87,
              child: ListTile(
                leading: Icon(Icons.person,
                  color: Colors.amber,),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.amber,
                  ),
                ),
                onTap: null,
              ),
            ),
            Container(
              color: Colors.black87,
              child: ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.amber,
                ),
                title: Text(
                  'Account History',
                  style: TextStyle(
                      fontSize: 18,
                    color: Colors.amber,
                  ),
                ),
                onTap: null,
              ),
            ),
            Container(
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.only(bottom:277.0),
                child: ListTile(
                  title: Text(
                    '',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  onTap: null,
                ),
              ),
            ),
            Container(
              color: Colors.amber,
              child: ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                onTap: null,
              ),
            ),
          ],
        )
      ),
    );
  }
}
