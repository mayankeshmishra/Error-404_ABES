import 'package:flutter/material.dart';
import './main.dart';

void main() => runApp(
      MaterialApp(
        home: LoginPage(),
      ),
    );

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Color(0xFFffbf00),
        //   title: Text('My App'),
        //   centerTitle: true,
        //   leading: IconButton(
        //       icon: Icon(
        //         Icons.list,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {}),
        // ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 80),
            Image.asset(
              'assets/logo.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Sign in to your account',
              style: TextStyle(
                  color: Colors.white, fontSize: 15, letterSpacing: 1.5),
            ),
            SizedBox(height: 10),
            Card(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
              color: Colors.amber,
              child: ListTile(
                dense: true,
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              color: Colors.amber,
              child: ListTile(
                dense: true,
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 100),
                        height: 50,
                        child: RaisedButton(
                          textColor: Colors.black,
                          color: Colors.amber,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 2,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical:60),
                  child: RaisedButton(
                    padding:EdgeInsets.symmetric(horizontal:100,vertical: 10),
                    textColor: Colors.black,
                    color: Colors.amber,
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
