import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/PaymentStatus/paymentSuccess.dart';
import 'package:chale_chalo/PaymentStatus/paymentFailed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class PaymentPage extends StatefulWidget {
  final String amount;
  final String busNo;
  final String driverName;
  final String driverNumber;
  final String startingStop;
  final String destinationStop;
  final int noOfTickets;

  PaymentPage(
      {this.amount,
      this.busNo,
      this.driverName,
      this.driverNumber,
      this.startingStop,
      this.destinationStop,
      this.noOfTickets});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  WebViewController _webViewController;
  bool _loadingPayment = true;

  String _responseStatus = STATUS_LOADING;
  var transactionId = Uuid().v1();
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      PHONE = pref.get("phone");
      EMAIL = pref.get("email");
    });
  }

  saveTransaction(
      {transactionId,
      busNumber,
      driverName,
      driverNumber,
      startingStop,
      destinationStop,
      amount}) {
    var dateParse = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    String date = formattedDate.toString();

    var db = Firestore.instance;
    var info = [];
    db.collection("AllUsers").document(PHONE).get().then((value) {
      if (value.data["allBookings"] == "") {
        info = [];
      } else {
        info = List.from(value.data["allBookings"]);
      }
      print(info);
      info.add({
        "transactionId": transactionId,
        "date": date,
        "amount": amount,
        "from": startingStop,
        "to": destinationStop,
        "busNumber": busNumber,
        "driverName": driverName,
        "driverNumber": driverNumber,
        "isVerified": false
      });

      print(info);
      db
          .collection("AllUsers")
          .document(PHONE)
          .updateData({"allBookings": info});
    });
  }

    saveTransactionBusSide(String transactionId){
    var db=Firestore.instance;
    var dateParse = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    String date = formattedDate.toString();
    db.collection("DelhiBus").document(widget.busNo).
    collection("tickets").getDocuments().then((value){
      var count=0;
      var docData;
      for(var element in value.documents) {
        if (element.documentID == date){
          docData=element.data["allTickets"];
          count++;
          break;
        }
      }
      if(count==0){
        db.collection("DelhiBus").document(widget.busNo).
        collection("tickets").document(date).setData({"allTickets":[{
          "transactionId": transactionId,
          "isVerified":false,
        }]}).whenComplete((){
          print("Ticket Saved in Bus Side (NEW)");
        });
      }
      else{
        docData.add({"transactionId": transactionId,
          "isVerified":false,});
        db.collection("DelhiBus").document(widget.busNo).
        collection("tickets").document(date).updateData({"allTickets":docData}).whenComplete((){
          print("Ticket Saved in Bus Side (OLD)");
        });
      }
    });
  }

   passengerCount(fromStop, toStop) {
    var db = Firestore.instance;
    db.collection("DelhiBus").document(widget.busNo).get().then((value) {
      var info = [];
      info = value.data["Stops"];
      if (value.data["upstream"] == true) {
        var k = 0;
        for (var i = 0; i < value.data["Stops"].length; i++) {
          if (value.data["Stops"][i]["StopName"].toString().toLowerCase() ==
              fromStop.toLowerCase()) {
            k = i;
            break;
          }
        }
        for (var i = k; i < value.data["Stops"].length; i++) {
          if (info[i]["StopName"].toString().toLowerCase() ==
              toStop.toLowerCase()) {
            break;
          }
          else {
            info[i]["Passenger"] += widget.noOfTickets;
          }
        }
      }
      else {
        var k = 0;
        for (var i = info.length - 1; i >= 0; i--) {
          if (value.data["Stops"][i]["StopName"].toString().toLowerCase() ==
              fromStop.toLowerCase()) {
            k = i;
            break;
          }
        }
        for (var i = k; i >= 0; i--) {
          if (info[i]["StopName"].toString().toLowerCase() !=
              toStop.toLowerCase()) {
            info[i]["Passenger"] += widget.noOfTickets;
          }
          else {
            break;
          }
        }
      }

      db.collection("DelhiBus").document(widget.busNo).updateData(
          {"Stops": info}).whenComplete(() {
        print("done");
      });
    });
  }

  String _loadHTML() {
    return "<html> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='$PAYMENT_URL'><input type='hidden' name='orderID' value='ORDER_${DateTime.now().millisecondsSinceEpoch}'/>" +
        "<input  type='hidden' name='custID' value='$transactionId' />" +
        "<input  type='hidden' name='amount' value='${widget.amount}' />" +
        "<input type='hidden' name='custEmail' value='$EMAIL' />" +
        "<input type='hidden' name='custPhone' value='$PHONE' />" +
        "</form> </body> </html>";
  }

  void getData() {
    _webViewController
        .evaluateJavascript("document.body.innerText")
        .then((data) {
      var decodedJSON = jsonDecode(data);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      final checksumResult = responseJSON["status"];
      final paytmResponse = responseJSON["data"];
      if (paytmResponse["STATUS"] == "TXN_SUCCESS") {
        if (checksumResult == 0) {
          _responseStatus = STATUS_SUCCESSFUL;
        } else {
          _responseStatus = STATUS_CHECKSUM_FAILED;
        }
      } else if (paytmResponse["STATUS"] == "TXN_FAILURE") {
        _responseStatus = STATUS_FAILED;
      }
      this.setState(() {});
    });
  }

  Widget getResponseScreen({qrData}) {
    switch (_responseStatus) {
      case STATUS_SUCCESSFUL:
        passengerCount(widget.startingStop, widget.destinationStop);
        saveTransaction(
            transactionId: qrData,
            busNumber: widget.busNo,
            driverName: widget.driverName,
            driverNumber: widget.driverNumber,
            startingStop: widget.startingStop,
            destinationStop: widget.destinationStop,
            amount: widget.amount);
        saveTransactionBusSide(qrData);
        return PaymentSuccess(
          qrData: qrData,
          busNo: widget.busNo,
          from: widget.startingStop,
          to: widget.destinationStop,
          noOfTickets: widget.noOfTickets,
          driverName: widget.driverName,
          driverNumber: widget.driverNumber,
        );
      case STATUS_CHECKSUM_FAILED:
        return CheckSumFailedScreen();
      case STATUS_FAILED:
        return PaymentFailed(
          busNo: widget.busNo,
          from: widget.startingStop,
          to: widget.destinationStop,
          noOfTickets: widget.noOfTickets,
        );
    }
    return PaymentSuccess(
      qrData: qrData,
          busNo: widget.busNo,
          from: widget.startingStop,
          to: widget.destinationStop,
          noOfTickets: widget.noOfTickets,
          driverName: widget.driverName,
          driverNumber: widget.driverNumber,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _webViewController = null;
  }

  @override
  Widget build(BuildContext context) {
    final String qrData = NAME+';'+PHONE+';'+widget.busNo+';'+widget.startingStop+';'+widget.destinationStop+';'+widget.noOfTickets.toString()+';'+widget.amount+';'+DateTime.now().millisecondsSinceEpoch.toString();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              child: WebView(
                debuggingEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                  _webViewController.loadUrl(
                      new Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                          .toString());
                },
                onPageFinished: (page) {
                  if (page.contains("/process")) {
                    if (_loadingPayment) {
                      this.setState(() {
                        _loadingPayment = false;
                      });
                    }
                  }
                  if (page.contains("/paymentReceipt")) {
                    getData();
                  }
                },
              ),
            ),
            (_loadingPayment)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(),
            (_responseStatus != STATUS_LOADING)
                ? Center(child: getResponseScreen(qrData: qrData))
                : Center()
          ],
        ),
      ),
    );
  }
}

class CheckSumFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Oh Snap!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Problem Verifying Payment, If you balance is deducted please contact our customer support and get your payment verified!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
