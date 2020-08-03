import 'package:carousel_slider/carousel_slider.dart';
import 'package:chalechalo/Constants/constants.dart';
import 'package:chalechalo/DriverHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';

class NavigationUrl extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NavigationUrlState();
  }

}
class NavigationUrlState extends State<NavigationUrl>{
  bool isVerifying=false;
  String url="";
  String mainError="";
  @override
  Widget build(BuildContext context) {
    emergencyContext=context;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Link"),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          SizedBox(height: H*.02,),
          Text("Follow Steps to get the link",style: TextStyle(fontSize: H*.022,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            Container(
              height: H*.45,
              padding: EdgeInsets.symmetric(vertical: H*.02),
              child:  CarouselSlider(
                options: CarouselOptions(
                    height: H*.5,
                    initialPage: 0,
                    aspectRatio: 5/8,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true
                ),
                items: [
                  item1(),
                  item2(),
                  item3(),
                  item4(),
                ],
              ),
            ),
          SizedBox(height: H*.03,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: H*.01),
            child: RaisedButton(
              color: YELLOW_ACCENT,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(H)),
              child: Container(
                width: W,
                height: H*.03,
                alignment: Alignment.center,
                child: Text("Open Google Map"),
              ),
              onPressed: ()async{
                String url="https://maps.app.goo.gl/rRYYYSzopKV2j9dK8";
                if (await canLaunch(url)) {
                await launch(url);
                } else {
                throw 'Could not launch $url';
                }
              },
            ),
          ),
          SizedBox(height: H*.03,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: H*.01),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.grey,blurRadius: 10
              )]
            ),
            child: TextField(
              keyboardType: TextInputType.url,
              maxLines: 4,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Paste LINK Here",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 2),
                  borderRadius: BorderRadius.circular(H*.02)
                ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 2),
                      borderRadius: BorderRadius.circular(H*.02)
                  )
              ),
              onChanged: (val){
                url=val;
              },
            ),
          ),
          SizedBox(height: H*.01,),
          Text(mainError,style: TextStyle(color: Colors.red),textAlign: TextAlign.center,)
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          if(url.trim().contains("https://maps.app.goo.gl/")){
            var splits=url.split("https://maps.app.goo.gl/");
            print("https://maps.app.goo.gl/"+splits[1]);
            verifyUrl("https://maps.app.goo.gl/"+splits[1]);
          }else{
            setState(() {
              mainError="Please enter a valid Link";
            });
          }
        },
        child: Container(
          height: H*.07,
          color: Colors.black,
          alignment: Alignment.center,
          child: (isVerifying)?SpinKitRing(
            color: Colors.white,
            size: H*.04,
            lineWidth: H*.003,
          ):Text("Proceed",style: TextStyle(fontSize: H*.021,fontWeight: FontWeight.bold,color: Colors.white),)
        ),
      ),
    );
  }
  verifyUrl(url){
    setState(() {
      isVerifying=true;
    });
    http.head(url).then((value){
      if(value.statusCode==200){
        var db=Firestore.instance;
        db.collection("DelhiBus").document(profileData.busRegistrationNumber).updateData({"navigationUrl":url}).then((value){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (ctx)=> DriverHomePage()
          ), (route) => false);
        });
      }else{
        setState(() {
          mainError="Please enter a valid Link";
        });
      }
      setState(() {
        isVerifying=false;
      });
    });
  }
  Widget item1(){
    return Container(
      height: H*.4,
      width: W,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.all(H*.005),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(H*.02),
        border: Border.all(color: Colors.black)
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(H*.018),
          child: Image.asset("assets/step1.png",fit: BoxFit.fill,)),
    );
  }
  Widget item2(){
    return Container(
      height: H*.4,
      width: W,
      padding: EdgeInsets.all(H*.005),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(H*.02),
          border: Border.all(color: Colors.black)
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(H*.018),
          child: Image.asset("assets/step2.png",fit: BoxFit.fill,)),
    );
  }
  Widget item3(){
    return Container(
      height: H*.4,
      width: W,
      padding: EdgeInsets.all(H*.005),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(H*.02),
          border: Border.all(color: Colors.black)
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(H*.018),
          child: Image.asset("assets/step3.png",fit: BoxFit.fill,)),
    );
  }
  Widget item4(){
    return Container(
      height: H*.4,
      width: W,
      padding: EdgeInsets.all(H*.005),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(H*.02),
          border: Border.all(color: Colors.black)
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(H*.018),
          child: Image.asset("assets/step4.png",fit: BoxFit.fill,)),
    );
  }
}