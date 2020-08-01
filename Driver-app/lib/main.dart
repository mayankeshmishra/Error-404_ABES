//import 'package:chalechalodriver/account_history.dart';
// import 'package:chalechalo/profile.dart';
// import 'package:chalechalo/login.dart';
// import 'package:chalechalo/destination.dart';
import 'package:chalechalo/ticket.dart';
// import 'package:chalechalo/payment.dart';
//import 'package:chalechalo/QRViewExample.dart';
import 'package:flutter/material.dart';

void main() => runApp(ChaleChalo());

class ChaleChalo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chale chalo',
        home: TicketPage()
    );
  }
}