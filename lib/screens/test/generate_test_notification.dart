// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_collection_literals, avoid_print

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/initFunctions.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/services/shareService.dart';
import 'package:online_panchayat_flutter/services/showNotification.dart';
import 'package:velocity_x/velocity_x.dart';

class GenerateTextNotification extends StatelessWidget {
  const GenerateTextNotification({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () async {
                initialiseNotificationPlugin();
                showTestNotification();
              },
              child: Text(
                "show notification",
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
            onPressed: () async {
              // initialiseNotificationPlugin();
              openNews(context);
            },
            child: Text(
              "open news",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    ));
  }
}

void showTestNotification() async {
  Map<String, dynamic> dataMap = new Map<String, dynamic>();
  dataMap = {
    'title':
        'यूक्रेन को बचाना है तो सरकार का तख्तापलट कर दे फौज; US ने कहा- कीव बहुत जल्द रूसी सेना के कब्जे में होगा',
    'imageURL': 'https://i2.ytimg.com/vi/afAMqMDWpIs/hqdefault.jpg',
    'postShareUrl': 'https://phonepanchayat.com/post/Yi2NnXex3cw5eonr9',
    'postId': 'c3ebbd41-1c19-4fd0-8612-5c4593922669',
  };
  ShowNotification showNotification = ShowNotification(
    message: RemoteMessage(
      data: dataMap,
    ),
  );
  await showNotification.generateNotification();
}

void openNews(BuildContext context) async {
  print(ShareService.getPostShareMessage(
    postContent:
        'यूक्रेन को बचाना है तो सरकार का तख्तापलट कर दे फौज; US ने कहा- कीव बहुत जल्द रूसी सेना के कब्जे में होगा',
    completeUrl: 'https://phonepanchayat.com/post/Yi2NnXex3cw5eonr9',
  ));
  Map<String, String> payload = <String, String>{
    "shareMessage": ShareService.getPostShareMessage(
      postContent:
          'यूक्रेन को बचाना है तो सरकार का तख्तापलट कर दे फौज; US ने कहा- कीव बहुत जल्द रूसी सेना के कब्जे में होगा',
      completeUrl: 'https://phonepanchayat.com/post/Yi2NnXex3cw5eonr9',
    ).replaceAll('\n', '\\n'),
    "postId": 'c3ebbd41-1c19-4fd0-8612-5c4593922669'
  };

  payload = payload.map((key, value) {
    key = "\"$key\"";
    value = "\"$value\"";
    return MapEntry(key, value);
  });

  var parsedData = jsonDecode(payload.toString());
  String postId = parsedData['postId'];
  context.vxNav.push(
    Uri.parse(
      MyRoutes.singlePostViewNotificationRoute,
    ),
    params: postId,
  );
}
