// ignore_for_file: file_names, empty_catches, avoid_print

import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:online_panchayat_flutter/Main/initFunctions.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/appUpdateService.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:online_panchayat_flutter/services/trackLatencies.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:online_panchayat_flutter/amplifyconfiguration.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';

Future<void> initialisePreRunData() async {
  AppUpdateService appUpdateService = AppUpdateService();

  TrackLatencies.dateTime1 = DateTime.now();

  TrackLatencies.dateTime2 = DateTime.now();

  await StoreGlobalData.intialiseAllData();
  TrackLatencies.dateTime3 = DateTime.now();

  AuthStatusNotifier authStatusNotifier = AuthStatusNotifier();
  AuthenticationService authenticationService =
      AuthenticationService(authStatusNotifier: authStatusNotifier);
  await authenticationService.initialiseAuthenticationService(
    throwException: true,
  );
  TrackLatencies.dateTime4 = DateTime.now();

  await EasyLocalization.ensureInitialized();
  TrackLatencies.dateTime5 = DateTime.now();

  AnalyticsService.setFirebaseAnalytics = FirebaseAnalytics.instance;

  try {
    TrackLatencies.reportLatenciesToFirebase();
  } catch (e) {}

  RunQuery.authenticationService = authenticationService;

  Services.authStatusNotifier = authStatusNotifier;
  Services.authenticationService = authenticationService;
  Services.appUpdateService = appUpdateService;

  initialisePostRunData(authenticationService)
      .then((value) => appUpdateService.checkForUpdate());
}

Future<void> initialisePostRunData(
    AuthenticationService authenticationService) async {
  AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

  try {
    Amplify.addPlugins([authPlugin, AmplifyStorageS3()]);
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    print(
        "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  }

  await RemoteConfigService.fetchAllRemoteConfigValues();
  initialiseNotificationPlugin();
  await initialiseServiceWorkerController();
  await initialiseNotificationChannel();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}
