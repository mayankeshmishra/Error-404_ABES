import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/Drawer/drawer.dart';
import 'package:chale_chalo/Navigation/showNavigation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chale_chalo/Navigation/showJourneyNavigation.dart';
import '../main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentSuccess extends StatefulWidget {
   final qrData;
  final from;
  final to;
  final busNo;
  final noOfTickets;
  final driverNumber;
  final driverName;
  PaymentSuccess({this.qrData, this.from, this.to, this.busNo, this.noOfTickets,@required this.driverNumber, this.driverName});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentSuccessState();
  }
}

class PaymentSuccessState extends State<PaymentSuccess> {
 

  void initState() {
  super.initState();
  ticketVerifiedStream(widget.qrData, widget.busNo, widget.from, widget.to);
  }
  

  ticketVerifiedStream(String transactionId, String busNo, String from, String to) async {
      var db = Firestore.instance;
      await for (var snapshot in db.collection("AllUsers").document(
          PHONE)
          .snapshots()) {
        for (var i in snapshot.data["allBookings"]) {
          if (i["transactionId"] == transactionId && i["isVerified"] == true) {
            print("You can now navigate");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowJourneyNavigationPage(busNo: busNo, from: from, to: to, driverNumber: widget.driverNumber, driverName: widget.driverName,)));
          }
        }
      }
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: YELLOW,
        elevation: 0,
        title: Text(
          "Ticket Confirmation",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: drawer(context),
      body: Column(
        children: [
          Container(
            height: H * .3,
            width: W,
            margin: EdgeInsets.only(top: H * .015),
            padding: EdgeInsets.symmetric(horizontal: H * .01),
            child: Stack(
              children: [
                Container(
                    height: H * .3,
                    width: W,
                    child: Image.asset(
                      "assets/ticketBg.png",
                      fit: BoxFit.fill,
                    )),
                Container(
                  height: H * .2,
                  width: W,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: H * .02),
                        height: H * .18,
                        width: H * .1,
                        alignment: Alignment.center,
                        child: Image.asset("assets/logo_black.png"),
                      ),
                      Container(
                        height: H * .17,
                        width: W * .95 - H * .1,
                        padding: EdgeInsets.symmetric(horizontal: H * .01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.busNo,
                              style: TextStyle(
                                  fontSize: H * .03,
                                  fontWeight: FontWeight.w900),
                            ),
                            Container(
                              width: W * .9 - H * .1,
                              padding: EdgeInsets.symmetric(vertical: H * .01),
                              margin:
                                  EdgeInsets.symmetric(horizontal: H * .005),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(H * .01),
                                  color: Colors.grey[300]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.from,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: H * .018),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "To",
                                  ),
                                  Text(
                                    widget.to,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: H * .018),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: H * .11,
                    width: W,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: H * .02, horizontal: H * .03),
                          child: Column(
                            children: [
                              Text(
                                widget.noOfTickets.toString(),
                                style: TextStyle(
                                    fontSize: H * .03,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Tickets",
                                  style: TextStyle(
                                      fontSize: H * .018,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800]))
                            ],
                          ),
                        ),
                        Text("Roadways",
                            style: TextStyle(
                                fontSize: H * .02,
                                fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(right: H * .04),
                            child: Icon(
                              Icons.check_circle,
                              size: H * .09,
                              color: Colors.green,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: W,
            margin: EdgeInsets.all(H * .015),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(H * .008)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:W*.04,top:H*0.01 ),
                  child: Row(
                    children: [
                      Text(
                        "BOOKED BY : ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: H * .02,
                            color: Colors.green),
                      ),
                      SizedBox(width:W*.1),
                      Text(
                        NAME,
                        style: TextStyle(
                            fontSize: H * .02, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: H * .01),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: H * .01),
                  child: RaisedButton(
                    color: YELLOW,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(H)),
                    child: Container(
                      width: W * .9,
                      alignment: Alignment.center,
                      child: Text("Track Bus"),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowNavigationPage(busNo:widget.busNo, from: widget.from, to: widget.to,)));
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: H * .01),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(H * .02),
                      topLeft: Radius.circular(H * .02))),
              width: W,
              child: Column(
                children: [
                  Container(
                    height: H * .18,
                    width: H * .18,
                    child: QrImage(
                      data: widget.qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                  SizedBox(
                    height: H * .03,
                  ),
                  Text(
                    "Scan Code for more detail",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: H * .02),
                  ),
                  SizedBox(
                    height: H * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HAVE A SAFE JOURNEY ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: H * .022,
                            color: Colors.green),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.green,
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: H * .07,
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {},
                child: Text(
                  "Save Ticket",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: H * .02,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              height: H * .07,
              width: H * .003,
              color: Colors.black,
            ),
            GestureDetector(
                onTap: () {},
                child: Text(
                  "Cancel Ticket",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: H * .02,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }

}
