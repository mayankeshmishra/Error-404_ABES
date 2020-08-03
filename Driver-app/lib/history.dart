//history_page_final


import 'package:chalechalo/Constants/constants.dart';
import 'package:chalechalo/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> countList = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "Eleven",
    "Tweleve",
    "Thirteen",
    "Fourteen",
    "Fifteen",
    "Sixteen",
    "Seventeen",
    "Eighteen",
    "Nineteen",
    "Twenty",
  ];
  List<String> selectedCountList = [];
List<int> cashCollected=[];
var historyData;
var x="";
bool showDate=false;
  void _openFilterList() async {
    var list = await FilterList.showFilterList(
      context,
      allTextList: countList,
      height: 480,
      borderRadius: 20,
      headlineText: "Select Count",
      searchFieldHintText: "Search Here",
      selectedTextList: selectedCountList,
    );
    
    if (list != null) {
      setState(() {
        selectedCountList = List.from(list);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    //splitTransactionId("Mayankesh Mishra;+917905084484;UK07BR1628;Delhi Gate;Bara Bagh;2;30.0");
  }
  @override
  Widget build(BuildContext context) {
    final detailsField = Card(
      color: Colors.amber,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 1.0),
      child: ListTile(
        leading: Icon(Icons.attach_money, color: Colors.black),
        title: Text(
          "Paid By - \n Aman Sharma \n\n 09:45",
          style: TextStyle(
              fontFamily: 'Lobster', fontSize: 20, color: Colors.black),
        ),
        trailing: Text(
          "Rs. 45 - \n Paid - Online ",
          style: TextStyle(
              fontFamily: 'Lobster', fontSize: 20, color: Colors.black),
        ),
      ),
    );

    final dateField = Card(
      color: Colors.black87,
      margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      child: ListTile(
        leading: Icon(Icons.calendar_today, color: Colors.amber),
        title: Text(
          "20 July 2020",
          style: TextStyle(
              fontFamily: ' Roboto-italic', fontSize: 20, color: Colors.amber),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account History',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: Image.asset('assets/logo_black.png'),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: H,
        width: W,
        color: Colors.yellow,
        child: (historyData==null)?
        SpinKitRing(
          color: Colors.black,
          size: H * .07,
          lineWidth: H * .005,
        ) :Container(
          child: ListView.builder(
            itemCount: historyData.length,
            itemBuilder: (ctx,index){
              if(historyData[index][0]!=x){
                x=historyData[index][0];
                  showDate=true;
              }else{
                showDate=false;
              }
              return Column(
                children: [
                  (!showDate)? Center():
                      Container(
                        height: H*.07,
                        width: W,
                        padding: EdgeInsets.symmetric(horizontal: H*.02),
                        margin: EdgeInsets.symmetric(vertical: H*.01),
                        color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(historyData[index][0],style: TextStyle(fontSize: H*.03,fontWeight: FontWeight.bold,color: Colors.white),),
                            Column(
                              children: [
                                Text(cashCollected[index].toString(),style: TextStyle(fontSize: H*.03,fontWeight: FontWeight.bold,color: Colors.white),),
                                Text("Cash Collected",style: TextStyle(color: Colors.white),),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(H*.01),
                        margin: EdgeInsets.symmetric(horizontal: H*.01,vertical: H*.005),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(H*.02),
                          boxShadow:[
                            BoxShadow(color: Colors.grey,blurRadius: 10)
                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Container(
                               width: W*.25,
                               height: H*.13,
                               decoration: BoxDecoration(
                                 color: Colors.black,
                                 borderRadius: BorderRadius.circular(H*.02)
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(historyData[index][3],style: TextStyle(fontSize: H*.05,fontWeight: FontWeight.bold,color: Colors.white),),
                                  Text("Passenger",style: TextStyle(fontSize: H*.02,color: Colors.white),),
                                ],
                            ),
                             ),
                             Container(
                               width: W*.4,
                               child: Column(
                                children: [
                                  Text(historyData[index][1],style: TextStyle(fontSize: H*.022,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                  SizedBox(height: H*.01,),
                                  Text("TO",style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: H*.01,),
                                  Text(historyData[index][2],style: TextStyle(fontSize: H*.02,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                ],
                            ),
                             ),
                            Container(
                              width: W*.25,
                              child: Column(
                                children: [
                                  Text(historyData[index][4],style: TextStyle(fontSize: H*.05,fontWeight: FontWeight.bold),),
                                  Text("Cash",style: TextStyle(fontSize: H*.02),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  getData(){
    var db=Firestore.instance;
    var historyData1=[];
    var index=0;
    db.collection("DelhiBus").document(profileData.busRegistrationNumber).collection("tickets").getDocuments()
    .then((value){
      for(var i=value.documents.length-1;i>=0;i--){
        cashCollected.add(0);
        for(var j in value.documents[i].data["allTickets"]){
          List<String> info=[];
            if(splitTransactionId(j["transactionId"].toString()) && j["isVerified"]==true){
              info.add(value.documents[i].documentID);
              info=getDataFromTransactionID(j["transactionId"].toString(), info,index);
                historyData1.add(info);
            }
        }
        index++;
      }
      setState(() {
        historyData=historyData1;
      });
      print(historyData);
    });
  }
  bool splitTransactionId(String id){
    List Splits=id.split(";");
    if(Splits.length==8){
      return false;
    }
    else{
      return true;
    }
  }
  List<String> getDataFromTransactionID(String id,List<String> info,index){
    List Splits=id.split(";");
    if(Splits.length==7){
        info.add(Splits[3]);
        info.add(Splits[4]);
        info.add(Splits[5]);
        info.add(Splits[6]);
        cashCollected[index]=cashCollected[index]+double.parse(Splits[6]).toInt();
    }
    else{
      info.add(Splits[2]);
      info.add(Splits[3]);
      info.add(Splits[4]);
      info.add(Splits[5]);
      cashCollected[index]=cashCollected[index]+double.parse(Splits[5]).toInt();
    }
    return info;
  }
}
