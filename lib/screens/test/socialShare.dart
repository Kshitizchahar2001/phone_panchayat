// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class SocialShareTest extends StatelessWidget {
  const SocialShareTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(
                "Social content share fb",
              ),
              onPressed: () async {
                FlutterShareMe flutterShareMe = FlutterShareMe();
                String response = await flutterShareMe.shareToFacebook(
                  url: "https://www.apple.com",
                  msg: "captions",
                );
                print(response.toString());
              },
            ),
            TextButton(
              child: Text(
                "Social content share wtsp",
              ),
              onPressed: () async {
                FlutterShareMe flutterShareMe = FlutterShareMe();
                String response = await flutterShareMe.shareToWhatsApp(
                  msg: "captions https://www.apple.com",
                );
                print(response.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
