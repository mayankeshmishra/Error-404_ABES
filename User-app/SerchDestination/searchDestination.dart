import 'dart:io';

import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/Drawer/drawer.dart';
import 'package:chale_chalo/busListPage.dart';
import 'package:chale_chalo/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SearchDestination extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchDestinationState();
  }
}

List<String> Stops = [];

class SearchDestinationState extends State<SearchDestination> {
  var context1;
  double mylatitude;
  double mylongitude;
  double startingPointLatitude;
  double startingPointLongitude;
  double destinationLatitude;
  double destinationLongitude;
  var selectedCity = "Select City";
  var listningCtx;
  bool fetchingCurrentLoc = false;
  bool textFieldEnable = false;
  var speaking = false;
  bool isGettingCityWiseStops = false;
  var address = "";
  var t = "";
  var currentLocController = TextEditingController();
  var destinationLocController = TextEditingController();
  var city = [];
  var textDitected = false;
  var ditectedText;
  bool gettingData = true;
  bool isSearchingStopsNearBy = false;
  var nearByStops = [];
  var stopsLat = [];
  var stopsLong = [];
  String fromStop, toStop;
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    getCityName();
    getDrawerData();
    getCityPref();
  }

  @override
  Widget build(BuildContext context) {
    context1 = context;
    return SafeArea(
      child: Scaffold(
        drawer: drawer(context),
        body: Container(
          padding: EdgeInsets.only(top: H * .02),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/destinationBG.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: (gettingData)
              ? SpinKitRing(
                  color: Colors.black,
                  size: H * .07,
                  lineWidth: H * .005,
                )
              : ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(H * .01),
                      margin: EdgeInsets.symmetric(horizontal: H * .01),
                      decoration: BoxDecoration(
                          color: Colors.yellow[400],
                          borderRadius: BorderRadius.circular(H * .02)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: H * .07,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(H * .02),
                                border:
                                    Border.all(width: 2, color: Colors.black)),
                            child: DropdownButton<dynamic>(
                              isExpanded: true,
                              elevation: 0,
                              hint: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  selectedCity,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                              items: city.map((dynamic dropDownString) {
                                return DropdownMenuItem<dynamic>(
                                  child: Text(dropDownString),
                                  value: dropDownString,
                                );
                              }).toList(),
                              onChanged: (dynamic selectedItem) {
                                setState(() {
                                  selectedCity = selectedItem.toString();
                                  isGettingCityWiseStops = true;
                                });
                                saveCityPref(selectedCity.toString());
                                getStopsData();
                              },
                            ),
                          ),
                          SizedBox(
                            height: H * .015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: H * .07,
                                width: W * .75,
                                child: TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                          maxLines: 1,
                                          enabled:
                                              (selectedCity == "Select City")
                                                  ? false
                                                  : true,
                                          controller: currentLocController,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            labelText: "Starting From",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            prefixIcon: Icon(
                                              Icons.my_location,
                                              color: Colors.black,
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        H * .02)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        H * .02)),
                                          )),
                                  suggestionsCallback: (pattern) {
                                    return AllStops.getSuggestions(pattern);
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      leading: Icon(Icons.location_on),
                                      title: Text(suggestion),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    setState(() {
                                      currentLocController.text = suggestion;
                                      fromStop = suggestion;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: H * .07,
                                width: H * .06,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                        BorderRadius.circular(H * .02)),
                                child: IconButton(
                                  icon: Icon(Icons.mic),
                                  onPressed: () {
                                    setState(() {
                                      speaking = true;
                                    });
                                    var ctx1;
                                    SpeachToText(context, 0);
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: H * .015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: H * .07,
                                width: W * .75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(H * .02),
                                ),
                                child: TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                          enabled:
                                              (selectedCity == "Select City")
                                                  ? false
                                                  : true,
                                          controller: destinationLocController,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            labelText: "Going To",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.bus,
                                              color: Colors.black,
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        H * .02)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        H * .02)),
                                          )),
                                  suggestionsCallback: (pattern) {
                                    return AllStops.getSuggestions(pattern);
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      leading: Icon(Icons.location_on),
                                      title: Text(suggestion),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    setState(() {
                                      destinationLocController.text =
                                          suggestion;
                                      toStop = suggestion;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: H * .07,
                                width: H * .06,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                        BorderRadius.circular(H * .02)),
                                child: IconButton(
                                  icon: Icon(Icons.mic),
                                  onPressed: () {
                                    SpeachToText(context, 1);
                                  },
                                ),
                              )
                            ],
                          ),
                          (t != "") ? Text("$t miles") : Center()
                        ],
                        // borderRadius: BorderRadius.circular(H * .02),
                        // border: Border.all(width: 2, color: Colors.black)
                      ),
                    ),
                    SizedBox(
                      height: H * .02,
                    ),
                    (isGettingCityWiseStops)
                        ? SpinKitRing(
                            color: Colors.black,
                            size: H * .07,
                            lineWidth: H * .005,
                          )
                        : Center(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: H * .02),
                      child: RaisedButton(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(H)),
                        child: Container(
                          width: W * .7,
                          alignment: Alignment.center,
                          height: H * .05,
                          child: Text(
                            "SEARCH BUSES",
                            style: TextStyle(
                                fontSize: H * .02,
                                color: YELLOW,
                                letterSpacing: 1.5),
                          ),
                        ),
                        onPressed: () {
                          if ((fromStop != null) && (toStop != null)) {
                            getBuses(fromStop, toStop, context);
                          } else {
                            Alert(
                              context: context,
                              title: "Chale Chalo",
                              desc: "Please provide valid Stations",
                              buttons: [
                                DialogButton(
                                  color: Color(0Xfffdd835),
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(H * .02),
                      child: RaisedButton(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(H)),
                        child: Container(
                          width: W * .7,
                          alignment: Alignment.center,
                          height: H * .05,
                          child: Text(
                            "NAVIGATE TO STOP",
                            style: TextStyle(
                                fontSize: H * .02,
                                color: YELLOW,
                                letterSpacing: 1.5),
                          ),
                        ),
                        onPressed: () {
                          _launchURL();
                        },
                      ),
                    ),
                  ],
                ),
        ),
        bottomNavigationBar: Container(
          height: (gettingData) ? 0 : H * .07,
          color: Colors.black,
          child: GestureDetector(
            onTap: () {
              getCurrentLocation();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bus Stops Near Me",
                  style: TextStyle(
                      color: YELLOW,
                      fontSize: H * .02,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
                SizedBox(
                  width: H * .02,
                ),
                (isSearchingStopsNearBy)
                    ? SpinKitRing(
                        color: YELLOW,
                        size: H * .03,
                        lineWidth: H * .003,
                      )
                    : Icon(
                        Icons.search,
                        color: YELLOW,
                        size: H * .04,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCityPref() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.containsKey("favCity")) {
      setState(() {
        selectedCity = pref.get("favCity");
      });
    }
    getStopsData();
  }

  saveCityPref(val) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString("favCity", val);
  }

  getCurrentLocation() async {
    setState(() {
      isSearchingStopsNearBy = true;
    });
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (_permissionGranted == PermissionStatus.granted) {
      setState(() {
        mylongitude = _locationData.longitude;
        mylatitude = _locationData.latitude;
      });
      getAddress(mylatitude, mylongitude);
    } else {
      setState(() {
        isSearchingStopsNearBy = false;
      });
      showDialog(
          context: context1,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(H * .02)),
              title: Text(
                "Permition Denied",
                style:
                    TextStyle(fontSize: H * .018, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Unable to get your GPS Location, kindly enable it",
                textAlign: TextAlign.center,
              ),
              actions: [
                FlatButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(H)),
                  child: Container(
                      alignment: Alignment.center,
                      width: W,
                      child: Text(
                        "OK",
                        style: TextStyle(color: YELLOW),
                      )),
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                )
              ],
            );
          });
    }
  }

  getAddress(latitude, longitude) async {
    final coordinates = new Coordinates(28.642358, 77.106944);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    var x = "";
    if (first.adminArea.toString() == "Delhi") {
      x = "Delhi";
    } else {
      x = first.subAdminArea;
    }
    if (!city.contains(x)) {
      setState(() {
        isSearchingStopsNearBy = false;
      });
      showDialog(
          context: context1,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(H * .02)),
              title: Text(
                "Sorry",
                style:
                    TextStyle(fontSize: H * .018, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Sorry we are currently not available in your city.",
                textAlign: TextAlign.center,
              ),
              actions: [
                FlatButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(H)),
                  child: Container(
                      alignment: Alignment.center,
                      width: W,
                      child: Text(
                        "OK",
                        style: TextStyle(color: YELLOW),
                      )),
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                )
              ],
            );
          });
    } else {
      getNearbyStops(28.65201667, 77.23716667);
    }
  }

  getStopsData() {
    var db = Firestore.instance;
    List<String> info = [];
    db.collection("Stops").document("Delhi").get().then((value) {
      info = [];
      for (var i in value.data["AllStops"]) {
        info.add(i["Name"].toString());
        stopsLat.add(i["Latitude"]);
        stopsLong.add(i["Longitude"]);
      }
      setState(() {
        Stops = info;
        isGettingCityWiseStops = false;
        textFieldEnable = true;
      });
    });
  }

  getCityName() {
    var db = Firestore.instance;
    db.collection("City").document("City").get().then((value) {
      city = value.data["AllCity"];
      setState(() {
        gettingData = false;
      });
    });
  }

  double calculateDistance(Lat1, Long1, Lat2, Lang2) {
    final Distance distance = new Distance();
    // km = 423
    final double meter = distance.as(
        LengthUnit.Meter, new LatLng(Lat1, Long1), new LatLng(Lat2, Lang2));
    return meter;
  }

  getNearbyStops(lattitude, longitude) {
    var info = [];
    var db = Firestore.instance;
    var minDis = 5000.0;
    var StopName = "";
    db.collection("Stops").document("Delhi").get().then((value) {
      for (var i in value.data["AllStops"]) {
        var x = calculateDistance(double.parse(i["Latitude"].toString()),
            double.parse(i["Longitude"].toString()), lattitude, longitude);
        if (x < minDis) {
          minDis = x;
          StopName = i["Name"].toString();
        }
      }
      setState(() {
        currentLocController.text = StopName;
        isSearchingStopsNearBy = false;
      });
    });
  }

  _launchURL() async {
    var l1 = 28.65201667;
    var lt1 = 77.23716667;
    var l2 = stopsLat[Stops.indexOf(currentLocController.text)];
    var lt2 = stopsLong[Stops.indexOf(currentLocController.text)];
    var url =
        'https://www.google.com/maps/dir/?api=1&origin=$l1,${lt1}&destination=${l2},${lt2}&travelmode=walking&dir_action=navigate';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getDrawerData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    NAME = pref.get("name");
    PHONE = pref.get("phone");
    AVTAR = File(pref.get("DpPath"));
    getNumbersToSMS();
  }

  getBuses(String fromStop, String toStop, context) {
    var db = Firestore.instance;
    var buses = [];
    db.collection("${selectedCity}Bus").getDocuments().then((value) {
      for (var i in value.documents) {
        if (i.data["upstream"] == true) {
          var j;
          var busAvailable = 0;

          for (j = 0; j < i.data["Stops"].length; j++) {
            if (fromStop.toLowerCase() ==
                    i.data["Stops"][j]["StopName"].toLowerCase() &&
                i.data["Stops"][j]["Visited"] == false) {
              busAvailable++;
              break;
            }
          }
          for (var k = j; k <= i.data["Stops"].length - 1; k++) {
            if (toStop.toLowerCase() ==
                    i.data["Stops"][k]["StopName"].toLowerCase() &&
                i.data["Stops"][k]["Visited"] == false) {
              busAvailable++;
              break;
            }
          }
          if (busAvailable == 2) {
            buses.add({
              "busNumber": i.documentID,
              "driverName": i.data["driverName"],
              "driverContact": i.data["contact"],
              "capacity": i.data["capacity"],
              "lat": i.data["lat"],
              "long": i.data["long"],
              "upastream": i.data["upstream"],
              "stops": i.data["Stops"],
            });
          }
        } else {
          var j;
          var busAvailable = 0;
          for (j = i.data["Stops"].length - 1; j >= 0; j--) {
            if (fromStop.toLowerCase() ==
                    i.data["Stops"][j]["StopName"].toLowerCase() &&
                i.data["Stops"][j]["Visited"] == false) {
              busAvailable++;
              break;
            }
          }
          for (var k = j; k >= 0; k--) {
            if (toStop.toLowerCase() ==
                    i.data["Stops"][k]["StopName"].toLowerCase() &&
                i.data["Stops"][k]["Visited"] == false) {
              busAvailable++;
              break;
            }
          }
          if (busAvailable == 2) {
            buses.add({
              "busNumber": i.documentID,
              "driverName": i.data["DriverName"],
              "driverContact": i.data["contact"],
              "capacity": i.data["capacity"],
              "lat": i.data["lat"],
              "long": i.data["long"],
              "upastream": i.data["upstream"],
              "stops": i.data["Stops"],
            });
          }
        }
      }
      if (buses.length >= 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BusList(from: fromStop, to: toStop, busList: buses)));
      } else {
        Alert(
          context: context,
          title: "Chale Chalo",
          style: AlertStyle(
            titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          desc:
              "Sorry !! No buses are currently availaible for your desired route",
          buttons: [
            DialogButton(
              child: Text(
                "DISMISS",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: YELLOW,
            ),
          ],
        ).show();
      }
    });
  }

  Future _speak(selectedItem) async {
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setSpeechRate(0.9);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.1);
    await flutterTts.speak(selectedItem);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Widget fromToContainer() {
    return Container(
      width: W,
      margin: EdgeInsets.all(H * .01),
      padding: EdgeInsets.all(H * .01),
      decoration: BoxDecoration(
          color: YELLOW, borderRadius: BorderRadius.circular(H * .02)),
      child: Column(
        children: [
          Container(
            height: H * .06,
            padding: EdgeInsets.only(left: H * .01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(H * .02),
                border: Border.all(width: 1, color: Colors.black)),
            child: Row(
              children: [
                Icon(
                  Icons.my_location,
                  color: Colors.black,
                ),
                SizedBox(
                  width: H * .02,
                ),
                Text(
                  "Starting From",
                  style: TextStyle(fontSize: H * .019),
                )
              ],
            ),
          ),
          SizedBox(
            height: H * .02,
          ),
          Container(
            height: H * .06,
            padding: EdgeInsets.only(left: H * .01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(H * .02),
                border: Border.all(width: 1, color: Colors.black)),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.busAlt,
                  color: Colors.black,
                ),
                SizedBox(
                  width: H * .02,
                ),
                Text(
                  "Going To",
                  style: TextStyle(fontSize: H * .019),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> SpeachToText(context, choice) async {
    var x;
    var _localeNames;
    var _currentLocaleId;
    ditectedText = null;
    stt.SpeechToText speech = stt.SpeechToText();
    var ctx1;
    showDialog(
        context: context,
        builder: (ctx) {
          ctx1 = ctx;
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(H * .02)),
            content: StatefulBuilder(builder: (ctx, setState) {
              return Container(
                height: H * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SpinKitWave(
                      type: SpinKitWaveType.center,
                      color: Colors.black,
                      size: H * .04,
                    ),
                    (textDitected)
                        ? Text(ditectedText)
                        : Text(
                            "Please Speak . . .",
                            style: TextStyle(fontSize: H * .022),
                          )
                  ],
                ),
              );
            }),
          );
        });
    bool available = await speech.initialize();
    if (available) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }
    if (available) {
      speech.listen(
          onResult: (text) {
            if (double.parse(text.confidence.toString()) > 0) {
              print(text.recognizedWords);
              ditectedText = text.recognizedWords;
              Navigator.pop(ctx1);
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text(
                        "Searching For :",
                        textAlign: TextAlign.center,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(H * .02),
                      ),
                      content: Container(
                        height: H * .15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: W * .7,
                                alignment: Alignment.center,
                                margin:
                                    EdgeInsets.symmetric(horizontal: H * .01),
                                child: Text(
                                  ditectedText,
                                  style: TextStyle(
                                      fontSize: H * .02,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(H),
                                  ),
                                  child: Container(
                                    width: W * .2,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Retry",
                                      style: TextStyle(color: Colors.yellow),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    SpeachToText(context, choice);
                                  },
                                ),
                                RaisedButton(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(H),
                                  ),
                                  child: Container(
                                    width: W * .2,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.yellow),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    applyStartingStopText(
                                        ditectedText, context, choice);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
          listenFor: Duration(seconds: 5),
          localeId: _currentLocaleId,
          cancelOnError: true,
          partialResults: true,
          listenMode: stt.ListenMode.confirmation);
    } else {
      print("The user has denied the use of speech recognition.");
    }
    // some time later...
    Future.delayed(Duration(seconds: 7), () {
      speech.stop();
      (ditectedText == null) ? Navigator.pop(ctx1) : print("");
    });
  }

  applyStartingStopText(text, context, choice) {
    var x = [];
    var count = 0;
    var s = "";
    for (var i in Stops) {
      if (i.trim().toLowerCase() == text.toString().toLowerCase()) {
        s = i;
        count++;
        break;
      } else if (i
          .trim()
          .toLowerCase()
          .contains(text.toString().toLowerCase())) {
        if (!x.contains(i)) {
          x.add(i);
        }
      }
    }
    if (count > 0) {
      if (choice == 0) {
        setState(() {
          currentLocController.text = s;
        });
      } else {
        setState(() {
          destinationLocController.text = s;
        });
      }
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            var selectedIndex = [];
            var selectedItem = "";
            var staticIndex = [];
            for (var i in x) {
              selectedIndex.add(false);
            }
            selectedIndex.add(false);
            staticIndex = selectedIndex;
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(H * .02)),
                title: Text(
                  "Choose From",
                  textAlign: TextAlign.center,
                ),
                content: StatefulBuilder(
                  builder: (ctx, setState) {
                    return Container(
                      height: H * .04 * (x.length + 3.5),
                      width: W,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: H * .01),
                      child: (x.length == 0)
                          ? Text(
                              "There is no Bus Stop matches with your choice",
                              textAlign: TextAlign.center,
                            )
                          : ListView.builder(
                              itemCount: x.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        for (var i = 0;
                                            i < selectedIndex.length;
                                            i++) {
                                          setState(() {
                                            selectedIndex[i] = false;
                                          });
                                        }
                                        setState(() {
                                          selectedIndex[index] = true;
                                          selectedItem = x[index];
                                          _speak(selectedItem);
                                          //Selected
                                        });
                                      },
                                      child: Container(
                                        height: H * .045,
                                        width: W,
                                        margin: EdgeInsets.symmetric(
                                            vertical: H * .005),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: (selectedIndex[index])
                                                ? Colors.black
                                                : Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(H * .02)),
                                        child: Text(
                                          x[index],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: (!selectedIndex[index])
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (index == x.length - 1)
                                        ? GestureDetector(
                                            onTap: () {
                                              for (var i = 0;
                                                  i < selectedIndex.length;
                                                  i++) {
                                                setState(() {
                                                  selectedIndex[i] = false;
                                                });
                                              }
                                              setState(() {
                                                selectedIndex[x.length] = true;
                                                selectedItem =
                                                    "None Of The Above";
                                                //none of the above
                                              });
                                            },
                                            child: Container(
                                              height: H * .045,
                                              width: W,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color:
                                                      (selectedIndex[x.length])
                                                          ? Colors.black
                                                          : Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          H * .02)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "None Of The Above",
                                                    style: TextStyle(
                                                      color: (!selectedIndex[
                                                              x.length])
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Center(),
                                    (index == x.length - 1)
                                        ? RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(H)),
                                            color: Colors.black,
                                            child: Container(
                                              width: W,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Select",
                                                style: TextStyle(
                                                    color: Colors.yellow),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (selectedItem.trim() != "") {
                                                if (x.contains(selectedItem)) {
                                                  if (choice == 0) {
                                                    setState(() {
                                                      currentLocController
                                                          .text = selectedItem;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      destinationLocController
                                                          .text = selectedItem;
                                                    });
                                                  }
                                                }
                                                Navigator.pop(ctx);
                                              }
                                            },
                                          )
                                        : Center()
                                  ],
                                );
                              },
                            ),
                    );
                  },
                ));
          });
    }
  }
}

class AllStops {
  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(Stops);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
