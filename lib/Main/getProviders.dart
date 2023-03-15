// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/community_screen/CommunityScreenData.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/find_professionals_data.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceService.dart';
import 'package:online_panchayat_flutter/services/appUpdateService.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:online_panchayat_flutter/services/connectivityService.dart';
import 'package:online_panchayat_flutter/services/firestoreService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/gqlQueryService.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/DesignatedUserDataNotifier.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  return <SingleChildWidget>[
    Provider<AuthenticationService>.value(
      value: Services.authenticationService,
    ),
    ChangeNotifierProvider<DesignatedUserDataNotifier>(
      create: (_) => DesignatedUserDataNotifier(),
    ),
    Provider<GQLMutationService>(
      create: (_) => GQLMutationService(),
    ),
    Provider<GQLQueryService>(
      create: (_) => GQLQueryService(),
    ),
    Provider<FirestoreService>(
      create: (_) => FirestoreService(),
    ),
    ChangeNotifierProvider<FirebaseMessagingService>(
      create: (BuildContext context) => FirebaseMessagingService(),
      lazy: false,
    ),
    ChangeNotifierProvider<AuthStatusNotifier>.value(
      value: Services.authStatusNotifier,
    ),
    ChangeNotifierProvider<GlobalDataNotifier>(
        create: (BuildContext context) => GlobalDataNotifier()),
    ChangeNotifierProvider<ThemeProvider>(
        create: (BuildContext context) => ThemeProvider(
            SharedPreferenceService.sharedPreferences.getBool("darkTheme") ??
                ThemeMode.system == ThemeMode.dark)),
    ChangeNotifierProvider<LocationNotifier>(
      create: (BuildContext context) => LocationNotifier(),
      // lazy: false,
    ),
    ChangeNotifierProvider<ConnectivityService>(
      create: (BuildContext context) => ConnectivityService(),
    ),
    ChangeNotifierProvider<CommunityScreenData>(
      create: (BuildContext context) => CommunityScreenData(),
    ),
    ChangeNotifierProvider<AppUpdateService>.value(
      value: Services.appUpdateService,
    ),
    ChangeNotifierProvider<FindProfessionalsData>(
        create: (BuildContext context) => FindProfessionalsData()),

    //// Removing Matrimonial Query
    ///
    // ChangeNotifierProvider<CurrentMatrimonailProfileData>(
    //     create: (BuildContext context) => CurrentMatrimonailProfileData()),
  ];
}
