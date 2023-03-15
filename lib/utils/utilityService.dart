// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UtilityService {
  static String removeSymbols(String input) {
    return input.replaceAll("+", "");
  }

  static String removeSlashSymbols(String input) {
    return input.replaceAll("/", "");
  }

  static getCurrentLocale(BuildContext context) {
    return context.locale.toString();
  }
}
