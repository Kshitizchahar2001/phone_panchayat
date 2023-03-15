// ignore_for_file: file_names

import 'package:online_panchayat_flutter/models/User.dart';

class AadhaarRules {
  static bool isAadhaarNumberMandatory;
  static bool isAadhaarImageMandatory;
  static bool isUserVerificationMandatory;

  AadhaarRules() {
    //default rules
    isAadhaarNumberMandatory = true;
    isAadhaarImageMandatory = false;
    isUserVerificationMandatory = false;
  }

  static setRules({Map<String, dynamic> aadhaarCardRequirements}) {
    isAadhaarNumberMandatory =
        aadhaarCardRequirements["isAadhaarNumberMandatory"];
    isAadhaarImageMandatory =
        aadhaarCardRequirements["isAadhaarImageMandatory"];
    isUserVerificationMandatory =
        aadhaarCardRequirements["isUserVerificationMandatory"];
  }

  static int initialPage = 0; //initial page of enter aadhaar dialog

  //0 : take aadhaar number input
  //1 : take aadhaar card image as input
  //2 : show verification status

  static bool isUserAllowedToPost(User user) {
    if ((user.aadharNumber == "" || user.aadharNumber == null) &&
        isAadhaarNumberMandatory) {
      initialPage = 0;
      return false;
    }
    if (user.aadhaarImageUrl == null && isAadhaarImageMandatory) {
      initialPage = 1;
      return false;
    }
    if (!(user.isUserVerified ?? false) && isUserVerificationMandatory) {
      initialPage = 2;
      return false;
    }
    return true;
  }
}
