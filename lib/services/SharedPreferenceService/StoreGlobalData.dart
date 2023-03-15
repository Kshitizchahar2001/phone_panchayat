// ignore_for_file: file_names, avoid_print

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceDataStorage.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/tourDataStorage.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/userDataStorage.dart';
import 'package:online_panchayat_flutter/services/uniLinkService.dart';
import 'Data/suppressedUrl.dart';
import 'sharedPreferenceService.dart';

class StoreGlobalData {
  static Uri deepLink;
  static bool firstOpen;
  static String refereeId;
  static SuppressedUrlStorage suppressedUrlStorage;
  static User user;
  static SharedPreferenceDataStorage guestUserId;

  static intialiseAllData() async {
    await _initialiseSharedPreferences();
    await _fetchPendingDynamicLinkData();
    await UniLinkService.handleInitialUri();
    _setRefreeIdFromLink(deepLink);
    _setRefreeIdFromLink(UniLinkService.initialUri);
    _logData(shouldLogData: false);
  }

  static Future<void> checkAndUpdateRetentionPeriodCompleteness() async {
    String firstUseTime = SharedPreferenceService.fetchFirstUseTime();
    if (firstUseTime == null) return;
    DateTime timeOfFirstUse = DateTime.parse(firstUseTime);
    if (DateTime.now().difference((timeOfFirstUse)).inDays >= 2) {
      await SharedPreferenceService.removeFirstUseTime();
      await Services.gqlMutationService.updateUser
          .updateRetentionPeriodComplete(retentionPeriodComplete: true);
    }
  }

  static Future<void> _initialiseSharedPreferences() async {
    await SharedPreferenceService.getInstance();
    firstOpen = SharedPreferenceService.fetchFirstOpen();
    refereeId = SharedPreferenceService.fetchRefereeId();
    user = UserDataStorage.fetchUser();
    suppressedUrlStorage = SuppressedUrlStorage();
    guestUserId = SharedPreferenceDataStorage(
      keyName: 'guestUserId',
      dataType: DataType.String,
    );
    //
    TourDataStorage.initialise();
  }

  static Future<void> _fetchPendingDynamicLinkData() async {
    PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    deepLink = data?.link;
  }

  static void _setRefreeIdFromLink(Uri link) {
    if (link != null) {
      if (refereeId == null && firstOpen) {
        refereeId = link.queryParameters[invitedByQueryPrameter];
        SharedPreferenceService.setRefereeId(refereeId);
      }
    }
  }

  static _logData({bool shouldLogData = true}) {
    if (!shouldLogData) return;
    print("deeplink : $deepLink");
    print("firstOpen : $firstOpen");
    print("refereeId : $refereeId");
    print("initial uri ${UniLinkService.initialUri}");
  }
}
