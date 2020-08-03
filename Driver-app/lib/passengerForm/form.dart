import 'package:chalechalo/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:chalechalo/passengerForm/passenger.dart';
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
                margin: EdgeInsets.only(left: H*.02, right: H*.02, top: H*.02, bottom: H*.015),
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
              Container(
                margin: EdgeInsets.only(left: H*.02, right: H*.02,  bottom: H*.015),
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
                margin: EdgeInsets.only(left: H*.02, right: H*.02,  bottom: H*.015),
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
                margin: EdgeInsets.only(left: H*.02, right: H*.02,  bottom: H*.015),
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

}
class AllStops {
  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(Stops);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}