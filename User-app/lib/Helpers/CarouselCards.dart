

import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class CarouselCard {
  @override
  getCard({double H, double W,String eta,String busNo,String fromStop,String toStop, int totalRating, int noOfRatings, String price, int passengers, int capacity}) {
    String estimate=eta;
    estimate=estimate.trim();
    String suffix=estimate.substring(estimate.indexOf(' '));
    estimate=estimate.substring(0,estimate.indexOf(' '));
    double factor=0;
    if(fromStop.length>toStop.length){
      factor=1/(fromStop.length/200);
    }
    else{
      factor=1/(toStop.length/220);
    }
    return Container(
              width: W * 0.7,
              color: Colors.white,
              margin: EdgeInsets.all(5.0),
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    Container(
                      color: Colors.yellow,
                      padding: EdgeInsets.only(top: 2, bottom: 2, left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: <Widget>[
                          Text(
                            estimate,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            suffix,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Container(
                            color: Colors.black,
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                price,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('Bus No :',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400)),
                          Text(busNo,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LinearPercentIndicator(
                          width: W * 0.5,
                          lineHeight: 14.0,
                          percent: passengers/capacity,
                          animation: true,
                          animationDuration: 2000,
                          leading: Icon(Icons.mood, color: Colors.green),
                          trailing: Icon(Icons.mood_bad, color: Colors.red),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          backgroundColor: Colors.black26,
                          progressColor: Color(0Xffffd600),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        '$passengers/$capacity',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(fromStop,
                            style: TextStyle(
                              fontSize: factor,
                            )),
                        Icon(
                          Icons.compare_arrows,
                          color: Color(0Xffffd600),
                          size: 30,
                        ),
                        Text(toStop,
                            style: TextStyle(
                              fontSize: factor,
                            ))
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RatingBarIndicator(
                          rating: totalRating/noOfRatings,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Color(0Xffffd600),
                          ),
                          itemCount: 5,
                          itemSize: 25.0,
                          itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                          direction: Axis.horizontal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}
