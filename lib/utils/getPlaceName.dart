// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class GetPlaceName {
  static String getPlaceName(Places places, BuildContext context) {
    bool isUserLocaleHindi = UtilityService.getCurrentLocale(context) == "hi";
    String title = isUserLocaleHindi
        ? (places.name_hi != null && places.name_hi != ""
            ? places.name_hi
            : places.name_en)
        : (places.name_en != null && places.name_en != ""
            ? places.name_en
            : places.name_hi);
    title = title ?? "";
    return title;
  }
}
