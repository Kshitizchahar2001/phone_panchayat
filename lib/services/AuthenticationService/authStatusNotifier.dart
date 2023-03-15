// ignore_for_file: file_names, constant_identifier_names, unnecessary_this

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus {
  SIGNEDIN,
  SIGNEDOUT,
  GUESTSIGNEDIN,
}

class AuthStatusNotifier extends ChangeNotifier {
  AuthenticationStatus _authenticationStatus;
  SharedPreferences prefs;

  AuthStatusNotifier() {
    this.addListener(_authStatusListener);
  }

  Future<void> changeAuthStatus({AuthenticationStatus newStatus}) async {
    _authenticationStatus = newStatus;
  }

  bool get isUserSignedIn =>
      _authenticationStatus == AuthenticationStatus.SIGNEDIN ||
              _authenticationStatus == AuthenticationStatus.GUESTSIGNEDIN
          ? true
          : false;

  AuthenticationStatus get authenticationStatus => _authenticationStatus;

  rebuildRoot() {
    notifyListeners();
  }

  _authStatusListener() {
    Services.globalDataNotifier.homeFeed.clearList();
  }

  Future<bool> userDataAvailable({bool shouldNotifyListeners = false}) async {
    if (StoreGlobalData.user != null) {
      Services.globalDataNotifier.setUserData(StoreGlobalData.user,
          shouldNotifyListeners: shouldNotifyListeners);
      isUserRegistered();
      return true;
    } else {
      return await isUserRegistered();
    }
  }

  Future<bool> isUserRegistered() async {
    bool registrationStatus = await Services.gqlQueryService.getUserById
        .getUserById(
            messagingService: Services.firebaseMessagingService,
            notifierService: Services.globalDataNotifier,
            usernameOfLoggedInUser: Services.authenticationService.getUserId());
    if (registrationStatus) {
      Services.analyticsService
          .registerUserAttributes(user: Services.globalDataNotifier.localUser);
    } else {
      Services.analyticsService
          .setUserId(id: Services.authenticationService.getUserId());
    }
    StoreGlobalData.checkAndUpdateRetentionPeriodCompleteness();

    // if (registrationStatus && Services.locationNotifier.location == null) {
    //   await Services.locationNotifier.getPosition();
    // }
    Services.globalDataNotifier.setUserRegisteredStatus = registrationStatus;
    return registrationStatus;
  }
}
