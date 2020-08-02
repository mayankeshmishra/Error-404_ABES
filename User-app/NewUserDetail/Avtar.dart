import 'dart:io';

import 'package:chale_chalo/Authentication/register.dart';
import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/SerchDestination/searchDestination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../main.dart';

class Avtar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AvtarState();
  }
}

class AvtarState extends State<Avtar> {
  var uploading = false;
  File profilePic;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: YELLOW,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: H * .32,
                    child: Image.asset("assets/dp.png"),
                  ),
                  SizedBox(
                    height: H * .01,
                  ),
                  Text(
                    "Upload Profile Picture",
                    style: TextStyle(
                        fontSize: H * .027, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: H * .02,
                  ),
                  Container(
                    padding: EdgeInsets.all(H * .005),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.black)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: H * .3,
                          width: H * .3,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: (profilePic != null)
                              ? Image.file(
                                  profilePic,
                                  fit: BoxFit.cover,
                                )
                              : Center(),
                        ),
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(H * .02)),
                                      title: Text(
                                        "Choose A Plateform",
                                        style: TextStyle(fontSize: H * .02),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Container(
                                        height: H * .1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      pickFromGallery();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.photo,
                                                      size: H * .07,
                                                    )),
                                                Text("Gallery")
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      pickFromCamera();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.photo_camera,
                                                      size: H * .07,
                                                    )),
                                                Text("Camera")
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.camera_alt,
                              size: H * .07,
                              color: Colors.black38,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: H * .08,
                  ),
                  RaisedButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(H)),
                    child: Container(
                      width: W * .7,
                      alignment: Alignment.center,
                      height: H * .06,
                      child: (uploading)
                          ? SpinKitRing(
                              color: YELLOW,
                              size: H * .03,
                              lineWidth: H * .003,
                            )
                          : Text(
                              "UPLOAD",
                              style:
                              TextStyle(fontSize: H * .025, color: YELLOW),
                            ),
                    ),
                    onPressed: () {
                      if (profilePic != null) {
                        saveToDevice(profilePic, context);
                      }
                      else {
                        Toast.show("Please choose a photo", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }

  pickFromGallery() async {
    var picker = ImagePicker();
    var file = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 300,
        maxWidth: 300);
    if (file != null) {
      setState(() {
        profilePic = File(file.path);
      });
    }
  }

  pickFromCamera() async {
    var picker = ImagePicker();
    var file = await picker.getImage(source: ImageSource.camera, maxHeight: 300,
        maxWidth: 300);
    setState(() {
      profilePic = File(file.path);
    });
  }

  void saveToDevice(img, context) async {
    setState(() {
      uploading = true;
    });
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "/${basename(img.path)}";
    File localProfilePic = await img.copy(path);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("DpPath", path);
    print(path);
    print("size${((localProfilePic
        .readAsBytesSync()
        .length) / 1024)}");
    uploadDp(img, context, path);
  }

  void uploadDp(img, context, path) async {
    StorageReference storageReference;
    storageReference = await FirebaseStorage.instance
        .ref()
        .child(phoneNumber)
        .child("avtar");
    StorageUploadTask task = storageReference.putFile(img);
    (await task.onComplete).ref.getDownloadURL().then((url) {
      var db = Firestore.instance;
      db.collection("AllUsers").document(phoneNumber).updateData(
          {"avtar": url, "avtarPath": path}).whenComplete(() {
        setState(() {
          uploading = false;
        });
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (ctx) => SearchDestination()
        ), (route) => false);
      });
    });
  }
}
