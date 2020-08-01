import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/SerchDestination/searchDestination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chale_chalo/Navigation/showNavigation.dart';
import 'package:chale_chalo/Navigation/showJourneyNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../main.dart';

class PreviousBooking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PreviousBookingState();
  }
}

class PreviousBookingState extends State<PreviousBooking> {
  var booking;
  var empty = false;
  var date;
  @override
  void initState() {
    super.initState();
    getData();
  }
  ticketVerifiedStream(String transactionId, String busNo, String from, String to) async {
    var db = Firestore.instance;
    await for (var snapshot in db.collection("AllUsers").document(
        PHONE)
        .snapshots()) {
      for (var i in snapshot.data["allBookings"]) {
        if (i["transactionId"] == transactionId && i["isVerified"] == true) {
          print("You can now navigate");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowJourneyNavigationPage(busNo: busNo, from: from, to: to)));
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Bookings",
                style: TextStyle(color: YELLOW),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.yellow,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: (empty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: W,
                          height: W - 50,
                          child: Image.asset(
                            "assets/noData.png",
                            fit: BoxFit.contain,
                          )),
                      Text(
                        "No Booking Found",
                        style: TextStyle(
                            fontSize: H * .025, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: H * .01, vertical: H * .03),
                        child: RaisedButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(H)),
                          child: Container(
                            width: W,
                            alignment: Alignment.center,
                            height: H * .05,
                            child: Text(
                              "Book Your First Ride",
                              style:
                                  TextStyle(fontSize: H * .02, color: YELLOW),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => SearchDestination()),
                                (route) => false);
                          },
                        ),
                      ),
                    ],
                  )
                : (booking == null)
                    ? SpinKitRing(
                        size: H * .07,
                        lineWidth: H * .005,
                        color: Colors.black,
                      )
                    : ListView.builder(
                        itemCount: booking.length,
                        itemBuilder: (ctx, index) {
                          var i = booking.length - 1 - index;
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(H * .01),
                                padding: EdgeInsets.all(H * .01),
                                width: W,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(H * .02),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          blurRadius: 10),
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                                child: QrImage(
                                                  data: booking[i]
                                                      ["transactionId"],
                                                  version: QrVersions.auto,
                                                  size: H * .15,
                                                ),
                                                onTap: () {
                                                  if(!booking[i]['isVerified']){
                                                    ticketVerifiedStream(booking[i]["transactionId"], booking[i]["busNumber"], booking[i]["from"], booking[i]["to"]);
                                                  }
                                                  
                                                  showDialog(
                                                      context: context,
                                                      builder: (ctx) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(H *
                                                                          .02)),
                                                          title: Text(
                                                            "Booking Detail",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    H * .023),
                                                          ),
                                                          content: Container(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        booking[i]
                                                                            [
                                                                            "from"],
                                                                        style: TextStyle(
                                                                            fontSize: H *
                                                                                .02,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                          "To"),
                                                                      Text(
                                                                          booking[i]
                                                                              [
                                                                              "to"],
                                                                          style: TextStyle(
                                                                              fontSize: H * .02,
                                                                              fontWeight: FontWeight.bold))
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      H * .015,
                                                                ),
                                                                Container(
                                                                  width: W * .5,
                                                                  height:
                                                                      W * .5,
                                                                  child:
                                                                      QrImage(
                                                                    data: booking[
                                                                            i][
                                                                        "transactionId"],
                                                                    version:
                                                                        QrVersions
                                                                            .auto,
                                                                    size:
                                                                        H * .15,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      H * .01,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      H * .005,
                                                                ),
                                                                Container(
                                                                  child: Column(
                                                                    children: [
                                                                      Text((';'.allMatches(booking[i]["transactionId"]).length ==
                                                                              7)
                                                                          ? "Amount Paid"
                                                                          : "Amount To Be Paid"),
                                                                      Text(
                                                                        "${booking[i]["amount"]} ₹",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: H * .03),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      H * .02,
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          "Date",
                                                                          style:
                                                                              TextStyle(fontSize: H * .022)),
                                                                      Text(
                                                                        booking[i]
                                                                            [
                                                                            "date"],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: H * .017),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      H * .01,
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          "Bus Number",
                                                                          style:
                                                                              TextStyle(fontSize: H * .022)),
                                                                      Text(
                                                                        booking[i]
                                                                            [
                                                                            "busNumber"],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: H * .017),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      H * .01,
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          "Driver Name",
                                                                          style:
                                                                              TextStyle(fontSize: H * .022)),
                                                                      Text(
                                                                        booking[i]
                                                                            [
                                                                            "driverName"],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: H * .017),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      H * .01,
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          "Driver Contact",
                                                                          style:
                                                                              TextStyle(fontSize: H * .022)),
                                                                      Text(
                                                                        booking[i]
                                                                            [
                                                                            "driverNumber"],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: H * .017),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      H * .02,
                                                                ),
                                                                (date ==
                                                                        booking[i]
                                                                            [
                                                                            "date"])
                                                                    ? Container(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            RaisedButton(
                                                                          color:
                                                                              YELLOW,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(H)),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                H * .05,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "TRACK BUS",
                                                                                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => ShowNavigationPage(busNo: booking[i]['busNumber'], from:booking[i]['from'], to:booking[i]['to'])));
                                                                          },
                                                                        ),
                                                                      )
                                                                    : Center()
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                }),
                                          ],
                                        ),
                                        Container(
                                          width: W * .92 - H * .18,
                                          margin:
                                              EdgeInsets.only(left: H * .015),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: H * .01,
                                              ),
                                              Text(
                                                "Transaction Id",
                                                textAlign: TextAlign.start,
                                              ),
                                              Container(
                                                width: W * .8 - H * .18,
                                                child: Text(
                                                  (';'
                                                              .allMatches(booking[
                                                                      i][
                                                                  "transactionId"])
                                                              .length ==
                                                          7)
                                                      ? '   ' +
                                                          booking[i][
                                                                  "transactionId"]
                                                              .substring(booking[
                                                                              i]
                                                                          [
                                                                          "transactionId"]
                                                                      .lastIndexOf(
                                                                          ';') +
                                                                  1)
                                                      : '   N/A',
                                                  //
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: H * .016),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.all(H * .01),
                                                width: W * .9 - H * .15,
                                                margin: EdgeInsets.only(
                                                    top: H * .01),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            H * .02)),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      booking[i]["from"],
                                                      style: TextStyle(
                                                          fontSize: H * .02,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text("To"),
                                                    Text(booking[i]["to"],
                                                        style: TextStyle(
                                                            fontSize: H * .02,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: W * .9 - H * .13,
                                                margin: EdgeInsets.only(
                                                    top: H * .01),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Booked On",
                                                      style: TextStyle(
                                                          fontSize: H * .017),
                                                    ),
                                                    Text(
                                                      "${booking[i]["date"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: H * .017),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: H * .03,
                                top: H * .03,
                                child: Text(
                                  "₹ ${booking[i]["amount"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: H * .03),
                                ),
                              )
                            ],
                          );
                        },
                      )));
  }

  getData() {
    var db = Firestore.instance;
    db.collection("AllUsers").document(PHONE).get().then((value) {
      setState(() {
        var dateParse = DateTime.parse(DateTime.now().toString());
        var formattedDate =
            "${dateParse.day}/${dateParse.month}/${dateParse.year}";
        date = formattedDate.toString();
        if (value.data["allBookings"].length==0) {
          setState(() {
            empty = true;
          });
        } else {
          setState(() {
            booking = value.data["allBookings"];
          });
          //print(booking);
          print(booking.length);
        }
      });
    });
  }
}
