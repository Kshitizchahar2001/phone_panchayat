// ignore_for_file: file_names, deprecated_member_use, non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print, unnecessary_new

import 'dart:convert';
import 'dart:io';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/appUpdateStatus.dart';
import 'package:online_panchayat_flutter/screens/widgets/EnterAadhaarDialog/aadhaarRules.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:package_info/package_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static String playStoreLink;
  static String appStoreLink;
  static PackageInfo info;
  static double currentVersion;
  static RemoteConfig remoteConfig;
  static Map<String, dynamic> topSnackBarConfig = {"showSnackBar": false};
  static Map<String, dynamic> contact_information = {
    "phone_number": "+918744886627",
    "whatsapp_number": "+918410009538",
    "email": "online.panchayatggc@gmail.com"
  };
  static int multipleTehsilPrice;

  static Map<String, dynamic> matrimonialPriceConfig;

  static Map<String, dynamic> global_information = {
    "views_multiplication_factor": 3,
    "moderatorsList": ["+918953446887", "+918949982614", "+918744886627"],
    "minimum_claim_value": 200
  };

  static Future<void> fetchAllRemoteConfigValues() async {
    //Get Current installed version of app

    //Get Latest version info from firebase config

    try {
      info = await PackageInfo.fromPlatform();
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError("Error getting package info : $e", s);
    }

    currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    remoteConfig = RemoteConfig.instance;
    // await remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    await remoteConfig.setDefaults({
      "android_config": {
        'play_store_link': "android",
        "latest_version": "1.32",
        "min_version": "1.00"
      },
      "ios_config": {
        'app_store_link': "ios",
        "latest_version": "1.32",
        "min_version": "1.00"
      },
      "contact_information": contact_information,
      "global_information": global_information,
    }).onError((error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(
          "Error while setting remote config defaults : $error", stackTrace);
    });

    try {
      await remoteConfig.fetch();
      await remoteConfig.activate();
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(
          'Unable to fetch remote config. Cached or default values will be '
          'used : $e',
          s);
    }

    Map<String, dynamic> aadhaarCardRequirements = json
        .decode(remoteConfig.getValue('aadhaar_card_requirements').asString());
    AadhaarRules.setRules(aadhaarCardRequirements: aadhaarCardRequirements);

    contact_information =
        json.decode(remoteConfig.getValue('contact_information').asString());
    global_information =
        json.decode(remoteConfig.getValue('global_information').asString());

    topSnackBarConfig = json.decode(
        remoteConfig.getValue('top_permanent_snack_bar_config').asString());

    multipleTehsilPrice = int.tryParse(json
        .decode(remoteConfig.getValue('multiple_tehsil_price').asString())
        .toString());

    matrimonialPriceConfig = json
        .decode(remoteConfig.getValue('matrimonial_price_config').asString());

    AadhaarRules.setRules(aadhaarCardRequirements: aadhaarCardRequirements);
  }

  static AppUpdateStatus versionCheck() {
    try {
      // Using default duration to force fetching from remote server.
      if (Platform.isAndroid) {
        Map<String, dynamic> data =
            json.decode(remoteConfig.getValue('android_config').asString());
        playStoreLink = data['play_store_link'];
        double newVersion = double.parse(
            data['latest_version'].toString().trim().replaceAll(".", ""));
        double minVersion = double.parse(
            data['min_version'].toString().trim().replaceAll(".", ""));
        if (currentVersion < minVersion) {
          // _showForceUpdateVersionDialog(context);
          return AppUpdateStatus.ForceUpdateRequired;
        } else if (currentVersion < newVersion) {
          // _showVersionDialog(context);
          return AppUpdateStatus.OptionalUpdateAvailable;
        } else
          return AppUpdateStatus.UpdateNotNeeded;
      } else
        return AppUpdateStatus.UnsupportedPlatform;
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
      print(exception);
      return AppUpdateStatus.UpdateNotNeeded;
    }
  }

  static void showForceUpdateVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = MANDATORY_UPDATE_DIALOG_TITLE_TEXT;
        String message = MANDATORY_UPDATE_DIALOG_BODY_TEXT;
        String btnLabel = UPDATE_NOW;

        return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(
                context.safePercentWidth * 5,
              ))),
              title: Text(title).tr(),
              content: Text(
                message,
                style: Theme.of(context).textTheme.headline3.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.s)),
              ).tr(),
              actions: <Widget>[
                DialogBoxButton(
                  text: btnLabel,
                  onPressed: () {
                    Services.appUpdateService.performImmediateUpdate();
                  },
                )
              ],
            ));
      },
    );
  }
}
