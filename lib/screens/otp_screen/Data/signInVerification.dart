// ignore_for_file: file_names, unnecessary_this

import 'otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class SignInVerification extends OtpVerificationData {
  SignInVerification(String phoneNo) : super(phoneNo: phoneNo);

  @override
  void verifyOtp({@required String otp, @required BuildContext context}) async {
    bool isOtpVerified;
    showMaterialDialog(context);
    isOtpVerified =
        await authenticationService.cognitoVerify(this.cognitoUser, otp);
    if (isOtpVerified) {
      Navigator.of(context).pop();
      context.vxNav.popToRoot();

      Services.authStatusNotifier.rebuildRoot();
    } else {
      Navigator.of(context).pop();
      context.vxNav.popToRoot();

      const snackBar = SnackBar(
        content: Text('Incorrect OTP, Please retry'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
