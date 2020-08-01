import 'package:chalechalo/Constants/constants.dart';
import 'package:chalechalo/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Authentication/loginPage.dart';
import 'history.dart';
import 'main.dart';
Widget drawer(context){
  return Drawer(
      child: Container(
        height: H,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: H*.02,
                bottom: H*.01,
              ),
              color: Colors.amber,
              child: Column(
                children: <Widget>[
                  Container(
                    width: H*.15,
                    height: H*.15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/driver.png',
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    profileData.name,
                    style: TextStyle(
                      fontSize: H*.027,
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    profileData.number,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    color: Colors.black87,
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.amber,
                      ),
                      title: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: H*.02,
                          color: Colors.amber,
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (ctx)=>Profile()
                        ));
                      },
                    ),
                  ),
                  Container(
                    color: Colors.black87,
                    child: ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Colors.amber,
                      ),
                      title: Text(
                        'Account History',
                        style: TextStyle(
                          fontSize: H*.02,
                          color: Colors.amber,
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (ctx)=>HistoryPage()
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.amber,
              child: ListTile(
                leading: Icon(Icons.arrow_back,color:Colors.black87),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: H*.02),
                ),
                onTap: (){
                  FirebaseAuth.instance.signOut().whenComplete(() {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (ctx)=> LoginPage()
                    ), (route) => false);
                  });
                },
              ),
            ),
          ],
        ),
      ));
}