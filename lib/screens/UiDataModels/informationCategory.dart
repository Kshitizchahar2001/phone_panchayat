// ignore_for_file: file_names

import 'package:online_panchayat_flutter/enum/infoCategory.dart';

class InformationCategoryDataModel {
  final String title; //railway , bus, jobs
  final String titleIcon;
  final InfoCategory infoCategory;
  InformationCategoryDataModel({
    this.title,
    this.titleIcon,
    this.infoCategory,
  });
}
