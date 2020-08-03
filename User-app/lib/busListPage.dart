import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/CustomDatatypes/bus.dart';
import 'package:chale_chalo/Distance/decodeDistance.dart';
import 'package:chale_chalo/Helpers/CarouselCards.dart';
import 'package:chale_chalo/PaymentStatus/PaymentPage.dart';
import 'package:chale_chalo/PaymentStatus/offlineTicket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'Drawer/drawer.dart';

CarouselCard card = CarouselCard();

class BusList extends StatefulWidget {
  final String from;
  final String to;
  final List busList;
  BusList({this.from, this.to, this.busList});
  @override
  State<BusList> createState() => BusListState();
}

class BusListState extends State<BusList> {
  Position position;
  bool positionGot = true;
  double amount = 0;
  int noOfTickets = 1;
  List<String> eta = [];
  List<Bus> busList = [];
  String fromLat, fromLong;
  String toLat, toLong;
  double priceDis;
  int passengers = 30;
  Position _northeastCoordinates;
  Position _southwestCoordinates;
  GoogleMapController mapController;
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    getDistanceMatrix();
    super.initState();
  }

  void _onMapCreated() {
    try {
      if (double.parse(fromLat) <= double.parse(toLat)) {
        _southwestCoordinates = Position(
            latitude: double.parse(fromLat), longitude: double.parse(fromLong));
        _northeastCoordinates = Position(
            latitude: double.parse(toLat), longitude: double.parse(toLong));
      } else {
        _southwestCoordinates = Position(
            latitude: double.parse(toLat), longitude: double.parse(toLong));
        _northeastCoordinates = Position(
            latitude: double.parse(fromLat), longitude: double.parse(fromLong));
      }
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(
                _northeastCoordinates.latitude,
                (_southwestCoordinates.longitude >
                        _northeastCoordinates.longitude)
                    ? _southwestCoordinates.longitude
                    : _northeastCoordinates.longitude),
            southwest: LatLng(
                _southwestCoordinates.latitude,
                (_southwestCoordinates.longitude >
                        _northeastCoordinates.longitude)
                    ? _northeastCoordinates.longitude
                    : _southwestCoordinates.longitude),
          ),
          50.0, // padding
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  // getLocation() async {
  //   position = await Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  //   if (position != null) {

  //   }
  // }

  getStopsData() async {
    var db = Firestore.instance;
    await db.collection("Stops").document("Delhi").get().then((value) {
      allStops = value.data["AllStops"];
      for (var i in value.data["AllStops"]) {
        if (i["Name"].toString() == widget.from) {
          fromLat = i["Latitude"];
          fromLong = i["Longitude"];
        } else if (i["Name"].toString() == widget.to) {
          toLat = i["Latitude"];
          toLong = i["Longitude"];
        }
      }
    });
  }

  //Response response = await dio.get(
  //      "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=${latlong}&destinations=${position.latitude},${position.longitude}&units=metric&mode=transit&transit_mode=bus&transit_routing_preference=less_walking&key=AIzaSyDbj-HZAEaeYL6m3Dqol-2ADW67uXUG8vU");
  void getDistanceMatrix() async {
    //print(widget.busList);
    await getStopsData();
    DistanceMatrix distanceMatrix;
    DistanceMatrix stopsDistance;
    String distance;
    Dio dio = new Dio();
    try {
      Response response = await dio.get(
          "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=${fromLat},${fromLong}&destinations=${toLat},${toLong}&units=metric&mode=transit&transit_mode=bus&transit_routing_preference=less_walking&key=AIzaSyDbj-HZAEaeYL6m3Dqol-2ADW67uXUG8vU");
      stopsDistance =
          new DistanceMatrix.fromJson(json.decode(response.toString()), 0);
      //print(stopsDistance.elements[0].duration.text);
      distance = stopsDistance.elements[0].distance.text.toString();
      //print(distance.substring(0, distance.indexOf(' ')));
      setState(() {
        priceDis = double.parse(distance.substring(0, distance.indexOf(' ')));
      });

      setState(() {
        if (priceDis >= 10) {
          amount = 15;
        } else if (priceDis >= 4) {
          amount = 10;
        } else {
          amount = 5;
        }
      });
    } catch (e) {
      print(e);
    }

    String latlong = '';
    for (var i = 0; i < widget.busList.length; i++) {
      if (i != (widget.busList.length - 1)) {
        latlong += widget.busList[i]['lat'].toString() +
            ',' +
            widget.busList[i]['long'].toString() +
            "|";
      } else {
        latlong += widget.busList[i]['lat'].toString() +
            ',' +
            widget.busList[i]['long'].toString();
      }
    }
    print(latlong);
    try {
      Response response = await dio.get(
          "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=${latlong}&destinations=${fromLat},${fromLong}&units=metric&key=AIzaSyDbj-HZAEaeYL6m3Dqol-2ADW67uXUG8vU");
      for (var i = 0; i < widget.busList.length; i++) {
        distanceMatrix =
            new DistanceMatrix.fromJson(json.decode(response.toString()), i);
        eta.add(distanceMatrix.elements[0].duration.text);
      }
      print(eta);
    } catch (e) {
      print(e);
    }
    for (var i = 0; i < widget.busList.length; i++) {
      var stops = widget.busList[i]['stops'];
      print(stops);
      for (var k = 0; k < stops.length; k++) {
        if (stops[k]['StopName'].toLowerCase() == widget.from.toLowerCase()) {
          passengers = stops[k]['Passenger'];
          break;
        }
      }
      print(widget.busList[i]);
      busList.add(
        Bus(
            busNo: widget.busList[i]['busNumber'],
            eta: eta[i],
            price: (priceDis >= 10)
                ? ' ₹ 15 '
                : (priceDis >= 4) ? ' ₹ 10 ' : ' ₹ 5 ',
            passengers: passengers,
            capacity: widget.busList[i]['capacity'],
            from: widget.busList[i]['stops'][0]['StopName'],
            to: widget.busList[i]['stops']
                [widget.busList[i]['stops'].length - 1]['StopName'],
            totalRating: 20,
            noOfRatings: 5,
            driverName: widget.busList[i]['driverName'],
            driverNumber: widget.busList[i]['driverContact']),
      );
    }
    setState(() {
      positionGot = false;
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

  saveTransactionBusSide(String transactionId, String busNo) {
    var db = Firestore.instance;
    var dateParse = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    String date = formattedDate.toString();
    db
        .collection("DelhiBus")
        .document(busNo)
        .collection("tickets")
        .getDocuments()
        .then((value) {
      var count = 0;
      var docData;
      for (var element in value.documents) {
        if (element.documentID == date) {
          docData = element.data["allTickets"];
          count++;
          break;
        }
      }
      if (count == 0) {
        db
            .collection("DelhiBus")
            .document(busNo)
            .collection("tickets")
            .document(date)
            .setData({
          "allTickets": [
            {
              "transactionId": transactionId,
              "isVerified": false,
            }
          ]
        }).whenComplete(() {
          print("Ticket Saved in Bus Side (NEW)");
        });
      } else {
        docData.add({
          "transactionId": transactionId,
          "isVerified": false,
        });
        db
            .collection("DelhiBus")
            .document(busNo)
            .collection("tickets")
            .document(date)
            .updateData({"allTickets": docData}).whenComplete(() {
          print("Ticket Saved in Bus Side (OLD)");
        });
      }
    });
  }

  Future _speak(String text) async {
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    if (positionGot) {
      return Scaffold(
        drawer: drawer(context),
        body: Container(
          decoration: BackgroundGradient,
          child: Center(
              child: FadingText(
            'Loading...',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
          )),
        ),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                _onMapCreated();
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(fromLat), double.parse(fromLong)),
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('FROM'),
                  position:
                      LatLng(double.parse(fromLat), double.parse(fromLong)),
                ),
                Marker(
                  markerId: MarkerId('TO'),
                  position: LatLng(double.parse(toLat), double.parse(toLong)),
                )
              },
            ),
            Positioned(
              top: H / 2,
              child: Container(
                width: W,
                child: Column(
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 0.9,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false),
                      items: busList
                          .map(
                            (item) => Container(
                              child: Column(
                                children: [
                                  Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.yellow,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.mic),
                                        onPressed: () {
                                          //speech here
                                          int rating=(item.totalRating/item.noOfRatings).round();
                                          var price=(int.parse(item.price.substring(3,5))==5)?'Paanch':(int.parse(item.price.substring(3,5))==10)?'Dus':'Pundrah';
                                          _speak('yeh bus ${item.eta} me ayegi aur iski ticket ${price} rupay ki hai . Iss bus me abhi ${item.passengers} yatri hai aur iski rating paanch sitara me se ${(rating==1)?'ek':(rating==2)?'do':(rating==3)?'teen':(rating==4)?'Chaar':'Paanch'} sitara hai');
                                        },
                                      )),
                                  SizedBox(height: 5),
                                  GestureDetector(
                                      onTap: () {
                                        Alert(
                                          context: context,
                                          title: "Chale Chalo",
                                          style: AlertStyle(
                                            titleStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                          desc:
                                              "How would you like to buy your ticket",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "ONLINE",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onPressed: () {
                                                Alert(
                                                    context: context,
                                                    title: "Chale Chalo",
                                                    style: AlertStyle(
                                                      titleStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30),
                                                    ),
                                                    content: Column(
                                                      children: <Widget>[
                                                        TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            icon: Icon(
                                                                Icons.people),
                                                            labelText:
                                                                'Enter No. of Passengers',
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              noOfTickets =
                                                                  int.parse(
                                                                      value);
                                                              amount = amount *
                                                                  noOfTickets;
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    buttons: [
                                                      DialogButton(
                                                        onPressed: () =>
                                                            Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => PaymentPage(
                                                                amount: amount
                                                                    .toString(),
                                                                busNo:
                                                                    item.busNo,
                                                                driverName: item
                                                                    .driverName,
                                                                driverNumber: item
                                                                    .driverNumber,
                                                                startingStop:
                                                                    widget.from,
                                                                destinationStop:
                                                                    widget.to,
                                                                noOfTickets:
                                                                    noOfTickets),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "Buy Tickets",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20),
                                                        ),
                                                        color: YELLOW,
                                                      )
                                                    ]).show();
                                              },
                                              color: YELLOW,
                                            ),
                                            DialogButton(
                                              child: Text(
                                                "OFFLINE",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onPressed: () {
                                                Alert(
                                                    context: context,
                                                    title: "Chale Chalo",
                                                    style: AlertStyle(
                                                      titleStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30),
                                                    ),
                                                    content: Column(
                                                      children: <Widget>[
                                                        TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            icon: Icon(
                                                                Icons.people),
                                                            labelText:
                                                                'Enter No. of Passengers',
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              noOfTickets =
                                                                  int.parse(
                                                                      value);
                                                              amount = amount *
                                                                  noOfTickets;
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    buttons: [
                                                      DialogButton(
                                                        onPressed: () {
                                                          saveTransaction(
                                                            transactionId:
                                                                '$NAME;$PHONE;${item.busNo};${widget.from};${widget.to};$noOfTickets;${amount.toString()}',
                                                            busNumber:
                                                                item.busNo,
                                                            driverName:
                                                                item.driverName,
                                                            driverNumber: item
                                                                .driverNumber,
                                                            startingStop:
                                                                widget.from,
                                                            destinationStop:
                                                                widget.to,
                                                            amount: amount
                                                                .toString(),
                                                          );
                                                          saveTransactionBusSide(
                                                              '$NAME;$PHONE;${item.busNo};${widget.from};${widget.to};$noOfTickets;${amount.toString()}',
                                                              item.busNo);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OfflineTicket(
                                                                            qrData:
                                                                                '$NAME;$PHONE;${item.busNo};${widget.from};${widget.to};$noOfTickets;${amount.toString()}',
                                                                            from:
                                                                                widget.from,
                                                                            to: widget.to,
                                                                            busNo:
                                                                                item.busNo,
                                                                            noOfTickets:
                                                                                noOfTickets.toString(),
                                                                            driverName:
                                                                                item.driverName,
                                                                            driverNumber:
                                                                                item.driverNumber,
                                                                          )));
                                                        },
                                                        child: Text(
                                                          "Buy Offline Tickets",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                        color: Colors.black,
                                                      )
                                                    ]).show();
                                              },
                                              color: Colors.black,
                                            )
                                          ],
                                        ).show();
                                      },
                                      child: card.getCard(
                                          H: H,
                                          W: W,
                                          eta: item.eta,
                                          busNo: item.busNo,
                                          fromStop: item.from,
                                          toStop: item.to,
                                          totalRating: item.totalRating,
                                          noOfRatings: item.noOfRatings,
                                          price: item.price,
                                          passengers: item.passengers,
                                          capacity: item.capacity)),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
