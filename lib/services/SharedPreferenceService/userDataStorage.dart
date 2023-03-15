// ignore_for_file: file_names, non_constant_identifier_names, empty_catches, unused_catch_stack, curly_braces_in_flow_control_structures

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/DesignatedUserType.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/models/Tag.dart';
import 'package:online_panchayat_flutter/models/User.dart';

import 'StoreGlobalData.dart';
import 'sharedPreferenceService.dart';

class UserDataStorage {
  /// returns stored user data. Returns null if no user data is stored
  static User fetchUser() {
    String tag;
    String area;
    double lattitude;
    double longitude;
    String identifier_1;
    String identifier_2;
    String name;
    String designation;
    DesignatedUserType type;
    String state_id;
    String state_place_name_en;
    String state_place_name_hi;
    String state_place_tag_id;

    try {
      tag = SharedPreferenceService.sharedPreferences.getString('tag');
    } catch (e) {}

    try {
      area = SharedPreferenceService.sharedPreferences.getString("area");
    } catch (e) {}

    try {
      lattitude =
          SharedPreferenceService.sharedPreferences.getDouble("lattitude");
    } catch (e) {}

    try {
      longitude =
          SharedPreferenceService.sharedPreferences.getDouble("longitude");
    } catch (e) {}

    try {
      identifier_1 =
          SharedPreferenceService.sharedPreferences.getString("identifier_1");
    } catch (e) {}

    try {
      identifier_2 =
          SharedPreferenceService.sharedPreferences.getString("identifier_2");
    } catch (e) {}

    try {
      name = SharedPreferenceService.sharedPreferences.getString("name");
    } catch (e) {}

    try {
      designation =
          SharedPreferenceService.sharedPreferences.getString("designation");
    } catch (e) {}

    try {
      type = enumFromString<DesignatedUserType>(
        SharedPreferenceService.sharedPreferences.getString("type"),
        [
          DesignatedUserType.URBAN,
          DesignatedUserType.RURAL,
        ],
      );
    } catch (e) {}

    try {
      state_id =
          SharedPreferenceService.sharedPreferences.getString("state_id");
    } catch (e) {}

    try {
      state_place_name_en = SharedPreferenceService.sharedPreferences
          .getString("state_place_name_en");
    } catch (e) {}

    try {
      state_place_name_hi = SharedPreferenceService.sharedPreferences
          .getString("state_place_name_hi");
    } catch (e) {}

    try {
      state_place_tag_id = SharedPreferenceService.sharedPreferences
          .getString("state_place_tag_id");
    } catch (e) {}

    User user = User(
      pincode: '',
      area: area,
      homeAdressLocation: Location(
        lat: lattitude,
        lon: longitude,
      ),
      identifier_1: identifier_1,
      identifier_2: identifier_2,
      type: type,
      name: name,
      designation: designation,
      tag: tag,
      state_id: state_id,
      state_place: Places(
        type: PlaceType.STATE,
        parentId: 'country1',
        id: state_id,
        name_en: state_place_name_en,
        name_hi: state_place_name_hi,
        tag: Tag(
          id: state_place_tag_id,
          name: '',
        ),
      ),
    );

    if (user.area == null) user = null;

    return user;
  }

  static Future<void> setUserData(User user) async {
    await deleteAllStoredUserData();

    try {
      await SharedPreferenceService.sharedPreferences
          .setString('tag', user.tag);
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences
          .setString('area', user.area);
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences
          .setDouble('lattitude', user.homeAdressLocation.lat);
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences
          .setDouble('longitude', user.homeAdressLocation.lon);
    } catch (e, s) {}

    try {
      if (user.identifier_1 != null)
        await SharedPreferenceService.sharedPreferences
            .setString('identifier_1', user.identifier_1);
    } catch (e, s) {}

    try {
      if (user.identifier_2 != null)
        await SharedPreferenceService.sharedPreferences
            .setString('identifier_2', user.identifier_2);
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences
          .setString('type', user.type.toString().split(".").last);
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences
          .setString('name', user.name);
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences
          .setString('designation', user.designation);
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences
          .setString('state_id', user.state_id);
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences
          .setString('state_place_name_en', user.state_place.name_en);
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences
          .setString('state_place_name_hi', user.state_place.name_hi);
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences
          .setString('state_place_tag_id', user.state_place?.tag?.id);
    } catch (e, s) {}
  }

  static Future<void> deleteAllStoredUserData() async {
    StoreGlobalData.user = null;
    try {
      await SharedPreferenceService.sharedPreferences.remove('pincode');
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences.remove('tag');
    } catch (e, s) {}

    try {
      await SharedPreferenceService.sharedPreferences.remove('area');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences.remove('lattitude');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences.remove('longitude');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences.remove('identifier_1');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences.remove('identifier_2');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences.remove('type');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences.remove('name');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences.remove('designation');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences.remove('state_id');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences
          .remove('state_place_name_en');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences
          .remove('state_place_name_hi');
    } catch (e, s) {}
    try {
      await SharedPreferenceService.sharedPreferences
          .remove('state_place_tag_id');
    } catch (e, s) {}
  }
}
