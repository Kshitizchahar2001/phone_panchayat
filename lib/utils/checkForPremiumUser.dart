// ignore_for_file: file_names, curly_braces_in_flow_control_structures, avoid_print, await_only_futures

import 'package:online_panchayat_flutter/enum/subscriptionType.dart';
import 'package:online_panchayat_flutter/enum/subscription_plan.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/models/UserSubscription.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createUserSubscription.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class CheckForPremiumUser {
  static bool isUserHaveSubscription(User currentUser) {
    if (currentUser.subscription != null &&
        currentUser.subscription.isNotEmpty) {
      for (int i = 0; i < currentUser.subscription.length; i++) {
        if (currentUser.subscription[i].status == Status.ACTIVE) {
          return true;
        }
      }
    }
    return false;
  }

  static bool isPremiumUser(User currentUser) {
    if (currentUser.subscriptionPlan != null ||
        (currentUser.subscriptionPlanList != null &&
            currentUser.subscriptionPlanList.isNotEmpty) ||
        isUserHaveSubscription(currentUser)) return true;

    return false;
  }

  static bool checkForAdditionalTehsilPlan(User currentUser) {
    if (currentUser.subscriptionPlan == SubscriptionPlan.MULTIPLE_TEHSIL)
      return true;

    if (currentUser.subscription != null &&
        currentUser.subscription.isNotEmpty) {
      for (int i = 0; i < currentUser.subscription.length; i++) {
        if (currentUser.subscription[i].subscriptionPlan ==
                SubscriptionPlan.MULTIPLE_TEHSIL &&
            currentUser.subscription[i].status == Status.ACTIVE) {
          return true;
        }
      }
    }
    return false;
  }

  static void additionalTehsilSubscriptionFailure(User currentUser) async {
    print("Current User is");
    print(currentUser.id);
    String localSubId =
        await SharedPreferenceService.fetchAdditionalTehsilSubscriptionId();
    print(localSubId);
    if (localSubId == null) return;

    if (currentUser.subscription != null &&
        currentUser.subscription.isNotEmpty) {
      for (int i = 0; i < currentUser.subscription.length; i++) {
        if (currentUser.subscription[i].subscriptionId == localSubId) {
          await SharedPreferenceService.removeAdditionalTehsilSubscriptionId();
          return;
        }
      }
    }

    //// If there is a failure
    UserSubscription result = await CreateUserSubscription()
        .createUserSubscription(
            userId: currentUser.id,
            subscriptionPlan: SubscriptionPlan.MULTIPLE_TEHSIL,
            planType: SubscriptionType.RECURRING,
            status: Status.ACTIVE,
            subscriptionId: localSubId);

    print(result.planType);
    if (result != null) {
      await SharedPreferenceService.removeAdditionalTehsilSubscriptionId();

      await Services.gqlQueryService.getUserById.getUserById(
          notifierService: Services.globalDataNotifier,
          messagingService: Services.firebaseMessagingService,
          usernameOfLoggedInUser: currentUser.id);

      return;
    }
  }
}
