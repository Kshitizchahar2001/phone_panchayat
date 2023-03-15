// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, avoid_unnecessary_containers, deprecated_member_use, prefer_const_constructors

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'dart:math';
import 'package:velocity_x/velocity_x.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSplashScreen extends StatefulWidget {
  @override
  _LoadingSplashScreenState createState() => _LoadingSplashScreenState();
}

class _LoadingSplashScreenState extends State<LoadingSplashScreen> {
  final List<String> quotes = [
    "देश की संस्कृति लोगो के दिलो में और आत्मा में निवास करती है।",
    "लोग अपने कर्तव्यों को भूल जाते हैं पर अधिकारों को याद रखते हैं।",
    "भविष्य इस बात पर निर्भर करता है कि आज आप क्या कर रहे हैं।",
    "वो बदलाव बनिए जो आप दुनिया में देखना चाहते हैं।",
    "समाज की सेवा करने का अवसर हमें अपना ऋण चुकाने का मौका देता हैं।",
  ];
  String randomQuote;

  @override
  void initState() {
    randomQuote = getRandomQuote();
    super.initState();
  }

  String getRandomQuote() {
    try {
      Random random = new Random();
      int randomNumber = random.nextInt(quotes.length);
      return quotes[randomNumber];
    } catch (e) {
      FirebaseCrashlytics.instance
          .log("Error while generating random quote : $e");
      return quotes[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).cardColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Flexible(
              flex: 3,
              child: Image.network(
                APP_ICON_URL,
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: context.safePercentHeight * 5),
              child: Column(
                children: [
                  Padding(
                    padding: getPostWidgetSymmetricPadding(
                      context,
                      vertical: 5,
                      horizontal: 6,
                    ),
                    child: Text(
                      ''' " ${randomQuote.toString()} " ''',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .headline1
                            .color
                            .withOpacity(0.5),
                        fontWeight: FontWeight.normal,
                        fontSize: responsiveFontSize(
                          context,
                          size: ResponsiveFontSizes.s,
                        ),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SpinKitThreeBounce(
                    color: maroonColor,
                    duration: Duration(milliseconds: 800),
                    size: 25,
                  )
                ],
              ),
            ),
            Flexible(
              flex: 6,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
