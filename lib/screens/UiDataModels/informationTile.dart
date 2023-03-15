// ignore_for_file: file_names

import 'package:online_panchayat_flutter/constants/images.dart';

class InformationTileModel {
  InformationTileModel({
    this.label = "",
    this.leadingImage,
    this.route,
    this.trailingImage = path,
    this.params,
  });
  String label;
  String route;
  String leadingImage;
  String trailingImage;
  dynamic params;
}
