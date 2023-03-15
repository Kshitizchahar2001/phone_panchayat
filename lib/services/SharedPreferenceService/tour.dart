// ignore_for_file: prefer_const_constructors, unnecessary_this, curly_braces_in_flow_control_structures, avoid_print

import 'dart:async';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'sharedPreferenceService.dart';

class Tour {
  String id;
  String title;
  String description;
  GlobalKey key;
  bool isTourComplete = true;
  bool isWidgetVisible = true;
  Duration delayDuration = Duration(seconds: 0);

  Tour({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.key,
    this.delayDuration,
  });

  clearData() {
    SharedPreferenceService.sharedPreferences.remove(this.id);
  }

  getData() {
    try {
      isTourComplete =
          SharedPreferenceService.sharedPreferences.getBool(this.id);
      isTourComplete = isTourComplete ?? false;
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError("Error reading tour data for id ${this.id} : " + e, s);
      isTourComplete = true;
    }
    // isTourComplete = false;
  }

  markTourComplete() async {
    if (isTourComplete == true) return;
    isTourComplete = true;
    try {
      await SharedPreferenceService.sharedPreferences.setBool(this.id, true);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  showTour(BuildContext context) {
    if (isTourComplete) return;
    Timer(delayDuration, () {
      if (isTourComplete) return;
      if (isWidgetVisible)
        FeatureDiscovery.discoverFeatures(
          context,
          <String>{
            id,
          },
        );
      else {
        print("tour widget not visible");
      }
    });
  }

  onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.9) {
      isWidgetVisible = true;
    } else {
      isWidgetVisible = false;
    }
  }
}
