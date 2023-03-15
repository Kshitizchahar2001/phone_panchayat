// ignore_for_file: unnecessary_this, prefer_initializing_formals, annotate_overrides

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/place.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';
import 'placeSuggestionData.dart';

class Tehsil extends Place {
  Places state;
  Tehsil({Places district, Places state}) {
    this.parentPlace = district;
    this.state = state;
    this.label = SELECT_TEHSIL;
    this.image = getImage(stateId: state.id, placeType: PlaceType.TEHSIL);
    this.bottomButtonText = TEHSIL_NOT_AVAILABLE.tr();
    this.showBottomButton = true;
  }

  @override
  Future<List<Places>> getItems() async {
    placeList = await Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(
      parentId: parentPlace.id,
      placeType: PlaceType.TEHSIL,
    );

    sortInHindi(placeList);
    return placeList;
  }

  @override
  Future<void> onItemTap(BuildContext context, Places places) async {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "tehsil_selected", parameters: {
      "tehsil_id": places?.id ?? "",
      "tehsil_name_hi": places?.name_hi ?? "",
      "tehsil_name_en": places?.name_en ?? "",
    });
    await proceedForSignup(
      context,
      state: this.state,
      district: this.parentPlace,
      tehsil: places,
    );
  }

  @override
  onAdditionalTehsilSelectItemTap(BuildContext context, Places places) {
    Place.selectedPlaceIds.add(places.id);
  }

  @override
  Future<void> onTapBottomButton(BuildContext context) async {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "tehsil_not_available", parameters: {
      "dist_id": this.parentPlace?.id ?? "",
      "district_name_hi": this.parentPlace?.name_hi ?? "",
      "district_name_en": this.parentPlace?.name_en ?? "",
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
      state: this.state,
      district: this.parentPlace,
      tehsil: this.placeList[0],
    );
  }
}
