// ignore_for_file: file_names, constant_identifier_names

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferences sharedPreferences;
  static const FIRST_USE_TIME = "firstUseTime";

  static getInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool fetchFirstOpen() {
    bool firstOpen = (sharedPreferences.getBool('firstOpen') ?? true);
    if (firstOpen) {
      sharedPreferences.setBool('firstOpen', false);
    }
    return firstOpen;
  }

  static String fetchRefereeId() {
    String refereeId;
    try {
      refereeId = sharedPreferences.getString('refereeId');
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return refereeId;
  }

  static Future<void> setRefereeId(String refereeId) async {
    try {
      await sharedPreferences.setString('refereeId', refereeId);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  static Future<void> removeRefereeId() async {
    await sharedPreferences.remove("refereeId");
  }

  static Future<void> setFirstUseTime() async {
    await sharedPreferences.setString(
        FIRST_USE_TIME, DateTime.now().toString());
  }

  static String fetchFirstUseTime() {
    return sharedPreferences.getString(FIRST_USE_TIME);
  }

  static Future<void> removeFirstUseTime() async {
    await sharedPreferences.remove(FIRST_USE_TIME);
  }

  static Future<void> setAdditionalTehsilSubscriptionId(
      String subscriptionId) async {
    try {
      await sharedPreferences.setString("subscriptionId", subscriptionId);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  static String fetchAdditionalTehsilSubscriptionId() {
    return sharedPreferences.getString("subscriptionId");
  }

  static Future<void> removeAdditionalTehsilSubscriptionId() async {
    await sharedPreferences.remove("subscriptionId");
  }
}
