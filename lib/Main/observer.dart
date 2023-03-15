// ignore_for_file: unnecessary_string_interpolations, duplicate_ignore, avoid_print

// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:velocity_x/velocity_x.dart';


class MyObs extends VxObserver {
  @override
  void didChangeRoute(Uri route, Page page, String pushOrPop) {
    // print("${page.name}");

    switch (pushOrPop) {
      case "push":
        if (route.path != MyRoutes.initialRoute) {
          AnalyticsService.setCurrentScreenOnPush("${route.path}");
        }
        break;
      case "pop":
        AnalyticsService.setCurrentScreenOnPop();
        break;
      default:
    }
    print("${route.path} - $pushOrPop");
  }

  @override
  void didPush(Route route, Route previousRoute) {
    //  print("${route.settings.name}");
    print('Pushed a route');
  }

  @override
  void didPop(Route route, Route previousRoute) {
    // print("${route.settings.name}");
    print('Popped a route');
  }
}
