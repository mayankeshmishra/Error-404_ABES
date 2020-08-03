import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Constants/constants.dart';
import '../Constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailgun/mailgun.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;
final _firestore = Firestore.instance;

class ShowJourneyNavigationPage extends StatefulWidget {
  final String busNo;
  final String from;
  final String to;
  final String driverName;
  final String driverNumber;
  ShowJourneyNavigationPage(
      {this.busNo,
      this.from,
      this.to,
      @required this.driverName,
      this.driverNumber});
  @override
  _ShowJourneyNavigationPageState createState() =>
      _ShowJourneyNavigationPageState();
}

class _ShowJourneyNavigationPageState extends State<ShowJourneyNavigationPage> {
  String _latestHardwareButtonEvent;
  StreamSubscription<HardwareButtons.VolumeButtonEvent> _volumeButtonSubscription;
  StreamSubscription<HardwareButtons.HomeButtonEvent> _homeButtonSubscription;
  StreamSubscription<HardwareButtons.LockButtonEvent> _lockButtonSubscription;
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));

  GoogleMapController mapController;

  Position _northeastCoordinates;
  Position _southwestCoordinates;
  Position startCoordinates =
      Position(latitude: 28.65081667, longitude: 77.23846667);
  Position destinationCoordinates =
      Position(latitude: 28.6663, longitude: 77.2087);
  Marker marker;
  List markers = [];

  var geolocator = Geolocator();
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  Future<Uint8List> getMarker() async {
    ByteData data =
        await DefaultAssetBundle.of(context).load("assets/logo_black.png");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 85);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void locationStream() async {
    Uint8List imageData = await getMarker();
    await for (var snapshot in _firestore
        .collection("DelhiBus")
        .document(widget.busNo)
        .snapshots()) {
      if (snapshot != null) {
        print(snapshot.data['lat']);
        setState(() {
          markers[0] = Marker(
              markerId: MarkerId("BUS"),
              position: LatLng(snapshot.data['lat'], snapshot.data['long']),
              //rotation: latlng.heading,
              draggable: false,
              zIndex: 2,
              flat: true,
              icon: BitmapDescriptor.fromBytes(imageData));
        });
      }
    }
  }

  createMarkers(StopsDetail) async {
    Uint8List imageData = await getMarker();
    markers.add(Marker(
        markerId: MarkerId("BUS"),
        position: LatLng(28.6400, 77.238667),
        //rotation: latlng.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        icon: BitmapDescriptor.fromBytes(imageData)));
    for (var i in StopsDetail) {
      markers.add(Marker(
        markerId: MarkerId(i[0]),
        position: LatLng(
          double.parse(i[1]),
          double.parse(i[2]),
        ),
        infoWindow: InfoWindow(
          title: i[0],
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }
    //print(markers[0].value);
  }

  getStops(String from, String to, String busNumber) async {
    var db = Firestore.instance;
    var StopsDetail = [];
    print(from);
    print(to);
    await db
        .collection("DelhiBus")
        .document(busNumber)
        .get()
        .then((value) async {
      var stops = [];
      var data = value.data;
      var x, y;
      if (data["upstream"] == true) {
        x = from;
        y = to;
      } else {
        x = to;
        y = from;
      }
      var i = 0;
      for (i = 0; i < value.data["Stops"].length; i++) {
        if (data["Stops"][i]["StopName"].toString().toLowerCase() ==
            x.toString().toLowerCase()) {
          break;
        }
      }
      for (var j = i; j < data["Stops"].length; j++) {
        if (data["Stops"][j]["StopName"].toString().toLowerCase() ==
            y.toString().toLowerCase()) {
          stops.add(data["Stops"][j]["StopName"]);
          break;
        } else {
          stops.add(data["Stops"][j]["StopName"]);
        }
      }

      await db.collection("Stops").document("Delhi").get().then((value) {
        for (var i in stops) {
          for (var j in value.data["AllStops"]) {
            if (i.toLowerCase().trim() ==
                j["Name"].toString().toLowerCase().trim()) {
              StopsDetail.add([i, j["Latitude"], j["Longitude"]]);
              break;
            }
          }
        }
      });
      createMarkers(StopsDetail);
      locationStream();
      _createPolylines(startCoordinates, destinationCoordinates, StopsDetail);
      _getCurrentLocation(StopsDetail);
    });
  }

  _createPolylines(Position start, Position destination, StopsDetail) async {
    // Initializing PolylinePoints
    print(StopsDetail);
    polylinePoints = PolylinePoints();
    for (var i = 0; i < StopsDetail.length - 1; i++) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyDbj-HZAEaeYL6m3Dqol-2ADW67uXUG8vU', // Google Maps API Key
        PointLatLng(
            double.parse(StopsDetail[i][1]), double.parse(StopsDetail[i][2])),
        PointLatLng(double.parse(StopsDetail[i + 1][1]),
            double.parse(StopsDetail[i + 1][2])),
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
    }

    // Defining an ID
    PolylineId id = PolylineId('Route');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Color(0xff1a237e),
      points: polylineCoordinates,
      width: 4,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
    setState(() {});
  }

  _getCurrentLocation(StopsDetail) async {
    try {
      if (double.parse(StopsDetail[0][1]) <=
          double.parse(StopsDetail[StopsDetail.length - 1][1])) {
        _southwestCoordinates = Position(
            latitude: double.parse(StopsDetail[0][1]),
            longitude: double.parse(StopsDetail[0][2]));
        _northeastCoordinates = Position(
            latitude: double.parse(StopsDetail[StopsDetail.length - 1][1]),
            longitude: double.parse(StopsDetail[StopsDetail.length - 1][2]));
      } else {
        _southwestCoordinates = Position(
            latitude: double.parse(StopsDetail[StopsDetail.length - 1][1]),
            longitude: double.parse(StopsDetail[StopsDetail.length - 1][2]));
        _northeastCoordinates = Position(
            latitude: double.parse(StopsDetail[0][1]),
            longitude: double.parse(StopsDetail[0][2]));
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
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    travelingBusNumber=widget.busNo;
    travelingDriverName=widget.driverName;
    travelingDriverNumber=widget.driverNumber;
    _volumeButtonSubscription = HardwareButtons.volumeButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = event.toString();
        if(_latestHardwareButtonEvent=="VolumeButtonEvent.VOLUME_UP"){
          inputs.add("up");
        }else{
          inputs.add("down");
        }
      });
      turnInputEmpty();
    });


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _volumeButtonSubscription?.cancel();
    _homeButtonSubscription?.cancel();
    _lockButtonSubscription?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _initialLocation,
              mapType: MapType.normal,
              markers: markers != null ? Set<Marker>.from(markers) : null,
              polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                getStops(widget.from, widget.to, widget.busNo);
              },
            ),
            Positioned(
              right: height * .02,
              top: width * .06,
              child: emergency(context, height, width),
            )
          ],
        ),
      ),
    );
  }

  Widget emergency(context, H, W) {
    return Container(
      height: H * .06,
      width: W * .5,
      decoration: BoxDecoration(
        color: Color(0XFFd50000).withOpacity(0.8),
        borderRadius: BorderRadius.circular(H),
      ),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(H * .02)),
                  title: Text(
                    "Emergency Alert!",
                    textAlign: TextAlign.center,
                  ),
                  content: Container(
                    width: W,
                    height: H * .2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Do you really want to report emergency.",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Fake report will result a serious action against you.",
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(ctx);
                              },
                              child: Container(
                                width: W * .25,
                                height: H * .04,
                                alignment: Alignment.center,
                                margin:
                                    EdgeInsets.symmetric(horizontal: H * .01),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(H),
                                    color: Colors.black),
                                child: Text(
                                  "NO",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                var navigationUrl;
                                var ctx1;
                                Navigator.pop(ctx);
                                showDialog(
                                    context: context,
                                    builder: (ctx2) {
                                      ctx1 = ctx2;
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(H * .02)),
                                        title: Text(
                                          "Sending Emergency Report",
                                          textAlign: TextAlign.center,
                                        ),
                                        content: StatefulBuilder(
                                          builder: (stateContext, setState) {
                                            return Container(
                                                height: H * .1,
                                                child: SpinKitRing(
                                                  color: Colors.black,
                                                  size: H * .05,
                                                  lineWidth: H * .003,
                                                ));
                                          },
                                        ),
                                      );
                                    });
                                var mailgun = MailgunMailer(
                                    domain:
                                        "sandboxd2b482b8e25e491fa0f8d48dd0edd898.mailgun.org",
                                    apiKey:
                                        "1592c4e8c965a881adc322dfe504d9ad-ffefc4e4-0cf24894");
                                mailgun
                                    .send(
                                        from: "chalechalo@gmail.com",
                                        to: ["ankiisnap@gmail.com"],
                                        subject: "Test email",
                                        text: "Hello World")
                                    .then((value) {
                                  print(value.message);
                                });
                                var twilioFlutter = TwilioFlutter(
                                    accountSid:
                                        'AC7fbf2f1200e9786e6ee7eb3b4cadfed0',
                                    // replace *** with Account SID
                                    authToken:
                                        '4ae0d018ca9e1593f625193468e0e001',
                                    // replace xxx with Auth Token
                                    twilioNumber:
                                        '+12565734690' // replace .... with Twilio Number
                                    );
                                // var numbers = [
                                //   "+919555656766",
                                //   "+919569550325"
                                // ];
                                var db = Firestore.instance;
                                await db
                                    .collection("DelhiBus")
                                    .document(widget.busNo)
                                    .get()
                                    .then((value) {
                                  navigationUrl = value.data["navigationUrl"];
                                });
                                for (var i = 0; i < numbersForSMS.length; i++) {
                                  Future.delayed(Duration(seconds: 4), () {
                                    twilioFlutter
                                        .sendSMS(
                                            toNumber: numbersForSMS[i],
                                            messageBody:
                                                'The Person with mobile number : $PHONE has reported an emergency while travelling in a bus with Registration Number : ${widget.busNo}, Driver Name : ${widget.driverName}, Driver Contact No. : ${widget.driverNumber}, & Navigation link to track the bus : $navigationUrl')
                                        .then((value) {
                                      print(value.toString());
                                    });
                                  });
                                }
                                Future.delayed(Duration(seconds: 7), () {
                                  var db = Firestore.instance;
                                  db
                                      .collection("DelhiBus")
                                      .document("UK07BR1628")
                                      .get()
                                      .then((value) {
                                    var emergency = value.data["Emergency"];
                                    emergency.add(PHONE);
                                    db
                                        .collection("DelhiBus")
                                        .document(widget.busNo)
                                        .updateData({
                                      "Emergency": emergency
                                    }).whenComplete(() {
                                      Navigator.pop(ctx1);
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          H * .02)),
                                              title: Text(
                                                "Emergency Report Sent",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Container(
                                                height: H * .25,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Thank you for reporting!",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      height: H * .01,
                                                    ),
                                                    Text(
                                                        "We have sent your ride details and live location link with -"),
                                                    Text(numbersForSMS[1] +
                                                        ", "),
                                                    Text(numbersForSMS[2] +
                                                        " and "),
                                                    Text("Admin"),
                                                    SizedBox(
                                                      height: H * .01,
                                                    ),
                                                    Text(
                                                        "We will respond to you soon"),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    });
                                  });
                                });
                              },
                              child: Container(
                                width: W * .25,
                                height: H * .04,
                                alignment: Alignment.center,
                                margin:
                                    EdgeInsets.symmetric(horizontal: H * .01),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(H),
                                    color: Colors.red[700]),
                                child: Text(
                                  "YES",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: Colors.white,
            ),
            Text(
              "Report Emergency",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
