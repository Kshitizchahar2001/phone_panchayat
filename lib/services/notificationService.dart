// ignore_for_file: unused_import, file_names, prefer_final_fields, avoid_print

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:online_panchayat_flutter/Main/initFunctions.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/models/notificationModel.dart';
import 'package:online_panchayat_flutter/services/SQLiteStorageService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/updateUserDeviceTokenMutation.dart';
import 'package:online_panchayat_flutter/services/showNotification.dart';

class FirebaseMessagingService extends ChangeNotifier {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // static SQLiteStorageService sqLiteStorageService;
  List<NotificationModel> _notifications = <NotificationModel>[];
  List<NotificationModel> _unreadNotifications = <NotificationModel>[];
  User _currentRegisteredUser;
  int _userVersion;
  String _deviceLatestToken;

  List<NotificationModel> get notificationList => _notifications;
  List<NotificationModel> get unreadNotificationList => _unreadNotifications;

  // markAllNotificationsSeenForRespectivePost({String postId}) async {
  //   await sqLiteStorageService.markNotificationsasRead(postId: postId);
  //   updateNotificationListOnLaunch();
  // }

  get userVersion => _userVersion;

  set setCurrentRegisteredUser(User user) {
    _currentRegisteredUser = user;
  }

  set setUserVersion(int versionNumber) {
    _userVersion = versionNumber;
    print('userVersion************* $_userVersion');
  }

  FirebaseMessagingService() {
    // updateNotificationListOnLaunch();
    initialiseDeviceToken();
    askForMessagingPermission();
    _setForegroundNotificationCallback();
  }

  initialiseDeviceToken() async {
    try {
      _deviceLatestToken = await FirebaseMessaging.instance.getToken();
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError("Error while getting device token" + e.toString(), s);
    }
  }

  askForMessagingPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // updateNotificationListOnLaunch() async {
  //   _unreadNotifications.clear();
  //   _notifications = await sqLiteStorageService.getNotifications();
  //   _notifications.forEach((element) {
  //     if (element.readStatus == 0) {
  //       _unreadNotifications.add(element);
  //     }
  //   });
  //   notifyListeners();
  // }

  String get getUpToDateDeviceToken => _deviceLatestToken;

  runMutationForTokenUpdate() async {
    if (_currentRegisteredUser != null && _userVersion != null) {
      if (_deviceLatestToken == null) {
        await initialiseDeviceToken();
      }

      if (_deviceLatestToken == null) {
        FirebaseCrashlytics.instance
            .log("Device token for this device cannot be fetched");
      }

      UpdateUserDeviceToken().updateToken(
          userId: _currentRegisteredUser.id,
          deviceToken: _deviceLatestToken,
          expectedVersion: _userVersion,
          messagingService: this);
    }
  }

  _setForegroundNotificationCallback() {
    initialiseNotificationPlugin();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // _unreadNotifications.clear();
      ShowNotification showNotification = ShowNotification(message: message);
      // await showNotification.fetchSuppressedUrl();
      await showNotification.generateNotification();

      // if (message.data != null) {
      //   await storeNotificationLocallyAndRefreshUpdateListeners(message);
      // }
      // ignore: todo
      //TODO : store locally
    });
  }

  // Future storeNotificationLocallyAndRefreshUpdateListeners(
  //     RemoteMessage message) async {
  //   message.data.removeWhere((key, value) => key == 'title');
  //   message.data.removeWhere((key, value) => key == 'body');
  //   await sqLiteStorageService.insertNotification(data: message.data);
  //   _notifications = await sqLiteStorageService.getNotifications();
  //   _notifications.forEach((element) {
  //     if (element.readStatus == 0) {
  //       _unreadNotifications.add(element);
  //     }
  //   });
  //   notifyListeners();
  // }
}
