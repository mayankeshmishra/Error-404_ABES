import 'package:chalechalo/Constants/constants.dart';
import 'package:chalechalo/DriverHomePage.dart';
import 'package:chalechalo/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

const backCamera = 'BACK CAMERA';

class VerifyPassenger extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VerifyPassengerState();
}

class _VerifyPassengerState extends State<VerifyPassenger> {
  bool pressed = false;
  var qrText = '';
  var info = [];
  var index = 0;
  var H;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool eligibleTicket = false;
  bool usedTicket = false;
  String otp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //verifyTransactionId("Mayankesh Mishra;+917905084484;UP72R1889;Palika Kendra;Clock Tower;3;45.0;1595340862256");
  }

  @override
  Widget build(BuildContext context) {
    H=MediaQuery.of(context).size.height;
    emergencyContext = context;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text(
            'Verify Ticket',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      drawer: drawer(context),
      body: QRView(
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

floatingActionButton:
    FloatingActionButton.extended(
      icon: Icon(
        Icons.person_add,
        color: Colors.amber,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(H * .02),
                ),
                backgroundColor: Colors.amber,
                titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Enter OTP  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: H * .03,
                          color: Colors.white),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.all(0),
                content: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(H * .02),
                        bottomLeft: Radius.circular(H * .02)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Container(
                        height:40,
                        child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: new InputDecoration(
                                  labelText: "OTP",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  setState(() {
                                    otp=value;
                                  });
                                },
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(H)),
                            child: Container(
                              height: H * .05,
                              child: Center(
                                child: Text(
                                  "Validate",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              verifyOtp(otp);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      label: Text(
        'Verify OTP',
        style: TextStyle(
          color: Colors.amber,
        ),
      ),
      foregroundColor: Colors.white,
      backgroundColor: Colors.black87,
    )
    );
    
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        print(qrText);
        verifyTransactionId(qrText);
        this.controller.dispose();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  verifyTransactionId(String transactionId) {
    var dateParse = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    String date = formattedDate.toString();
    double H = MediaQuery.of(context).size.height;
    var db = Firestore.instance;
    db
        .collection("DelhiBus")
        .document(profileData.busRegistrationNumber)
        .collection("tickets")
        .document(date)
        .get()
        .then((value) {
      var count = 0;
      var isVerified = 0;
      info = value.data["allTickets"];
      //print(info[1]["transactionId"].toString()==transactionId);
      for (var i = 0; i < info.length; i++) {
        if (info[i]["transactionId"].toString() == transactionId) {
          index = i;
          count++;
          if (info[i]["isVerified"] == true) {
            isVerified = 1;
          }
          break;
        }
      }
      if (count == 0) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(H * .02),
                ),
                backgroundColor: Colors.red,
                titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "INVALID TICKET  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: H * .03,
                          color: Colors.white),
                    ),
                    Icon(Icons.warning, color: Colors.white)
                  ],
                ),
                contentPadding: EdgeInsets.all(0),
                content: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(H * .02),
                        bottomLeft: Radius.circular(H * .02)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'No Ticket with this Transaction Id found. Kindly check that you are in the correct bus and are travelling on the correct date.',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(H)),
                            child: Container(
                              height: H * .05,
                              child: Center(
                                child: Text(
                                  "DISMISS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => DriverHomePage()),
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      } else if (count > 0) {
        print(isVerified);
        if (isVerified == 0) {
          String reuse = transactionId;
          bool paid = false;
          var name = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var mobile = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var busNo = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var from = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var to = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var noOfPassengers = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          print(reuse);
          var amount = "";
          var id = "";
          if ((';'.allMatches(transactionId).length == 7)) {
            paid = true;
            print(reuse);
            amount = reuse.substring(0, reuse.indexOf(';'));
            print(reuse);
            reuse = reuse.substring(reuse.indexOf(';') + 1);
            id = reuse.substring(0);
          } else {
            amount = reuse.substring(0);
          }
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(H * .02),
                  ),
                  backgroundColor: paid ? Colors.green : Colors.amber,
                  titlePadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        paid ? "TRANSACTION VERIFIED  " : "OFFLINE TICKET  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: H * .023,
                            color: paid ? Colors.white : Colors.black),
                      ),
                      paid
                          ? Icon(Icons.check_circle, color: Colors.white)
                          : Icon(Icons.attach_money, color: Colors.black)
                    ],
                  ),
                  contentPadding: EdgeInsets.all(0),
                  content: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(H * .02),
                          bottomLeft: Radius.circular(H * .02)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Ticket Details',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Name : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(name,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Mobile No. : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(mobile,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Bus No. : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(busNo,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('From : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(from,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('To : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(name,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Tickets : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(noOfPassengers,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Amount : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text('₹ ' + amount,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        paid ? Divider() : Center(),
                        paid
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Transaction Id : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  Text(id,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            : Center(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: double.infinity,
                            child: RaisedButton(
                              color: paid ? Colors.green : Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(H)),
                              child: Container(
                                height: H * .05,
                                child: Center(
                                  child: Text(
                                    paid ? "VERIFY" : "COLLECT CASH",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => DriverHomePage()),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
          eligibleTicket = true;
          isCashPaid(mobile, transactionId);
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(H * .02),
                  ),
                  backgroundColor: Colors.red,
                  titlePadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "INVALID TICKET  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: H * .03,
                            color: Colors.white),
                      ),
                      Icon(Icons.warning, color: Colors.white)
                    ],
                  ),
                  contentPadding: EdgeInsets.all(0),
                  content: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(H * .02),
                          bottomLeft: Radius.circular(H * .02)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          'Ticket Already Used !',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(H)),
                              child: Container(
                                height: H * .05,
                                child: Center(
                                  child: Text(
                                    "DISMISS",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => DriverHomePage()),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      }
    });
  }

  verifyOtp(String otpRecieved) {
    print(otp);
    var dateParse = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    String date = formattedDate.toString();
    double H = MediaQuery.of(context).size.height;
    var transactionId = "";
    var db = Firestore.instance;
    db
        .collection("DelhiBus")
        .document(profileData.busRegistrationNumber)
        .collection("tickets")
        .document(date)
        .get()
        .then((value) {
      var count = 0;
      var isVerified = 0;
      info = value.data["allTickets"];
      //print(info[1]["transactionId"].toString()==transactionId);
      for (var i = 0; i < info.length; i++) {
        var id = info[i]["transactionId"].toString();
        if ((';'.allMatches(id).length == 7)) {
          var otp = id.substring((id.indexOf(';') + 4), (id.indexOf(';') + 6)) +
              id.substring(id.length - 4);
          if (otpRecieved == otp) {
            index = i;
            transactionId = id;
            count++;
            if (info[i]["isVerified"] == true) {
              isVerified = 1;
            }
            break;
          }
        }
      }
      if (count == 0) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(H * .02),
                ),
                backgroundColor: Colors.red,
                titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "INVALID OTP  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: H * .03,
                          color: Colors.white),
                    ),
                    Icon(Icons.warning, color: Colors.white)
                  ],
                ),
                contentPadding: EdgeInsets.all(0),
                content: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(H * .02),
                        bottomLeft: Radius.circular(H * .02)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'No Ticket with this OTP found. Kindly check that you are in the correct bus and are travelling on the correct date.',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(H)),
                            child: Container(
                              height: H * .05,
                              child: Center(
                                child: Text(
                                  "DISMISS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => DriverHomePage()),
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      } else if (count > 0) {
        print(isVerified);
        if (isVerified == 0) {
          String reuse = transactionId;
          bool paid = false;
          var name = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var mobile = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var busNo = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var from = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var to = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          var noOfPassengers = reuse.substring(0, reuse.indexOf(';'));
          reuse = reuse.substring(reuse.indexOf(';') + 1);
          print(reuse);
          var amount = "";
          var id = "";
          if ((';'.allMatches(transactionId).length == 7)) {
            paid = true;
            print(reuse);
            amount = reuse.substring(0, reuse.indexOf(';'));
            print(reuse);
            reuse = reuse.substring(reuse.indexOf(';') + 1);
            id = reuse.substring(0);
          }
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(H * .02),
                  ),
                  backgroundColor: paid ? Colors.green : Colors.amber,
                  titlePadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        paid ? "TRANSACTION VERIFIED  " : "OFFLINE TICKET  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: H * .03,
                            color: paid ? Colors.white : Colors.black),
                      ),
                      paid
                          ? Icon(Icons.check_circle, color: Colors.white)
                          : Icon(Icons.attach_money, color: Colors.black)
                    ],
                  ),
                  contentPadding: EdgeInsets.all(0),
                  content: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(H * .02),
                          bottomLeft: Radius.circular(H * .02)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Ticket Details',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Name : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(name,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Mobile No. : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(mobile,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Bus No. : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(busNo,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('From : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(from,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('To : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(name,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Tickets : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(noOfPassengers,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Amount : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text('₹ ' + amount,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        paid ? Divider() : Center(),
                        paid
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Transaction Id : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  Text(id,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            : Center(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: double.infinity,
                            child: RaisedButton(
                              color: paid ? Colors.green : Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(H)),
                              child: Container(
                                height: H * .05,
                                child: Center(
                                  child: Text(
                                    paid ? "VERIFY" : "COLLECT CASH",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => DriverHomePage()),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
          eligibleTicket = true;
          isCashPaid(mobile, transactionId);
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(H * .02),
                  ),
                  backgroundColor: Colors.red,
                  titlePadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "INVALID OTP  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: H * .03,
                            color: Colors.white),
                      ),
                      Icon(Icons.warning, color: Colors.white)
                    ],
                  ),
                  contentPadding: EdgeInsets.all(0),
                  content: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(H * .02),
                          bottomLeft: Radius.circular(H * .02)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          'Ticket Already Used !',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(H)),
                              child: Container(
                                height: H * .05,
                                child: Center(
                                  child: Text(
                                    "DISMISS",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => DriverHomePage()),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      }
    });
  }

  isCashPaid(String phoneNumber, String transactionId) {
    var dateParse = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    String date = formattedDate.toString();
    var db = Firestore.instance;
    info[index]["isVerified"] = true;
    db
        .collection("DelhiBus")
        .document(profileData.busRegistrationNumber)
        .collection("tickets")
        .document(date)
        .setData({"allTickets": info}).then((value) {
      print("Ticket Verified");
      db.collection("AllUsers").document(phoneNumber).get().then((value) {
        var bookings = value.data["allBookings"];
        for (var i = 0; i < bookings.length; i++) {
          if (bookings[i]["transactionId"].toString() == transactionId) {
            bookings[i]["isVerified"] = true;
            break;
          }
        }
        db
            .collection("AllUsers")
            .document(phoneNumber)
            .setData({"allBookings": bookings}).whenComplete(() {
          print("&&&&&&&&&&&&&&&&&&777");
          print("data saved in AllUsers collection");
        });
      });
    });
  }
}
