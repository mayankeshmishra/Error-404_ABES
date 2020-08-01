//history_page_final

import 'package:chalechalo/drawer.dart';
import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';

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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  margin:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 21.0),
                  child: ListTile(
                    leading: Text(
                      'Recents',
                      style: TextStyle(
                        fontFamily: ' Roboto-italic',
                        fontStyle: FontStyle.italic,
                        fontSize: 40,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: FloatingActionButton(
                      onPressed: _openFilterList,
                      tooltip: 'Increment',
                      backgroundColor: Colors.black87,
                      child: Text('Filter',
                      style: TextStyle(color: Colors.amber),),
                    ),
                  ),
                ),
                dateField,
                detailsField,
                detailsField,
                detailsField,
                dateField,
                detailsField,
                detailsField,
                detailsField,
              ],
            ),
          ),
        ),
      ),
      drawer: drawer(context)
    );
  }
}
