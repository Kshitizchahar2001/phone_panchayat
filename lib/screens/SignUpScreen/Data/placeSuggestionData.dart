// ignore_for_file: file_names, unnecessary_this, avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/place.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';

class PlaceSuggestionData {
  Place place;
  String district;
  String tehsil;
  PlaceSuggestionData({@required this.place});

  Future<void> sendSuggestion() async {
    await AnalyticsService.firebaseAnalytics
        .logEvent(name: "place_suggestion", parameters: {
      "district_name": this.district ?? "",
      "tehsil_name": this.tehsil ?? "",
    });
    print(
        "suggestion sent for ${this.district.toString()} and ${this.tehsil.toString()}");
  }
}
