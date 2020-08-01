import 'package:flutter/material.dart';


class DestinationPage extends StatelessWidget {
  final appTitle = 'Destination';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Destination(title: appTitle),
    );
  }
}

class Destination extends StatelessWidget {
  final String title;
  Destination({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,50.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 24.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                            Stack(
                              children: <Widget>[
                                // Stroked text as border.
                                Text(
                                  'From - Rajendra Chowk',
                                  style: TextStyle(
                                    fontSize: 25,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 6
                                      ..color = Colors.black54,
                                  ),
                                ),
                                // Solid text as fill.
                                Text(
                                  'From - Rajendra Chowk',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          "assets/downward_arrow.gif",
                          height: 160,
                          width: 160,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 24.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                            Stack(
                              children: <Widget>[
                                // Stroked text as border.
                                Text(
                                  'To- Dilshad Garden',
                                  style: TextStyle(
                                    fontSize: 25,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 6
                                      ..color = Colors.black54,
                                  ),
                                ),
                                // Solid text as fill.
                                Text(
                                  'To- Dilshad Garden',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  )
                ],
              ),
              Card(
                child: InkWell(
                  splashColor: Colors.yellow.withAlpha(30),
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
                          child: Text(
                            '5 July 2020',
                            style: TextStyle(
                              color: Colors.limeAccent,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0))),
                      ),
                      const Divider(
                        color: Colors.yellow,
                        height: 0,

                        thickness: 2,
                        indent: 110,
                        endIndent: 110,
                      ),
                      Container(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '10:20 AM',
                            style: TextStyle(
                              color: Colors.limeAccent,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25.0))),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  onPressed: () {},
                  textColor: Colors.white,
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
