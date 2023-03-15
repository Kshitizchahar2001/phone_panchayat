// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/images.dart';

class DrawerItemModel {
  DrawerItemModel({
    this.label = "",
    this.leadingImage,
    this.route,
    this.trailingImage = path,
    this.params,
    this.leadingIconData,
    this.onPressed,
  });
  String label;
  String route;
  String leadingImage;
  String trailingImage;
  dynamic params;
  IconData leadingIconData;
  Function onPressed;
}
