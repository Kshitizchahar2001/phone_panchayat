// ignore_for_file: prefer_const_constructors, unnecessary_new, deprecated_member_use, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/getProviders.dart';
import 'package:online_panchayat_flutter/Main/myApp.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:provider/provider.dart';
import 'Main/initialiseAppRunData.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:wakelock/wakelock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  await Firebase.initializeApp();

  runZonedGuarded(
    () {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      runApp(AppRoot());
    },
    FirebaseCrashlytics.instance.recordError,
  );
}

class AppRoot extends StatefulWidget {
  const AppRoot({
    Key key,
  }) : super(key: key);

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialisePreRunData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      height: 100,
                      image: AssetImage(app_icon),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(maroonColor),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.exclamationCircle,
                              size: 100, color: Colors.grey[400]),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              "कृपया सुनिश्चित करें कि आप इंटरनेट से जुड़े हैं और फिर पुनः प्रयास करें",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: CustomButton(
                        text: "पुन: प्रयास करें",
                        boxShadow: [],
                        autoSize: true,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else
          return EasyLocalization(
            startLocale: Locale('hi'),
            supportedLocales: [Locale('en', 'US'), Locale('hi')],

            ///  change the path of the translation files
            path: 'assets/translations',

            fallbackLocale: Locale('en', 'US'),

            child: MultiProvider(
              providers: getProviders(),
              child: FeatureDiscovery.withProvider(
                persistenceProvider: NoPersistenceProvider(),
                child: MyApp(),
              ),
            ),
          );
      },
    );
  }
}
