import 'package:chalechalo/Constants/constants.dart';
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
  var info=[];
  var index=0;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool eligibleTicket=false;
  bool usedTicket=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyTransactionId("Mayankesh Mishra;+917905084484;UP72R1889;Palika Kendra;Clock Tower;3;45.0;1595340862256");

  }

  @override
  Widget build(BuildContext context) {
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
    );
  }



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
  verifyTransactionId(String transactionId){
    var dateParse = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    String date = formattedDate.toString();
    var db=Firestore.instance;
    db.collection("DelhiBus").document(profileData.busRegistrationNumber)
        .collection("tickets").document(date).get()
    .then((value){
      var count=0;
      var isVerified=0;
      print("***************************************");
      info=value.data["allTickets"];
      print(info[1]["transactionId"].toString()==transactionId);
      for(var i=0;i<info.length;i++){
        if(info[i]["transactionId"].toString()==transactionId){
          index=i;
          count++;
          if(info[i]["isVerified"]==true){
            isVerified=1;
          }
          break;
        }
      }
      if(count==0){
        print("Ticket not found");
      }else if(count>0){
        if(isVerified==0){
          print("Valid Ticket");
          eligibleTicket=true;
          isCashPaid("+917905084484", "Mayankesh Mishra;+917905084484;UP72R1889;Palika Kendra;Clock Tower;3;45.0;1595340862256");
        }
        else{
          print("Ticket allready Used");
        }
      }
    });
  }
  isCashPaid(String phoneNumber,String transactionId){
    var dateParse = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    String date = formattedDate.toString();
    var db=Firestore.instance;
    info[index]["isVerified"]=true;
    db.collection("DelhiBus").document(profileData.busRegistrationNumber)
        .collection("tickets").document(date).setData({"allTickets":info})
        .then((value){
      print("Ticket Verified");
      db.collection("AllUsers").document(phoneNumber).get().then((value){
          var bookings=value.data["allBookings"];
          for(var i=0;i<bookings.length;i++){
            if(bookings[i]["transactionId"].toString()==transactionId){
              bookings[i]["isVerified"]=true;
              break;
            }
          }
          db.collection("AllUsers").document(phoneNumber).setData({"allBookings":bookings})
         .whenComplete((){
           print("&&&&&&&&&&&&&&&&&&777");
           print("data saved in AllUsers collection");
          });
      });
    });
  }
}
