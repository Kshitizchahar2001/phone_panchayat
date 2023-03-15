// ignore_for_file: file_names

import 'analyticsService.dart';

class TrackLatencies {
  static DateTime dateTime1;
  static DateTime dateTime2;
  static DateTime dateTime3;
  static DateTime dateTime4;
  static DateTime dateTime5;

  static reportLatenciesToFirebase() {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "app_initalisation_latency", parameters: {
      "fire_init": dateTime2.difference(dateTime1).inMicroseconds,
      "shared_preferences_intialisation":
          dateTime3.difference(dateTime2).inMicroseconds,
      "authentication_service_intialisation":
          dateTime4.difference(dateTime3).inMicroseconds,
      "localisation_plugin_initialisation":
          dateTime5.difference(dateTime4).inMicroseconds,
    });
  }
}
