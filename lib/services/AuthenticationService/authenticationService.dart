// ignore_for_file: file_names, prefer_final_fields, empty_catches, unnecessary_new, avoid_print, curly_braces_in_flow_control_structures, unused_local_variable

import 'dart:async';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/constants/constBackendConfig.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceService.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/userDataStorage.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authStatusNotifier.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:flutter/material.dart';

import 'cognitoStorageService.dart';

class AuthenticationService {
  CognitoUserPool _userPool = AmplifyConstants.COGNITO_USER_POOL_CONSTANT;
  CognitoUser _cognitoUser;
  CognitoUserSession _session;
  static bool _isUserAuthenticated;
  CognitoUser _currentAuthenticatedUser;
  CognitoCredentials cognitoCredentials;
  AwsSigV4Client awsSigV4Client;

  AuthStatusNotifier authStatusNotifier;

  AuthenticationService({@required this.authStatusNotifier}) {
    _userPool.storage =
        MyCognitoStorage(SharedPreferenceService.sharedPreferences);
  }

  /// Initiate user session from local storage if present
  Future<void> initialiseAuthenticationService(
      {bool throwException = false}) async {
    AuthenticationStatus _authenticationStatus;

    try {
      _cognitoUser = await _userPool.getCurrentUser();
    } catch (e) {}

    if (_cognitoUser == null) {
      _isUserAuthenticated = false;
      _currentAuthenticatedUser = null;
      await _getAuthenticationCredentials(throwException: throwException);

      if (StoreGlobalData.guestUserId.get() != null) {
        _authenticationStatus = AuthenticationStatus.GUESTSIGNEDIN;
      } else {
        _authenticationStatus = AuthenticationStatus.SIGNEDOUT;
      }
    } else {
      _authenticationStatus = AuthenticationStatus.SIGNEDIN;
      _session = await _cognitoUser.getSession();
      _isUserAuthenticated = _session.isValid();
      _currentAuthenticatedUser = _cognitoUser;
      await _getAuthenticationCredentials(
        userSession: _session,
        throwException: throwException,
      );
    }

    authStatusNotifier.changeAuthStatus(
      newStatus: _authenticationStatus,
    );
  }

  Future<void> _getAuthenticationCredentials({
    CognitoUserSession userSession,
    bool throwException = false,
  }) async {
    try {
      cognitoCredentials =
          CognitoCredentials(AmplifyConstants.identityPoolId, _userPool);

      if (userSession != null) {
        await cognitoCredentials
            .getAwsCredentials(_session.getIdToken().getJwtToken());
      } else {
        await cognitoCredentials.getGuestAwsCredentialsId();
      }

      awsSigV4Client = new AwsSigV4Client(
        cognitoCredentials.accessKeyId,
        cognitoCredentials.secretAccessKey,
        AmplifyConstants.endpoint,
        serviceName: AmplifyConstants.serviceName,
        sessionToken: cognitoCredentials.sessionToken,
        region: AmplifyConstants.region,
      );
    } catch (e) {
      String errorMessage =
          "Exception in getting cognito credentials : " + e.toString();
      print(errorMessage);
      if (throwException == true) {
        throw (Exception(errorMessage));
      }
    }
  }

  String getUserId() {
    if (Services.authStatusNotifier.authenticationStatus ==
        AuthenticationStatus.SIGNEDIN) {
      return _currentAuthenticatedUser.username;
    } else if (Services.authStatusNotifier.authenticationStatus ==
        AuthenticationStatus.GUESTSIGNEDIN) {
      // read from storage
      return StoreGlobalData.guestUserId.get();
    } else if (Services.authStatusNotifier.authenticationStatus ==
        AuthenticationStatus.SIGNEDOUT) {
      throw (Exception('Authentication status is signed out'));
    } else {
      throw (Exception('Authentication status is null'));
    }
  }

  cognitoSignIn(CognitoUser cognitoUser) async {
    try {
      await cognitoUser.initiateAuth(
        AuthenticationDetails(
          authParameters: [
            AttributeArg(
              name: 'phone_number',
              value: cognitoUser.username,
            ),
          ],
        ),
      );
    } catch (exception, stackTrace) {
      switch (exception.message) {
        case "DefineAuthChallenge failed with error User does not exist.":
          await signUp(cognitoUser);
          cognitoSignIn(cognitoUser);
          break;
        default:
      }
      print(exception);
      FirebaseCrashlytics.instance.recordError(exception, stackTrace,
          reason: 'DefineAuthChallenge failed with error User does not exist.');
    }
  }

  Future<bool> cognitoVerify(CognitoUser cognitoUser, String smsOTP) async {
    try {
      CognitoUserSession cognitoUserSession =
          await cognitoUser.sendCustomChallengeAnswer(smsOTP);
      if (cognitoUserSession.isValid()) {
        await initialiseAuthenticationService();
        if (!_isUserAuthenticated) return false;
        AnalyticsService().registerSignInEvent();
        return true;
      } else
        return false;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(
        e.toString(),
        s,
      );

      print(e);
      return false;
    }
  }

  signUp(CognitoUser cognitoUser) async {
    CognitoUserPoolData data;
    final userAttributes = [
      AttributeArg(
        name: 'phone_number',
        value: cognitoUser.username,
      ),
    ];
    data = await _userPool.signUp(
        cognitoUser.username, DateTime.now().toString(),
        userAttributes: userAttributes);

    return;
  }

  cognitoSignout() async {
    if (_currentAuthenticatedUser != null) {
      UserDataStorage.deleteAllStoredUserData();
      await _currentAuthenticatedUser.signOut();
    }
  }
}
