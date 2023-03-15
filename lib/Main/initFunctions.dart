// ignore_for_file: avoid_print, file_names, unused_shown_name, prefer_const_constructors, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/showNotification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:io' show File, Platform;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<Locale> getSavedLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.reload();
  var locale = prefs.containsKey("locale") ? prefs.getString("locale") : null;
  return Locale(locale ?? Platform.localeName);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  initialiseNotificationPlugin();
  await initialiseNotificationChannel();

  // await StoreGlobalData.initialiseSharedPreferences();

  // SQLiteStorageService sqLiteStorageService = SQLiteStorageService();

  // ignore: todo
  // await sqLiteStorageService.initializeDatabase(); // TODO : Store locally

  print('Handling a background message 2.0 ${message.messageId}');

  ShowNotification showNotification = ShowNotification(message: message);
  // await showNotification.fetchSuppressedUrl();
  await showNotification.generateNotification();

  // ignore: todo
  // await storeNotificationLocally(message, sqLiteStorageService); //TODO : Store locally
}

initialiseNotificationPlugin() {
  var initializationSettingsAndroid =
      AndroidInitializationSettings(notificationIcon);
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: notificationClicked);
}

Future<dynamic> notificationClicked(String s) {
  print("notification clicked");

  return FirebaseAnalytics.instance.logEvent(name: 'notification_clicked');
}

// Future storeNotificationLocally(
//     RemoteMessage message, SQLiteStorageService sqLiteStorageService) async {
//   message.data.removeWhere((key, value) => key == 'title');
//   message.data.removeWhere((key, value) => key == 'body');
//   await sqLiteStorageService.insertNotification(data: message.data);
// }

Future<void> checkIfAppIsLaunchedFromNotification(BuildContext context) async {
  NotificationAppLaunchDetails notificationAppLaunchDetails;
  try {
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (!notificationAppLaunchDetails.didNotificationLaunchApp) return;
  } catch (e, s) {
    FirebaseCrashlytics.instance.recordError(
      "Error getting app launch details from flutter_local_notification plugin : " +
          e.toString(),
      s,
    );
    return;
  }

  // if application was launched from notification

  await AnalyticsService.firebaseAnalytics
      .logEvent(name: 'app_launched_with_notification');

  try {
    Map<String, dynamic> payloadData =
        jsonDecode(notificationAppLaunchDetails.payload);

    AnalyticsService.firebaseAnalytics.logEvent(
      name: 'notification_open_with_parameters',
      parameters: payloadData,
    );

    if (payloadData['readFullNewsButtonClicked'] == true) {
      pushSinglePost(payloadData, context);
    }
  } catch (e, s) {
    String exception = "Error while parsing app launch data : " + e.toString();
    FirebaseCrashlytics.instance.recordError(exception, s);
  }
}

void pushSinglePost(Map<String, dynamic> payloadData, BuildContext context) {
  String postId = payloadData['postId'];

  context.vxNav.push(
    Uri.parse(
      MyRoutes.singlePostViewNotificationRoute,
    ),
    params: postId,
  );
  FirebaseAnalytics.instance.logEvent(
    name: 'read_full_news_button_click',
    parameters: payloadData,
  );
}

Future<void> initialiseServiceWorkerController() async {
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }
}

Future<void> initialiseNotificationChannel() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

showNotificationlaunchDetails(BuildContext context,
    NotificationAppLaunchDetails notificationAppLaunchDetails) async {
  await Future.delayed(Duration(seconds: 1));
  showDialog(
    context: context,
    builder: (context) {
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            Text(
              "payload: " + notificationAppLaunchDetails.payload.toString(),
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "did launch from notification: " +
                  notificationAppLaunchDetails.didNotificationLaunchApp
                      .toString(),
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      );
    },
  );
}
