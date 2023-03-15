// ignore_for_file: file_names

import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCognitoStorage extends CognitoStorage {
  final SharedPreferences _prefs;
  MyCognitoStorage(this._prefs);

  @override
  Future getItem(String key) async {
    String item;
    try {
      item = json.decode(_prefs.getString(key));
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(
        e,
        s,
      );

      return null;
    }
    return item;
  }

  @override
  Future setItem(String key, value) async {
    await _prefs.setString(key, json.encode(value));
    return getItem(key);
  }

  @override
  Future removeItem(String key) async {
    final item = getItem(key);
    if (item != null) {
      await _prefs.remove(key);
      return item;
    }
    return null;
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
}
