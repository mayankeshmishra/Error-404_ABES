
import 'package:chalechalo/Authentication/loginPage.dart';
import 'package:chalechalo/drawer.dart';
import 'package:chalechalo/history.dart';
import 'package:chalechalo/main.dart';
import 'package:chalechalo/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chalechalo/passengerForm/passenger.dart';
import 'package:chalechalo/passengerForm/empty_state.dart';
import 'package:chalechalo/passengerForm/form.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Constants/constants.dart';

class AddPassengerPage extends StatefulWidget {
  @override
  _AddPassengerPageState createState() => _AddPassengerPageState();
}

class _AddPassengerPageState extends State<AddPassengerPage> {
  List<UserForm> users = [];
  var formOpen=false;
  var user;
  bool isTicketBooked=false;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Center(
            child: Text(
              'Add Passenger',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          backgroundColor: Colors.amber,
        ),
        body: ListView(
          children: [
            Container(
              height: H*.55,
              alignment: Alignment.center,
                    child: users.length <= 0
                        ? Center(
                            child: EmptyState(
                              title: 'Oops !!',
                              message: 'Add passenger by tapping add button below',
                            ),
                          )
                        : Container(
                      height: H*.55,
                          child:  users[0],
                        ),
                  ),
            SizedBox(height: H*.01,),
            (isTicketBooked)?SpinKitRing(color: Colors.black,size: H*.06,lineWidth: H*.004,):Center()
          ],
        ),
          floatingActionButton: FloatingActionButton.extended(
                icon: Icon((formOpen==false)?Icons.person_add:Icons.book, color: Colors.amber,),
                onPressed: (){
                    if(formOpen==false){
                      onAddForm();
                    }else{
                      if(passenger.from!="" && passenger.to!="" && passenger.passengerCount!="---" &&
                            passenger.phoneNumber!=""){
                        showDialog(context:context,builder: (ctx){
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(H*.02),),
                            title: Text("Collect Money",textAlign: TextAlign.center,style: TextStyle(
                                fontSize: H*.02,fontWeight: FontWeight.bold
                            ),),
                            content:  Container(
                                  height: H*.15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("30 ₹",style: TextStyle(fontSize: H*.05),textAlign: TextAlign.center,),
                                      Container(
                                        margin: EdgeInsets.only(left: H*.02,right: H*.02),
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(H)),
                                          color: Colors.black,
                                          child: Container(
                                              width: W,
                                              alignment: Alignment.center,
                                              child: Text("Book Now",style: TextStyle(color: Colors.white),)
                                          ),
                                          onPressed: (){
                                            bookTicket();
                                            setState(() {
                                              isTicketBooked=true;
                                            });
                                            Navigator.pop(ctx);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                          );
                        });
                      }else{
                        print("Invalid Entry");
                      }
                    }
                },
                label: Text((formOpen==false)?'Add more Passenger':"Book Ticket",
                style: TextStyle(
                  color: Colors.amber,
                ),),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black87,
              ),
        drawer:drawer(context)
      ),
    );
  }

  void onDelete(User _user) {
    setState(() {
      formOpen=false;
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      formOpen=true;
      var _user = User();
      user=_user;
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }
  bookTicket(){
    var amount="30";
    String transactionId="${passenger.phoneNumber};${profileData.busRegistrationNumber};${passenger.from};${passenger.to};${passenger.passengerCount};$amount";
    var db=Firestore.instance;
    var dateParse = DateTime.parse(DateTime.now().toString());
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    String date = formattedDate.toString();
    db.collection("DelhiBus").document(profileData.busRegistrationNumber).
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
        db.collection("DelhiBus").document(profileData.busRegistrationNumber).
        collection("tickets").document(date).setData({"allTickets":[{
          "transactionId": transactionId,
          "isVerified":false,
        }]}).whenComplete((){
          print("Ticket Saved in Bus Side (NEW)");
          setState(() {
            formOpen=false;
            isTicketBooked=false;
          });
          passenger=Passenger("","","","");

          onDelete(user);
        });
      }
      else{
        docData.add({"transactionId": transactionId,
          "isVerified":false,});
        db.collection("DelhiBus").document(profileData.busRegistrationNumber).
        collection("tickets").document(date).updateData({"allTickets":docData}).whenComplete((){
          print("Ticket Saved in Bus Side (OLD)");
          passenger=Passenger("","","","");
          setState(() {
            formOpen=false;
            isTicketBooked=false;
          });
          onDelete(user);
        });
      }
    });
  }

  ///on save forms
//  void onSave() {
//    if (users.length > 0) {
//      var allValid = true;
//      users.forEach((form) => allValid = allValid && form.isValid());
//      if (allValid) {
//        var data = users.map((it) => it.user).toList();
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            fullscreenDialog: true,
//            builder: (_) => Scaffold(
//              appBar: AppBar(
//                title: Text('List of Users'),
//              ),
//              body: ListView.builder(
//                itemCount: data.length,
//                itemBuilder: (_, i) => ListTile(
//                  leading: CircleAvatar(
//                    child: Text(data[i].fullName.substring(0, 1)),
//                  ),
//                  title: Text(data[i].fullName),
//                  subtitle: Text(data[i].age),
//                ),
//              ),
//            ),
//          ),
//        );
//      }
//    }
//  }
}