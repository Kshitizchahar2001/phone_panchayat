// ignore_for_file: unnecessary_this, avoid_function_literals_in_foreach_calls, empty_catches, curly_braces_in_flow_control_structures, avoid_print, prefer_const_constructors

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/hindiAlphabets.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceService.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

abstract class Place extends ChangeNotifier {
  String label;
  List<Places> placeList = <Places>[];
  List<Places> matchedKeywordsList = <Places>[];

  static List<String> selectedPlaceIds = <String>[];
  bool loading = false;
  Future<List<Places>> getItems();
  Future<void> signupWithSuggestion(BuildContext context);
  Places parentPlace;

  Future<void> initialisePlaceList() async {
    loading = true;
    matchedKeywordsList = await this.getItems();
    loading = false;
    notifyListeners();
  }

  List<String> get getSelectedPlaceIds {
    return selectedPlaceIds;
  }

  void searchBarTextFieldListener(String keyword) {
    if (placeList != null && keyword.isNotEmpty) {
      matchedKeywordsList = <Places>[];
      keyword.split(" ").forEach((k) {
        placeList.forEach((item) {
          if (k.isNotEmpty &&
              (item.name_en
                  .toString()
                  .toLowerCase()
                  .contains(k.toLowerCase()))) {
            matchedKeywordsList.add(item);
          }
        });
      });
    }
    if (keyword.isEmpty) {
      matchedKeywordsList = placeList;
    }
    notifyListeners();
  }

  onItemTap(BuildContext context, Places places);
  onAdditionalTehsilSelectItemTap(BuildContext context, Places places);
  String bottomButtonText = "";
  onTapBottomButton(BuildContext context);
  bool showBottomButton = false;
  String image = india_image_2;

  sortInHindi(List<Places> placesList) {
    Places temp;

    for (int i = 0; i < placesList.length; i++) {
      for (int j = 0; j < placesList.length - 1; j++) {
        try {
          if (hindiAlphabeticalOrder.indexOf(placesList[j].name_hi[0]) >
              hindiAlphabeticalOrder.indexOf(placesList[j + 1].name_hi[0])) {
            temp = placesList[j];
            placesList[j] = placesList[j + 1];
            placesList[j + 1] = temp;
          }
        } catch (e) {}
      }
    }
  }

  String getImage({@required String stateId, @required PlaceType placeType}) {
    if (stateId == 'state1') {
      if (placeType == PlaceType.DISTRICT) {
        return rajasthan_image_1;
      } else
        return rajasthan_image_2;
    } else if (stateId == 'state2') {
      if (placeType == PlaceType.DISTRICT) {
        return uttar_pradesh_image_1;
      } else
        return uttar_pradesh_image_2;
    } else
      return india_image_2;
  }

  Future<void> proceedForSignup(
    BuildContext context, {
    @required Places state,
    Places district,
    Places tehsil,
  }) async {
    showMaterialDialog(context);
    try {
      Places selectedPlace = tehsil ?? state;
      // print("local user id is::::::::" +
      //     Services.globalDataNotifier.localUser?.id.toString());
      print("local user id is::::::::" +
          Services.globalDataNotifier.localUser?.toJson().toString());

      if (Services.globalDataNotifier.isUserRegistered) {
        Map<String, dynamic> variables = {
          'id': Services.authenticationService.getUserId() ?? "",
          'expectedVersion':
              Services.firebaseMessagingService.userVersion ?? "",
          'tag': selectedPlace?.tag?.id ?? "",
          'area': selectedPlace?.name_hi ?? "",
          'state_id': state?.id ?? ""
        };
        if (district?.id != null) {
          variables.addEntries({
            "district_id": district?.id,
          }.entries);
        }
        // update tag
        await Services.gqlMutationService.updateUser.updateUser(
          variables: variables,
          notifierService: Services.globalDataNotifier,
          messagingService: Services.firebaseMessagingService,
        );
        AnalyticsService.firebaseAnalytics.logEvent(
          name: "user_tag_update",
          parameters: {
            "user_id": Services.authenticationService.getUserId() ?? "",
            "tag": selectedPlace.tag.id ?? "",
          },
        );
      } else {
        await completeSignUp(
          state: state,
          district: district,
          tehsil: tehsil,
        );
      }
      Services.authStatusNotifier.rebuildRoot();
      context.vxNav.popToRoot();
    } catch (e, s) {
      Navigator.pop(context);
      final snackBar =
          SnackBar(content: Text('Error , cannot proceed for this place.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      FirebaseCrashlytics.instance
          .recordError("Error in complete signup method" + e.toString(), s);
    }
  }

  Future<void> completeSignUp({
    @required Places state,
    @required Places district,
    @required Places tehsil,
  }) async {
    Places selectedPlace = tehsil ?? state;
    String deviceToken;
    String referrerId = getReferrerId();
    deviceToken = Services.firebaseMessagingService.getUpToDateDeviceToken;

    await Services.gqlMutationService.createNewUser
        .createNewUser(
      homeAdressLocation: temporarilyHardcodedlocation,
      mobileNumber: Services.authenticationService.getUserId(),
      area: selectedPlace.name_hi,
      pincode: selectedPlace.tag.id,
      tag: selectedPlace.tag.id,
      deviceToken: deviceToken,
      referrerId: referrerId,
      state_id: state?.id?.toString(),
      district_id: district?.id,
    )
        .then((value) {
      AnalyticsService.firebaseAnalytics.logEvent(
        name: "user_creation",
        parameters: {
          "user_id": Services.authenticationService.getUserId() ?? "",
          "tag": selectedPlace.tag.id ?? "",
          "place_id": selectedPlace.id ?? "",
        },
      );

      if (referrerId != null) {
        try {
          AnalyticsService.firebaseAnalytics
              .logEvent(name: "user_creation_with_referral_id", parameters: {
            "referrer_id": referrerId ?? "",
            "user_id": Services.authenticationService.getUserId() ?? "",
          });
        } catch (e) {}
        SharedPreferenceService.setFirstUseTime();
      }
    });
  }

  String getReferrerId() {
    if (StoreGlobalData.refereeId != null) {
      return "+" + StoreGlobalData.refereeId;
    }
    return null;
  }
}
