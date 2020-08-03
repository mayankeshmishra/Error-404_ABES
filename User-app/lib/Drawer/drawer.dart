import 'package:chale_chalo/Authentication/otpScreen.dart';
import 'package:chale_chalo/Authentication/register.dart';
import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/Drawer/faqs.dart';
import 'package:chale_chalo/Drawer/previousBooking.dart';
import 'package:chale_chalo/Drawer/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

var name = "---";
var phone = "---";
Widget drawer(BuildContext context) {
  List<String> menuItems = [
    "Profile",
    "Previous Bookings",
    "FAQs",
    "Invite Friend",
    "Complain",
    "Contact Us",
    "Visually Impaired"
  ];
  List<Icon> menuIcons = [
    Icon(
      Icons.person,
      color: YELLOW,
    ),
    Icon(
      FontAwesomeIcons.bus,
      color: YELLOW,
    ),
    Icon(
      FontAwesomeIcons.question,
      color: YELLOW,
    ),
    Icon(
      Icons.group_add,
      color: YELLOW,
    ),
    Icon(
      FontAwesomeIcons.meh,
      color: YELLOW,
    ),
    Icon(
      Icons.contact_mail,
      color: YELLOW,
    ),
    Icon(
      FontAwesomeIcons.blind,
      color: YELLOW,
    )
  ];
  return SafeArea(
    child: Drawer(
      elevation: 10,
      child: Container(
        height: H,
        width: W,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: H * .01),
              width: W,
              color: YELLOW,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(H * .002),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        shape: BoxShape.circle
                    ),
                    child: Container(
                      height: H * .12,
                      width: H * .12,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: (AVTAR != null) ? Image.file(
                        AVTAR, fit: BoxFit.fill,) : Image.asset(
                          "assets/dummy_dp.png"),
                    ),
                  ),
                  SizedBox(
                    width: H * .02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        NAME,
                        style: TextStyle(
                            fontSize: H * .025, fontWeight: FontWeight.bold),
                      ),
                      Text(PHONE)
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: H * .45,
                width: W,
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        navigate(index, context);
                      },
                      child: Column(
                        children: [
                          StatefulBuilder(
                            builder: (ctx, setState) {
                              return ListTile(
                                leading: menuIcons[index],
                                title: Text(
                                  menuItems[index],
                                  style:
                                  TextStyle(fontSize: H * .018, color: YELLOW),
                                ),
                                trailing: (index == menuItems.length - 1) ?
                                Switch(
                                  value: blind,
                                  inactiveTrackColor: Colors.grey[600],
                                  activeTrackColor: Colors.yellow,
                                  activeColor: Colors.yellow[800],
                                  onChanged: (val) async {
                                    setState(() {
                                      blind = val;
                                    });
                                    SharedPreferences pref = await SharedPreferences
                                        .getInstance();
                                    pref.setBool("isBlind", val);
                                  },
                                )
                                    : Icon(
                                  Icons.chevron_right,
                                  color: YELLOW,
                                  size: H * .018,
                                ),
                              );
                            },
                          ),
                          Container(
                            width: W,
                            height: H * .001,
                            margin: EdgeInsets.only(
                                left: H * .018, right: H * .018),
                            color: YELLOW,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: H * .02),
              margin: EdgeInsets.only(bottom: H * .03),
              child: Container(
                child: RaisedButton(
                  color: YELLOW,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(H)),
                  child: Container(
                    height: H * .05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                            quarterTurns: 2,
                            child: Icon(FontAwesomeIcons.signOutAlt)),
                        SizedBox(
                          width: H * .03,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    FireBase.auth.signOut().whenComplete(() {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (ctx) => Register()
                      ), (route) => false);
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

navigate(index, context) {
  switch (index) {
    case 0:
      {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => Profile()));
      }
      break;
    case 1:
      {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => PreviousBooking()));
      }
      break;
    case 2:
      {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => Faqs()));
      }
      break;
    case 3:
      {
        Share.share('Travel with Chale Chalo and insure a Safe journey');
      }
      break;
    case 4:
      {
        launchUrl(
            'mailto:chalechalosih@gmail.com?subject=Complaint | Chale Chalo&body=Please do not change the subject.');
      }
      break;
    case 5:
      {
        launchUrl(
            'mailto:chalechalosih@gmail.com?subject=Contact | Chale Chalo&body=Please do not change the subject.');
      }
  }
}

launchUrl(url) async {
  print("arrive");
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


