// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MatrimonialHelper {
  static void onCallPressed(MatrimonialProfile profile) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "call_to_matrimonial_profile", parameters: {
      "match_id": profile.id ?? "",
      "gotre": profile.gotre ?? "",
      "caller_id": Services.globalDataNotifier.localUser.id,
    });
    launch('tel:${profile.mobileNumber ?? profile.id}');
  }

  static String getStateName(
      {BuildContext context, MatrimonialProfile profile}) {
    if (profile.state_place != null ||
        Services.globalDataNotifier.localUser.state_place != null) {
      String stateName = GetPlaceName.getPlaceName(
          profile.state_place ??
              Services.globalDataNotifier.localUser.state_place,
          context);
      return stateName;
    }
    return null;
  }

  static String getDistrictName(
      {BuildContext context, MatrimonialProfile profile}) {
    if (profile.district_place != null ||
        Services.globalDataNotifier.localUser.district_place != null) {
      String districtPlace = GetPlaceName.getPlaceName(
          profile.district_place ??
              Services.globalDataNotifier.localUser.district_place,
          context);
      return districtPlace;
    }
    return null;
  }

  static String getProfileImage({MatrimonialProfile currentProfile}) {
    if (currentProfile != null && currentProfile.profileImage != null) {
      return currentProfile.profileImage;
    }
    if (currentProfile != null &&
        currentProfile.images != null &&
        currentProfile.images.isNotEmpty) {
      return currentProfile.images[0];
    }
    return DEFAULT_USER_IMAGE_URL;
  }

  static List<String> getImagesList({MatrimonialProfile profile}) {
    List<String> imageList = [];
    if (profile.profileImage != null) {
      imageList.add(profile.profileImage);
    }
    if (profile.images != null && profile.images.isNotEmpty) {
      imageList.addAll(profile.images);
    }

    return imageList;
  }
}
