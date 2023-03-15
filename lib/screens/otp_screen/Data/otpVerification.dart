// ignore_for_file: file_names, unnecessary_this

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constBackendConfig.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:online_panchayat_flutter/services/services.dart';

abstract class OtpVerificationData {
  String phoneNo;
  CognitoUser cognitoUser;

  AuthenticationService authenticationService;
  OtpVerificationData({@required this.phoneNo}) {
    authenticationService = Services.authenticationService;
    cognitoUser =
        CognitoUser(this.phoneNo, AmplifyConstants.COGNITO_USER_POOL_CONSTANT);
  }

  void initiateSignIn() {
    authenticationService.cognitoSignIn(this.cognitoUser);
  }

  void verifyOtp({@required String otp, @required BuildContext context});
}
