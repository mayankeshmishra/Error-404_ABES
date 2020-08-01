import 'package:chale_chalo/Constants/constants.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class PaymentFailed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentFailedState();
  }
}

class PaymentFailedState extends State<PaymentFailed> {
  Image image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateQR();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                              "UK07BR1625",
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
                                    "Anand Vihar Terminal",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: H * .018),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "To",
                                  ),
                                  Text(
                                    "Kaushambi Bus Stand",
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
                                "2",
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
                              Icons.cancel,
                              size: H * .09,
                              color: Colors.red,
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
            padding: EdgeInsets.only(left: H * .02),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(H * .008)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: H * .005, left: H * .01),
                        child: Text(
                          "BOOKED BY",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: H * .02,
                              color: Colors.green),
                        )),
                  ],
                ),
                SizedBox(height: H * .01),
                Container(
                  margin: EdgeInsets.only(left: H * .015),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mr. Ankit Tripathi",
                        style: TextStyle(
                            fontSize: H * .02, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: H * .01),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: H * .01),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(H * .02),
                      topLeft: Radius.circular(H * .02))),
              width: W,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: H * .18,
                    width: H * .18,
                    padding: EdgeInsets.all(H * .01),
                    child: Image.asset("assets/sad.png"),
                  ),
                  SizedBox(
                    height: H * .04,
                  ),
                  Text(
                    "YOUR TICKET BOOKING FAILED",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: H * .022,
                        color: Colors.red),
                  ),
                  Text(
                    "Please Try Again",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: H * .02,
                        color: Colors.black),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
          height: H * .07,
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "Try Again",
              style: TextStyle(fontSize: H * .02, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  generateQR() async {}
}
