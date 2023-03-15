// ignore_for_file: file_names, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'dart:io';


import 'package:image_cropper/image_cropper.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';

class RegistrationScreenUtilities {
  static String locationFieldValidator(var address) {
    if (address == null ||
        address.addressLine == null ||
        address.addressLine == '') return PLEASE_SELECT_ADDRESS.tr();
    return null;
  }

  /// Method for checking valid  mobile number(length - 10, should be int)
  static String mobileNumberCheckValidator(String number) {
    if (number == null || number.isEmpty) return "Required Field";

    final digitOnly = int.tryParse(number);
    if (digitOnly == null || number.length != 10) return "Invalid Input";
    return null;
  }

  /// Method for removing +91 from mobile numbers
  /// used where we auto fill text fields and have prefix country code
  static String getNumberWithoutCountryCode(String number) {
    if (number == null) return null;
    if (number.contains("+91")) return number.split("+91").last;
    return int.parse(number).toString();
  }

  /// Method for checking user have selected atleast one value in multiple select
  /// used in register professional and edit professional multi_select work speciality
  static String listValidator(List values) {
    if (values == null || values.isEmpty) return "Select at least one element";
    return null;
  }

  /// Method for checking if user selected value from dropdown
  /// used in register professional and edit professional dropdowns
  static String dropDownValidator(dynamic value) {
    if (value == null) return THIS_FIELD_IS_MANDATORY.tr();
    return null;
  }

  static String emptyStringCheckValidator(String input) {
    if (input == '' || input == null) return THIS_FIELD_IS_MANDATORY.tr();
    return null;
  }

  static String getTextFromDateOfBirth(DateTime dateTime) {
    if (dateTime == null)
      return null;
    else {
      return "${dateTime.day} / ${dateTime.month} / ${dateTime.year}";
    }
  }

  static Future<File> getCroppedImage(String imagePath,
      {int maxHeight = 200,
      int maxWidth = 200,
      int compressQuality = 80}) async {
    CroppedFile croppedImage = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: compressQuality,
        maxHeight: maxHeight,
        maxWidth: maxWidth);
    return croppedImage as File;
  }
}
