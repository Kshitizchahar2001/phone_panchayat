// ignore_for_file: file_names, constant_identifier_names

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceService.dart';


enum DataType {
  BOOL,
  String,
}

class SharedPreferenceDataStorage {
  String keyName;
  DataType dataType;
  SharedPreferenceDataStorage({
    @required this.keyName,
    @required this.dataType,
  });

  dynamic get() {
    dynamic value;
    try {
      switch (dataType) {
        case DataType.BOOL:
          value = SharedPreferenceService.sharedPreferences.getBool(keyName);
          break;
        case DataType.String:
          value = SharedPreferenceService.sharedPreferences.getString(keyName);
          break;
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return value;
  }

  Future<void> set(dynamic value) async {
    try {
      switch (dataType) {
        case DataType.BOOL:
          value = SharedPreferenceService.sharedPreferences.setBool(
            keyName,
            value as bool,
          );
          break;
        case DataType.String:
          value = SharedPreferenceService.sharedPreferences.setString(
            keyName,
            value as String,
          );
          break;
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  Future<void> remove() async {
    await SharedPreferenceService.sharedPreferences.remove(keyName);
  }
}
