import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

const backCamera = 'BACK CAMERA';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  bool pressed = false;
  var qrText = '';
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: Text(
            'Scan User QR',
            style: TextStyle(color: Colors.amber, fontFamily: 'Lobster'),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:40.0, left: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Richa Srivastava \n 7838049418",
                        style: TextStyle(
                          color: Colors.amber,
                          fontFamily: 'Roboto-boldItallic',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.amber,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.06,
            minChildSize: 0.05,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: Colors.amber,
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  controller: scrollController,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return cardsWidget(index);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget cardsWidget(itemIndex) => Center(
          child: Container(
        child: Column(
          children: <Widget>[
            Text(
              "Add Details Manually",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Lobster', fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Passenger 1",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Lobster', fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  fillColor: Colors.black,
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'Passenger Name',
                  labelText: 'Name *',
                  labelStyle: TextStyle(color: Colors.black)),
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.black,
              child: Text("+ Passenger",
                  style: TextStyle(
                    color: Colors.amber,
                    fontFamily: 'Roboto-boldItallic',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                setState(() {});
              },
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 45.0),
              color: Colors.black,
              child: Text("Proceed",
                  style: TextStyle(
                    color: Colors.amber,
                    fontFamily: 'NotosansTc-med',
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {},
            )
          ],
        ),
      ),);

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
