
// ignore_for_file: file_names, avoid_print, prefer_conditional_assignment, curly_braces_in_flow_control_structures

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class AnalyticsService {
  static FirebaseAnalytics _firebaseAnalytics;
  static String _previousScreenName;
  static String _currentScreenName;

  static setCurrentScreenOnPush(String screenName) {
    if (screenName != _currentScreenName) {
      _previousScreenName = _currentScreenName;
      _currentScreenName = screenName;
      print(_currentScreenName);
      _firebaseAnalytics.setCurrentScreen(
          screenName: screenName.replaceAll(RegExp('/'), ''));
    }
  }

  static setCurrentScreenOnPop() {
    String tempName = _currentScreenName;
    _currentScreenName = _previousScreenName;
    _previousScreenName = tempName;
    print(_currentScreenName);

    _firebaseAnalytics.setCurrentScreen(
        screenName: _currentScreenName != null
            ? _currentScreenName.replaceAll(RegExp('/'), '')
            : "initial route");
  }

  static set setFirebaseAnalytics(FirebaseAnalytics firebaseAnalytics) {
    if (_firebaseAnalytics == null) {
      _firebaseAnalytics = firebaseAnalytics;
    }
  }

  static FirebaseAnalytics get firebaseAnalytics => _firebaseAnalytics;
  Future<void> startSession() async {
    _firebaseAnalytics.setAnalyticsCollectionEnabled(true);
  }

  Future<void> stopSession() async {
    _firebaseAnalytics.setAnalyticsCollectionEnabled(false);
  }

  registerLinkShareEvent({@required String postId, String method = 'unknow'}) {
    _firebaseAnalytics.logShare(
        contentType: 'Post', itemId: postId, method: method);
  }

  registerAppLaunchEvent() {
    _firebaseAnalytics.logAppOpen();
  }

  registerSignInEvent() {
    _firebaseAnalytics.logLogin();
  }

  registerGuestSignInEvent() {
    _firebaseAnalytics.logEvent(name: 'guest_login', parameters: {
      'user_id': Services.authenticationService.getUserId(),
    });
  }

  registerSigoutEvent() {
    _firebaseAnalytics.logEvent(name: 'logout');
  }

  registerAppLaunchByLinkEvent(
      {@required bool isAuthenticated, @required bool isRegistered}) {
    _firebaseAnalytics.logEvent(name: 'app_launched_with_link', parameters: {
      'is_user_authenticated': isAuthenticated,
      'is_user_registered': isRegistered
    });
  }

  setUserId({@required String id}) {
    _firebaseAnalytics.setUserId(id: id);
  }

  registerUserAttributes({@required User user}) {
    // AnalyticsProperties properties = AnalyticsProperties();
    // if (user.dateOfBirth != null)
    //   properties.addIntProperty(
    //       'age', calculateAge(user.dateOfBirth.getDateTime()));

    // AnalyticsUserProfileLocation location = new AnalyticsUserProfileLocation();
    // location.latitude = user.homeAdressLocation.lat;
    // location.longitude = user.homeAdressLocation.lon;
    // location.postalCode = user.pincode;
    // location.region = user.area;
    // location.country = 'INDIA';

    // AnalyticsUserProfile userProfile = new AnalyticsUserProfile();
    // userProfile.name = user.name;
    // userProfile.location = location;
    int age;
    if (user.dateOfBirth != null)
      age = calculateAge(user.dateOfBirth.getDateTime());
    _firebaseAnalytics.setUserId(id: user.id);
    _firebaseAnalytics.setUserProperty(name: 'age', value: '$age');
    _firebaseAnalytics.setUserProperty(name: 'pincode', value: user.pincode);
    _firebaseAnalytics.setUserProperty(name: 'area', value: user.area);
    _firebaseAnalytics.setUserProperty(name: 'name', value: user.name);
    _firebaseAnalytics.setUserProperty(
        name: 'isMatrimonialProfileComplete',
        value: user.isMatrimonialProfileComplete.toString());
    _firebaseAnalytics.setUserProperty(
        name: 'gender', value: user.gender.toString().split('.').last);
    _firebaseAnalytics.setUserProperty(
      name: 'referrerId',
      value: user.referrerId,
    );
    setUserPlaceProperty(places: user.state_place, propertyName: 'state');
    setUserPlaceProperty(places: user.district_place, propertyName: 'district');
  }

  setUserPlaceProperty({
    @required Places places,
    @required String propertyName,
  }) {
    if (places == null) return;
    _firebaseAnalytics.setUserProperty(
      name: propertyName,
      value: places.name_hi ?? places.id,
    );
  }
}

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
