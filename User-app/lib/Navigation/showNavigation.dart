import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:chale_chalo/Constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final _firestore = Firestore.instance;

class ShowNavigationPage extends StatefulWidget {
  final String busNo;
  final String from;
  final String to;
  ShowNavigationPage({this.busNo, this.from, this.to});
  @override
  _ShowNavigationPageState createState() => _ShowNavigationPageState();
}

class _ShowNavigationPageState extends State<ShowNavigationPage> {
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
  String currentStop = ' ';
  //var geolocator = Geolocator();
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

  void locationStream(StopsDetail, ctx) async {
    Uint8List imageData = await getMarker();
    await for (var snapshot in _firestore
        .collection("DelhiBus")
        .document(widget.busNo)
        .snapshots()) {
      if (snapshot != null) {
        String newStop;
        var stops = snapshot.data['Stops'];
        if (stops[0]['Visited'] == false && stops[1]['Visited'] == false) {
          _createPolylines(stops[0]['StopName'], StopsDetail, ctx);
        }
        for (var i = 0; i < stops.length - 1; i++) {
          if (stops[i]['Visited'] == true && stops[i + 1]['Visited'] == false) {
            newStop = stops[i]['StopName'];
            if (currentStop != newStop) {
              currentStop = newStop;
              print(currentStop);

              _createPolylines(currentStop, StopsDetail, ctx);
            }
          }
        }
        if (this.mounted) {
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

  getStops(String from, String to, String busNumber, ctx) async {
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
        x = data["Stops"][0]["StopName"];
        y = from;
      } else {
        x = from;
        y = data["Stops"][value.data["Stops"].length - 1]["StopName"];
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
      locationStream(StopsDetail, ctx);
      _getCurrentLocation(StopsDetail);
    });
  }

  _createPolylines(currentStop, StopsDetail, ctx) async {
    // Initializing PolylinePoints
    print(currentStop);
    if (currentStop == widget.from) {
      if(blind==true){
        speak("Your Bus has arrived");
      }
      Alert(
        context: ctx,
        title: "Lok Rath",
        style: AlertStyle(
            titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        desc: "Your Bus has arrived",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            color: Colors.yellow,
            onPressed: () {
              for (var i = 0; i < 2; i++) {
                try {
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              }
            },
            width: 120,
          )
        ],
      ).show();
    }
    polylinePoints = PolylinePoints();
    int j = 0;
    for (var i = 0; i < StopsDetail.length; i++) {
      if (currentStop == StopsDetail[i][0]) {
        j = i;
      }
    }
    print(j);
    polylineCoordinates.clear();
    for (var i = j; i < StopsDetail.length - 1; i++) {
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
    if (this.mounted) {
      setState(() {});
    }
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
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
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
                  getStops(widget.from, widget.to, widget.busNo, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
