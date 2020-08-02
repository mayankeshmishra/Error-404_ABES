import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

final pages = [
  PageViewModel(
      pageColor: Colors.yellow[300],
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset('assets/track_bus.png'),
      body: Text(
        'Search for buses near you and track your ride',
      ),
      title: Text(
        'Tracking',
      ),
      titleTextStyle: GoogleFonts.pacifico(color: Colors.black),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
      mainImage: Image.asset(
        'assets/track_bus.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  PageViewModel(
      pageColor: Colors.yellow[500],
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset('assets/tickets.png'),
      body: Text(
        'Book Your Tickets Online or Offline',
      ),
      title: Text(
        'Booking',
      ),
      titleTextStyle: GoogleFonts.pacifico(color: Colors.black),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
      mainImage: Image.asset(
        'assets/tickets.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  PageViewModel(
      pageColor: Colors.yellow[600],
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset('assets/passengers.png'),
      body: Text(
        'Take a count on number of passengers traveling with you.',
      ),
      title: Text(
        'Passengers',
      ),
      titleTextStyle: GoogleFonts.pacifico(color: Colors.black),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
      mainImage: Image.asset(
        'assets/passengers.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  PageViewModel(
      pageColor: Colors.yellow[700],
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset('assets/share_location.png'),
      body: Text(
        'Automatically share your location with your loved ones.',
      ),
      title: Text(
        'Emergency',
      ),
      titleTextStyle: GoogleFonts.pacifico(color: Colors.black),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
      mainImage: Image.asset(
        'assets/share_location.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
];
