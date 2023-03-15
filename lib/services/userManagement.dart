// ignore_for_file: file_names, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/individualProfessionalListScreenData.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/addPostScreenData.dart';
import 'package:online_panchayat_flutter/screens/loading_splash_screen.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/appUpdateService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/gqlQueryService.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/utils/DesignatedUserDataNotifier.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authStatusNotifier.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:online_panchayat_flutter/utils/theme.dart';
import 'package:provider/provider.dart';

class UserManagement extends StatefulWidget {
  final Widget Function(BuildContext, bool, bool) builder;

  const UserManagement({Key key, this.builder}) : super(key: key);

  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  @override
  void initState() {
    Services.authStatusNotifier =
        Provider.of<AuthStatusNotifier>(context, listen: false);

    Services.gqlQueryService =
        Provider.of<GQLQueryService>(context, listen: false);

    Services.gqlMutationService =
        Provider.of<GQLMutationService>(context, listen: false);
    Services.globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    Services.globalDataNotifier.gqlQueryService = Services.gqlQueryService;
    Services.authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    Services.locationNotifier =
        Provider.of<LocationNotifier>(context, listen: false);
    Services.firebaseMessagingService =
        Provider.of<FirebaseMessagingService>(context, listen: false);
    Services.designatedUserDataNotifier =
        Provider.of<DesignatedUserDataNotifier>(context, listen: false);
    Services.appUpdateService =
        Provider.of<AppUpdateService>(context, listen: false);

    AddPostScreenData.globalDataNotifier = Services.globalDataNotifier;
    IndividualProfessionalListScreenData.globalDataNotifier =
        Services.globalDataNotifier;
    IndividualProfessionalListScreenData.locationNotifier =
        Services.locationNotifier;
    Services.analyticsService = AnalyticsService();

    Services.analyticsService.startSession().then((value) {
      Services.analyticsService.registerAppLaunchEvent();
    });

    super.initState();
  }

  @override
  void dispose() {
    Services.analyticsService.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _globalDataNotifier.setService(gqlQueryService: _gqlQueryService);
    return Consumer<AuthStatusNotifier>(
      builder: (context, value, child) {
        if (value.isUserSignedIn == true) {
          if (StoreGlobalData.user != null) {
            value.userDataAvailable();
            return widget.builder(context, value.isUserSignedIn, true);
          } else
            return FutureBuilder<bool>(
              future: value.userDataAvailable(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done)
                  return widget.builder(
                      context, value.isUserSignedIn, snapshot.data);
                else
                  return putWidgetInsideMaterialApp(LoadingSplashScreen());
              },
            );
        } else {
          return widget.builder(context, false, false);
        }
      },
    );
  }

  Widget putWidgetInsideMaterialApp(Widget widget) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        themeMode: themeProvider.getThemeMode,
        theme: themeProvider.light,
        darkTheme: themeProvider.dark,
        debugShowCheckedModeBanner: false,
        home: widget,
      );
    });
  }
}
