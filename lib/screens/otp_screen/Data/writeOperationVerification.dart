// ignore_for_file: unused_import, file_names, unnecessary_this

import 'package:online_panchayat_flutter/services/SharedPreferenceService/Data/keyConstants.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/services.dart';

import 'otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class WriteOperationVerification extends OtpVerificationData {
  WriteOperationVerification(String phoneNo) : super(phoneNo: phoneNo);

  @override
  void verifyOtp({@required String otp, @required BuildContext context}) async {
    bool isOtpVerified;
    String _guestUserId = StoreGlobalData.guestUserId.get();
    showMaterialDialog(context);
    isOtpVerified =
        await authenticationService.cognitoVerify(this.cognitoUser, otp);
    if (isOtpVerified) {
      Navigator.of(context).pop();
      context.vxNav.popToRoot();
      await StoreGlobalData.guestUserId.remove();

      if (_guestUserId == this.phoneNo) {
        const snackBar = SnackBar(
          content: Text('फ़ोन नंबर सत्यापित किया गया'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Services.authStatusNotifier.rebuildRoot();
      }
    } else {
      Navigator.of(context).pop();
      context.vxNav.popToRoot();

      const snackBar = SnackBar(
        content: Text('गलत ओटीपी , कृपया दोबारा प्रयास करें'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
