// ignore_for_file: file_names, annotate_overrides

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/services/services.dart';



abstract class ProfileData {
  String name = "";
  String designation = "";
  ValueNotifier<Gender> gender = ValueNotifier<Gender>(Gender.MALE);
  String homeAdressName = "";
  Location homeAdressLocation;
  DateTime dateOfBirth;
  String image = DEFAULT_USER_IMAGE_URL;

  Future<void> onSubmit();
}

class CreateProfile extends ProfileData {
  Future<void> onSubmit() async {}
}

class EditProfile extends ProfileData {
  User user;
  EditProfile() {
    user = Services.globalDataNotifier.localUser;
    name = user.name ?? "";
    dateOfBirth = user.dateOfBirth?.getDateTime(); //
    designation = user.designation ?? "";
    gender.value = user.gender ?? Gender.MALE;
    homeAdressName = user.homeAdressName ?? "";
    homeAdressLocation =
        user.homeAdressLocation ?? Location(lat: 1.5, lon: 1.5);
    image = user.image ?? DEFAULT_USER_IMAGE_URL;

    Services.locationNotifier.setLocationAndAddress(homeAdressLocation);
  }

  Future<void> onSubmit() async {}
}
