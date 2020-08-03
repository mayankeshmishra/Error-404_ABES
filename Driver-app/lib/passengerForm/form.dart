import 'package:chalechalo/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:chalechalo/passengerForm/passenger.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
typedef OnDelete();

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();
  var fromStopController=TextEditingController();
  var toStopController=TextEditingController();
  var _gender =[
    "Male",
    "Female"
  ];
  var textDitected = false;
  var ditectedText;
  var noOfPassenger=[1,2,3,4,5,6,7,8,9,10];
  var selectedPassenger="---";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(H*.02),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(H*.01),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user,color: Colors.amber,),
                elevation: 0,
                title: Text('Passenger Details',
                style: TextStyle(
                  color: Colors.amber
                ),),
                backgroundColor: Colors.black87,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.amber,),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: H*.01, right: H*.01,  bottom: H*.015,top: H*.015),
                child: TextFormField(
                  initialValue: widget.user.fullName,
                  onSaved: (val) => widget.user.fullName = val,
                  validator: (val) =>
                      val.length == 10 ? null : 'Full name is invalid',
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter Mobile Number',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                    prefixIcon: Icon(Icons.phone,color: Colors.amber,),
                    isDense: true,
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.amber)
                   ),
                   enabledBorder:  OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.black87)
                   ),
                  ),
                  onChanged: (val){
                    passenger.phoneNumber=val.toString().trim();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: W*.7,
                    margin: EdgeInsets.only(left: H*.01, right: H*.01,  bottom: H*.015),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: fromStopController,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Starting From",
                            labelStyle:
                            TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.my_location,
                              color: YELLOW,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(

                                ),
                            focusedBorder: OutlineInputBorder(

                                ),
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
                          fromStopController.text = suggestion;
                          passenger.from=suggestion.toString().trim();
                        });
                      },
                    ),
                  ),
                  Container(
                    height: H * .07,
                    width: H * .06,
                    margin: EdgeInsets.only(bottom: H*.015, right: H*.01),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(H * .01)
                    ),
                    child: IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () {

                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: W*.7,
                    margin: EdgeInsets.only(left: H*.01, right: H*.01,  bottom: H*.015),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(H * .02),
                    ),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: toStopController,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Going To",
                            labelStyle:
                            TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              FontAwesomeIcons.bus,
                              color: YELLOW,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(

                                ),
                            focusedBorder: OutlineInputBorder(

                                ),
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
                          toStopController.text = suggestion;
                          passenger.to=suggestion.toString().trim();
                        });
                      },
                    ),
                  ),
                  Container(
                    height: H * .07,
                    width: H * .06,
                    margin: EdgeInsets.only(bottom: H*.015, right: H*.01),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(H * .01)
                    ),
                    child: IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () {

                      },
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: H*.01, right: H*.01,  bottom: H*.015),
                padding: EdgeInsets.only(left: H*.02, right: H*.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(H * .005),
                  border: Border.all(color: Colors.black,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "No. of Passengers : $selectedPassenger",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    DropdownButton<dynamic>(
                      isExpanded: false,
                      elevation: 0,
                      hint: Container(
                        alignment: Alignment.center,
                      ),
                      items: noOfPassenger.map((dynamic dropDownString) {
                        return DropdownMenuItem<dynamic>(
                          child: Container(width:W*.1,child: Text(dropDownString.toString())),
                          value: dropDownString,
                        );
                      }).toList(),
                      onChanged: (dynamic selectedItem) {
                        setState(() {
                          selectedPassenger = selectedItem.toString();
                          passenger.passengerCount=selectedPassenger;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
//  Future<String> SpeachToText(context, choice) async {
//    var x;
//    var _localeNames;
//    var _currentLocaleId;
//    ditectedText = null;
//    stt.SpeechToText speech = stt.SpeechToText();
//    var ctx1;
//    showDialog(context: context, builder: (ctx) {
//      ctx1 = ctx;
//      return AlertDialog(
//        shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(H * .02)),
//        content: StatefulBuilder(builder: (ctx, setState) {
//          return Container(
//            height: H * .2,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: [
//                SpinKitWave(
//                  type: SpinKitWaveType.center,
//                  color: Colors.black,
//                  size: H * .04,
//                ),
//                (textDitected) ?
//                Text(ditectedText)
//                    : Text(
//                  "Please Speak . . .", style: TextStyle(fontSize: H * .022),)
//              ],
//            ),
//          );
//        }),
//      );
//    });
//    bool available = await speech.initialize();
//    if (available) {
//      _localeNames = await speech.locales();
//
//      var systemLocale = await speech.systemLocale();
//      _currentLocaleId = systemLocale.localeId;
//    }
//    if (available) {
//      speech.listen(
//          onResult: (text) {
//            if (double.parse(text.confidence.toString()) > 0) {
//              print(text.recognizedWords);
//              ditectedText = text.recognizedWords;
//              Navigator.pop(ctx1);
//              showDialog(context: context, builder: (ctx) {
//                return AlertDialog(
//                  title: Text("Searching For :", textAlign: TextAlign.center,),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(H * .02),),
//                  content: Container(
//                    height: H * .15,
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        Container(
//                            width: W * .7,
//                            alignment: Alignment.center,
//                            margin: EdgeInsets.symmetric(horizontal: H * .01),
//                            child: Text(ditectedText, style: TextStyle(
//                                fontSize: H * .02, fontWeight: FontWeight.bold),
//                              textAlign: TextAlign.center,)),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: [
//                            RaisedButton(
//                              color: Colors.black,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(H),),
//                              child: Container(
//                                width: W * .2,
//                                alignment: Alignment.center,
//                                child: Text("Retry",
//                                  style: TextStyle(color: Colors.yellow),),
//                              ),
//                              onPressed: () {
//                                Navigator.pop(ctx);
//                                SpeachToText(context, choice);
//                              },
//                            ),
//                            RaisedButton(
//                              color: Colors.black,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(H),),
//                              child: Container(
//                                width: W * .2,
//                                alignment: Alignment.center,
//                                child: Text("Yes",
//                                  style: TextStyle(color: Colors.yellow),),
//                              ),
//                              onPressed: () {
//                                Navigator.pop(ctx);
//                                applyStartingStopText(
//                                    ditectedText, context, choice);
//                              },
//                            ),
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
//                );
//              });
//            }
//          },
//          listenFor: Duration(seconds: 5),
//          localeId: _currentLocaleId,
//          cancelOnError: true,
//          partialResults: true,
//          listenMode: stt.ListenMode.confirmation);
//    }
//    else {
//      print("The user has denied the use of speech recognition.");
//    }
//    // some time later...
//    Future.delayed(Duration(seconds: 7), () {
//      speech.stop();
//      (ditectedText == null) ? Navigator.pop(ctx1) : print("");
//    });
//  }

//  applyStartingStopText(text, context, choice) {
//    var x = [];
//    var count = 0;
//    var s = "";
//    for (var i in Stops) {
//      if (i.trim().toLowerCase() == text.toString().toLowerCase()) {
//        s = i;
//        count++;
//        break;
//      } else
//      if (i.trim().toLowerCase().contains(text.toString().toLowerCase())) {
//        if (!x.contains(i)) {
//          x.add(i);
//        }
//      }
//    }
//    if (count > 0) {
//      if (choice == 0) {
//        setState(() {
//          fromStopController.text = s;
//        });
//      } else {
//        setState(() {
//          toStopController.text = s;
//        });
//      }
//    } else {
//      showDialog(context: context, builder: (ctx) {
//        var selectedIndex = [];
//        var selectedItem = "";
//        var staticIndex = [];
//        for (var i in x) {
//          selectedIndex.add(false);
//        }
//        selectedIndex.add(false);
//        staticIndex = selectedIndex;
//        return AlertDialog(
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(H * .02)),
//            title: Text("Choose From", textAlign: TextAlign.center,),
//            content: StatefulBuilder(builder: (ctx, setState) {
//              return Container(
//                height: H * .04 * (x.length + 3.5),
//                width: W,
//                alignment: Alignment.center,
//                margin: EdgeInsets.symmetric(horizontal: H * .01),
//                child: (x.length == 0) ?
//                Text("There is no Bus Stop matches with your choice",
//                  textAlign: TextAlign.center,)
//                    : ListView.builder(
//                  itemCount: x.length,
//                  itemBuilder: (ctx, index) {
//                    return Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                        GestureDetector(
//                          onTap: () {
//                            for (var i = 0; i < selectedIndex.length; i++) {
//                              setState(() {
//                                selectedIndex[i] = false;
//                              });
//                            }
//                            setState(() {
//                              selectedIndex[index] = true;
//                              selectedItem = x[index];
//                            });
//                          },
//                          child: Container(
//                            height: H * .045,
//                            width: W,
//                            margin: EdgeInsets.symmetric(vertical: H * .005),
//                            alignment: Alignment.center,
//                            decoration: BoxDecoration(
//                                color: (selectedIndex[index])
//                                    ? Colors.black
//                                    : Colors.white,
//                                border: Border.all(color: Colors.black),
//                                borderRadius: BorderRadius.circular(H * .02)
//                            ),
//                            child: Text(
//                              x[index], overflow: TextOverflow.ellipsis,
//                              style: TextStyle(color: (!selectedIndex[index])
//                                  ? Colors.black
//                                  : Colors.white,),),
//                          ),
//                        ),
//                        (index == x.length - 1) ? GestureDetector(
//                          onTap: () {
//                            for (var i = 0; i < selectedIndex.length; i++) {
//                              setState(() {
//                                selectedIndex[i] = false;
//                              });
//                            }
//                            setState(() {
//                              selectedIndex[x.length] = true;
//                              selectedItem = "None Of The Above";
//                            });
//                          },
//                          child: Container(
//                            height: H * .045,
//                            width: W,
//                            alignment: Alignment.center,
//                            decoration: BoxDecoration(
//                                color: (selectedIndex[x.length])
//                                    ? Colors.black
//                                    : Colors.white,
//                                border: Border.all(color: Colors.black),
//                                borderRadius: BorderRadius.circular(H * .02)
//                            ),
//                            child: Column(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: [
//                                Text("None Of The Above", style: TextStyle(
//                                  color: (!selectedIndex[x.length]) ? Colors
//                                      .black : Colors.white,
//                                ),),
//                              ],
//                            ),
//                          ),
//                        ) : Center(),
//                        (index == x.length - 1) ?
//                        RaisedButton(
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(H)),
//                          color: Colors.black,
//                          child: Container(
//                            width: W,
//                            alignment: Alignment.center,
//                            child: Text("Select",
//                              style: TextStyle(color: Colors.yellow),),
//                          ),
//                          onPressed: () {
//                            if (selectedItem.trim() != "") {
//                              if (x.contains(selectedItem)) {
//                                if (choice == 0) {
//                                  setState(() {
//                                    fromStopController.text = selectedItem;
//                                  });
//                                } else {
//                                  setState(() {
//                                    toStopController.text =
//                                        selectedItem;
//                                  });
//                                }
//                              }
//                              Navigator.pop(ctx);
//                            }
//                          },
//                        ) : Center()
//                      ],
//                    );
//                  },
//                ),
//              );
//            },)
//        );
//      });
//    }
//  }
}
class AllStops {
  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(Stops);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}