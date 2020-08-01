import 'package:chale_chalo/Constants/constants.dart';
import 'package:chale_chalo/Constants/faqs.Infodart.dart';
import 'package:chale_chalo/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Faqs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FaqsState();
  }
}

class FaqsState extends State<Faqs> {
  List<bool> open = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("FAQs", style: TextStyle(color: YELLOW),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.yellow,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: Container(
            height: H,
            margin: EdgeInsets.symmetric(
                horizontal: H * .005, vertical: H * .01),
            child: ListView.builder(
              itemCount: heading.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    RaisedButton(
                      color: (open[index]) ? YELLOW : Colors.black,
                      onPressed: () {
                        if (open[index]) {
                          setState(() {
                            open[index] = false;
                          });
                        }
                        else {
                          setState(() {
                            open[index] = true;
                            for (var i = 0; i < open.length; i++) {
                              if (i != index) {
                                setState(() {
                                  open[i] = false;
                                });
                              }
                            }
                          });
                        }
                      },
                      child: Container(
                        width: W * .9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: W * .8,
                                height: H * .06,
                                alignment: Alignment.centerLeft,
                                child: Text(heading[index], style: TextStyle(
                                    fontSize: H * .018,
                                    color: (open[index])
                                        ? Colors.black
                                        : YELLOW),)),
                            (open[index]) ? Icon(Icons.arrow_drop_up,
                                color: (open[index]) ? Colors.black : YELLOW) :
                            Icon(Icons.arrow_drop_down,
                                color: (open[index]) ? Colors.black : YELLOW)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: H * .005,),
                      padding: EdgeInsets.symmetric(vertical: H * .005,),

                      child: (open[index]) ? answer(index) : Container(),
                    ),
                    SizedBox(height: H * .005,),
                    (index == open.length - 1) ? SizedBox(height: H * .02
                      ,) : Container(),
                    (index == open.length - 1) ? GestureDetector(
                        onTap: () {
                          launchUrl();
                        },
                        child: Column(
                          children: [
                            Text(
                              "If you not find your question? Kindly submit a query!!",
                              style: TextStyle(color: Colors.blue),),
                          ],
                        )) : Container()
                  ],
                );
              },
            ),
          ),
        )
    );
  }

  Widget Q1() {
    return Container(
      width: W,
      child: Column(
        children: [
          Text(
              "You have various options when it comes to paying for your ride."),
          SizedBox(height: H * .02,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("◘"),
              SizedBox(width: W * .02,),
              Container(
                width: W * .9,
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: H * .02),
                      children: [
                        TextSpan(text: "Paytm --  ",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                            text: "If you have a Paytm account, you can opt Paytm option to pay for your ride. We will simply redirect you their so that you can easily pay for your ride.")
                      ]
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: H * .02,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("◘"),
              SizedBox(width: W * .02,),
              Container(
                width: W * .9,
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: H * .02),
                      children: [
                        TextSpan(text: "Credit/Debit Card -- ",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                            text: "If you have opted to pay through your Card and you have the total amount, just select the card or add card details and pay.")
                      ]
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: H * .02,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("◘"),
              SizedBox(width: W * .02,),
              Container(
                width: W * .9,
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: H * .02),
                      children: [
                        TextSpan(text: "Net Banking -- ",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                            text: "You can also directly pay from your bank account using net banking. We support large number of Banks.")
                      ]
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: H * .02,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("◘"),
              SizedBox(width: W * .02,),
              Container(
                width: W * .9,
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: H * .02,),

                      children: [
                        TextSpan(text: "Cash -- ",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                          text: "If you opt to pay in cash for your ride, we request you to carry enough change to pay for your ride. Otherwise you can simply pay online through above mentioned options.(Only available for offline tickets)",)
                      ]
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: H * .02,),
          Text(
              "Note- We request you to pick the payment option carefully before confirming your ticket.",
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget Q2() {
    return Container(
      width: W,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("◘"),
              SizedBox(width: W * .02,),
              Container(
                width: W * .9,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: H * .02),
                      children: [
                        TextSpan(
                            text: "Then, you can manually enter you starting bus stop and destination stop OR you can simply use "),
                        TextSpan(text: "Bus Stops Near Me",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                            text: "  option if you don’t know the nearest bus stop. ")
                      ]
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: W * .02,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("◘"),
              SizedBox(width: W * .02,),
              Container(
                width: W * .9,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: H * .02),
                      children: [
                        TextSpan(text: "You can even use  "),
                        TextSpan(text: "Navigate To Your Stop ",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                            text: "  to simply know the path or navigate to your bus stop.")
                      ]
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: W * .02,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("◘"),
              SizedBox(width: W * .02,),
              Container(
                width: W * .9,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: H * .02),
                      children: [
                        TextSpan(
                            text: "After entering Starting point and destination, select  "),
                        TextSpan(text: "Search Buses  ",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        TextSpan(text: "  to know the details of buses.")
                      ]
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget Q3() {
    return Column(
      children: [
        Text("Once you have booked your seat i.e. you brought the ticket.",
          style: TextStyle(color: Colors.black, fontSize: H * .02),),
        SizedBox(height: W * .02,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("◘"),
            SizedBox(width: W * .02,),
            Container(
              width: W * .9,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: H * .02),
                    children: [
                      TextSpan(text: "If "),
                      TextSpan(text: "online, ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "you can simply start tracking your bus as soon as you are redirected to the next page.")
                    ]
                ),
              ),
            )
          ],
        ),
        SizedBox(height: W * .02,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("◘"),
            SizedBox(width: W * .02,),
            Container(
              width: W * .9,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: H * .02),
                    children: [
                      TextSpan(text: "If "),
                      TextSpan(text: "offline, ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "make sure to scan the generated QR so that you can get tracking option available for you.")
                    ]
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget Q4() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: W * .95,
              alignment: Alignment.center,
              child: Text(
                "Emergency button is designed to ensure a safer ride for our users. Once you press the Emergency button a SOS message along with your location is sent to your Emergency Contacts as well as us.",
                style: TextStyle(color: Colors.black, fontSize: H * .019),
                textAlign: TextAlign.justify,),
            )
          ],
        ),
        SizedBox(height: W * .02,),
        Container(
          width: W * .9,
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: H * .02),
                children: [
                  TextSpan(text: "Use "),
                  TextSpan(text: "Share Location, ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "whenever you want to share your location to any contact of yours.")
                ]
            ),
          ),
        ),
        SizedBox(height: W * .02,),
        Container(
          width: W * .95,
          alignment: Alignment.center,
          child: Text(
            "NOTE:  Please use Emergency button wisely as false alarms can force us to take action against you.",
            style: TextStyle(color: Colors.black,
                fontSize: H * .019,
                fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),

        )
      ],
    );
  }

  Widget Q5() {
    return Container(
        width: W * .95,
        child: Text(
          "Select Share Location button and enter the mobile number to which you want to share your location and press enter.",
          style: TextStyle(fontSize: H * .019,), textAlign: TextAlign.justify,)
    );
  }

  Widget answer(index) {
    return (index == 0) ? Q1() :
    (index == 1) ? Q2() :
    (index == 2) ? Q3() :
    (index == 3) ? Q4() : Q5();
  }

  launchUrl() async {
    var url = 'mailto:chalechalosih@gmail.com?subject=Query | Chale Chalo&body=Please do not change the subject.';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
