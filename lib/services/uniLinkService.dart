// ignore_for_file: file_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class UniLinkService {
  static bool _initialUriIsHandled = false;
  static Uri initialUri;
  static Object err;
  static List<MapEntry<String, List<String>>> queryParams;

  static Future<void> handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      print('_handleInitialUri called');
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
        }
        initialUri = uri;
        queryParams = initialUri?.queryParametersAll?.entries?.toList();
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (e, s) {
        //report to firebase
        FirebaseCrashlytics.instance
            .recordError("malformed initial uri : " + e?.toString(), s);
        print('malformed initial uri');
        err = e;
      }
    }
  }
}
