// ignore_for_file: file_names, duplicate_import, avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/referredUserData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/dynamicLinksService.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class ReferAndEarnData {
  String myReferralLink;
  GlobalDataNotifier globalDataNotifier;
  User user;

  List<ReferredUserData> listOfReferredUsers;

  // int minimumClaimLimit = 10;
  int minimumClaimLimit = 200;

  int total;
  int claimed;
  int balance;
  int onHold;

  ValueNotifier<bool> raisedClaimRequest;

  bool eligibleForClaim = false;

  double percentOfBalanceFromTotal;

  ReferAndEarnData() {
    globalDataNotifier = Services.globalDataNotifier;
    user = globalDataNotifier.localUser;
    total = globalDataNotifier?.localUser?.totalPoints ?? 0;
    claimed = globalDataNotifier?.localUser?.claimedPoints ?? 0;
    balance = globalDataNotifier?.localUser?.balancePoints ?? 0;
    onHold = globalDataNotifier?.localUser?.onHoldPoints ?? 0;
    raisedClaimRequest = ValueNotifier<bool>(
        globalDataNotifier?.localUser?.raisedClaimRequest ?? false);

    percentOfBalanceFromTotal =
        (balance / minimumClaimLimit > 1) ? 1 : balance / minimumClaimLimit;

    listOfReferredUsers = [
      ReferredUserData(
        name: "priyanshu",
        number: "8953446887",
        imageUrl: APP_ICON_URL,
      )
    ];

    eligibleForClaim = percentOfBalanceFromTotal == 1;

    try {
      minimumClaimLimit =
          RemoteConfigService.global_information["minimum_claim_value"] as int;
      print("limit is " + minimumClaimLimit.toString());
    } catch (e, s) {
      String errorMessage =
          "Error getting minimum claim limit in refer and earn data : $e";
      FirebaseCrashlytics.instance.recordError(errorMessage, s);

      // FirebaseCra
      minimumClaimLimit = 200;
    }
  }

  Future<String> getMyReferralLink() async {
    // ignore: todo
    // return "https://stackoverflow.com/questions/55885433/flutter-dart-how-to-add-copy-to-clipboard-on-tap-to-a"; //TODO
    if (myReferralLink != null) return myReferralLink;
    return await generateMyReferralLink();
  }

  Future<String> generateMyReferralLink() async {
    String userId;
    userId = UtilityService.removeSymbols(user.id);

    await DynamicLinkService.generateReferralLink(userId: userId)
        .then((value) => myReferralLink = value.toString());
    return myReferralLink;
  }

  Future<void> onCaimed(BuildContext context) async {
    if (eligibleForClaim) {
      raisedClaimRequest.value =
          await Services.gqlMutationService.updateUser.raiseClaimRequest(
        notifierService: Services.globalDataNotifier,
        messagingService: Services.firebaseMessagingService,
        userId: user.id,
      );
      if (raisedClaimRequest.value) {
        AnalyticsService.firebaseAnalytics
            .logEvent(name: "raise_claim_request", parameters: {
          "benificiary_name": globalDataNotifier.localUser.name,
          "total_points": total,
          "claimed_points": claimed,
          "balance_points": balance,
          "link": myReferralLink,
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(CLAIM_REQUIREMENT_TEXT
              .tr(namedArgs: {"value": minimumClaimLimit.toString()}))));
    }
  }
}
