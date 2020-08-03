import 'package:chalechalo/Constants/constants.dart';
import 'package:chalechalo/DriverHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main.dart';
class ChangeStream extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChangeStreamState();
  }
}
class ChangeStreamState extends State<ChangeStream>{
  var riding=false;
  bool isSaving=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: YELLOW_ACCENT,
      appBar: AppBar(
      backgroundColor: Colors.black,
        title: Text("Change Stream"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: H*.35,
          width: W,
          margin: EdgeInsets.all(H*.01),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(H*.02),
            boxShadow: [BoxShadow(color: Colors.grey[600],blurRadius: 10)],
            color: YELLOW
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your are at your destination",style: TextStyle(fontSize: H*.027,fontWeight: FontWeight.w600),),
              Text("Before starting new journey mark your self riding",style: TextStyle(fontSize: H*.022),textAlign: TextAlign.center,),
              SizedBox(height: H*.04,),
              Text("Have you started your next ride ?",style: TextStyle(fontSize: H*.02,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: H*.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Bus is not",style: TextStyle(fontSize: H*.03,fontWeight: FontWeight.bold,
                          color: (!riding)?Colors.black:Colors.grey
                      ),),
                      Text("Running",style: TextStyle(fontSize: H*.03,fontWeight: FontWeight.bold,
                          color: (!riding)?Colors.black:Colors.grey
                      )),
                    ],
                  ),
                  Switch(value: riding,
                     activeColor: Colors.black,
                      onChanged:(val){
                    setState(() {
                      riding=val;
                    });
                    print(riding);
                  }),
                  Column(
                    children: [
                      Text("Bus is",style: TextStyle(fontSize: H*.03,fontWeight: FontWeight.bold,
                        color: (riding)?Colors.black:Colors.grey
                      ),),
                      Text("Running",style: TextStyle(fontSize: H*.03,fontWeight: FontWeight.bold,
                          color: (riding)?Colors.black:Colors.grey
                      )),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: (){
          if(riding){
            var db=Firestore.instance;
            db.collection("DelhiBus").document(profileData.busRegistrationNumber).get().then((value){
              var upstream=value.data["upstream"];
              db.collection("DelhiBus").document(profileData.busRegistrationNumber).updateData({"upstream":!upstream}).whenComplete((){
                IS_RIDING=true;
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (ctx)=>DriverHomePage()
                ), (route) => false);
              });
            });
          }
        },
        child: Container(
          height: H*.07,
          width: W,
          color: Colors.black,
          alignment: Alignment.center,
          child: (isSaving)?SpinKitRing(
            size: H*.03,
            lineWidth: H*.002,
            color: Colors.yellow,
          ):Text("Proceed",style: TextStyle(fontSize: H*.02,fontWeight: FontWeight.bold,color: Colors.yellow),),
        ),
      )
    );
  }
}