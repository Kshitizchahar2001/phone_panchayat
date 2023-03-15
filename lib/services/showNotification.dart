// ignore_for_file: file_names, unused_shown_name, avoid_print, unused_catch_stack, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:online_panchayat_flutter/Main/initFunctions.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/Data/suppressedUrl.dart';
import 'package:online_panchayat_flutter/services/shareService.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show File, Platform;
import 'package:path_provider/path_provider.dart';

import 'SharedPreferenceService/StoreGlobalData.dart';

class ShowNotification {
  RemoteMessage message;
  String title;
  String body;
  int id;
  String postImageUrl;
  String postId;
  String postShareUrl;
  ShowNotification({@required this.message});

  Future<void> fetchSuppressedUrl() async {
    String suppressedUrl = message.data['suppressedUrl'];
    String suppressedUrlName = message.data['suppressedUrlName'];
    await StoreGlobalData.suppressedUrlStorage.setData(SuppressedUrl(
      name: suppressedUrlName,
      url: suppressedUrl,
      showWebPage: true,
    ));

    // store in shared prferences
  }

  Future<void> generateNotification() async {
    if (message.data.isEmpty) return;

    id = message.data.hashCode.toInt();
    print(message.data);

    // var strings =
    //     notificationTranslations[(await getSavedLocale()).languageCode];

    // if (strings == null) strings = notificationTranslations["en"];
    // body = '${message.data['userName']}' +
    //     strings[message.data['body']].toString() +
    //     '\"${message.data['postContent']}....\"';

    try {
      title = message.data['title'];
      postImageUrl = message.data['imageURL'];
      postId = message.data['postId'];
      postShareUrl = message.data['postShareUrl'];

      if (title == null) {
        throw Exception("Notification Received with title null");
      }

      // Map postData = jsonDecode(message.data['postData']);
      // postData = postData["Item"];

      // postImageUrl = postData["imageURL"];
      // print("post image is " + postImageUrl);
    } catch (e, s) {
      String errorMessage = "Error in backround notification : " + e.toString();
      print(errorMessage);
      // FirebaseCrashlytics.instance.recordError(errorMessage, s);
      return;
    }

    // postImageUrl = await getNotificationImageUrl();
    showNotification();
  }

  showNotification() async {
    Map<String, String> payload = <String, String>{
      "shareMessage": ShareService.getPostShareMessage(
        postContent: title,
        completeUrl: postShareUrl ?? "",
      ).replaceAll('\n', '\\n'),
      "postId": postId,
    };

    payload = payload.map((key, value) {
      key = "\"$key\"";
      value = "\"$value\"";
      return MapEntry(key, value);
    });

    flutterLocalNotificationsPlugin.show(
      id,
      title,
      postImageUrl != null ? await getImagePath() : null,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          playSound: false,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          visibility: NotificationVisibility.public,
          enableVibration: false,
          fullScreenIntent: false,
        ),
      ),
      payload: payload.toString(),
    );
  }

  Future<String> getImagePath() async {
    String attachmentPicturePath =
        await _downloadAndSaveFile(postImageUrl, 'notification_img_$id.jpg');
    return attachmentPicturePath;
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    var response;
    File file;
    try {
      response = await http.get(Uri.parse(url));
      file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
    return filePath;
  }
}
