// ignore_for_file: unnecessary_this, annotate_overrides

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/placeSuggestionData.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/tehsil.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'place.dart';
import 'package:easy_localization/easy_localization.dart';

class District extends Place {
  District({Places state}) {
    this.parentPlace = state;
    this.image =
        getImage(stateId: parentPlace.id, placeType: PlaceType.DISTRICT);
    this.label = SELECT_DISTRICT;
    this.bottomButtonText = DISTRICT_NOT_AVAILABLE.tr();
    this.showBottomButton = false;
  }

  @override
  Future<List<Places>> getItems() async {
    placeList = await Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(
      parentId: parentPlace.id,
      placeType: PlaceType.DISTRICT,
    );

    sortInHindi(placeList);
    return placeList;
  }

  @override
  onAdditionalTehsilSelectItemTap(BuildContext context, Places places) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "additional_tehsil_district_selected", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "district_id": places?.id ?? "",
      "district_name_hi": places?.name_hi ?? "",
      "district_name_en": places?.name_en ?? "",
    });
    context.vxNav.push(Uri.parse(MyRoutes.selectAdditionalTehsil),
        params: Tehsil(district: places, state: this.parentPlace));
  }

  @override
  onItemTap(BuildContext context, Places places) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "district_selected", parameters: {
      "district_id": places?.id ?? "",
      "district_name_hi": places?.name_hi ?? "",
      "district_name_en": places?.name_en ?? "",
    });
    context.vxNav.push(
      Uri.parse(
        MyRoutes.placeList,
      ),
      params: Tehsil(
        district: places,
        state: this.parentPlace,
      ),
    );
  }

  @override
  Future<void> onTapBottomButton(BuildContext context) async {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "district_not_available", parameters: {
      "state_id": this.parentPlace?.id ?? "",
      "state_name_hi": this.parentPlace?.name_hi ?? "",
      "state_name_en": this.parentPlace?.name_en ?? "",
    });
    context.vxNav.push(
      Uri.parse(
        MyRoutes.placeSuggestionScreen,
      ),
      params: PlaceSuggestionData(
        place: this,
      ),
    );
  }

  Future<void> signupWithSuggestion(BuildContext context) async {
    await proceedForSignup(
      context,
      state: this.parentPlace,
    );
  }
}
