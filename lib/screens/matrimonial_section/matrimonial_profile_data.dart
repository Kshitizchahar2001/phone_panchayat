// ignore_for_file: overridden_fields, annotate_overrides, unnecessary_this, non_constant_identifier_names, prefer_null_aware_operators

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/gotre.dart';
import 'package:online_panchayat_flutter/enum/lookingFor.dart';
import 'package:online_panchayat_flutter/enum/maritalStatus.dart';
import 'package:online_panchayat_flutter/enum/profileFor.dart';
import 'package:online_panchayat_flutter/enum/rashi.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/models/Sibling.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenData.dart';
import 'package:online_panchayat_flutter/enum/education.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/getPlaceName.dart';

class CreateMatrimonialProfileData extends ProfileData {
  String id;
  String name;
  DateTime dateOfBirth;
  String caste;
  String mobileNumber;
  Education education = Education.TWELEVE_PASS;
  String occupation;
  MaritalStatus maritalStatus = MaritalStatus.SINGLE;
  Gotre gotre;
  LookingFor lookingFor = LookingFor.BRIDE;
  List<String> images = <String>[];

  void onChangedRadioButton(LookingFor value) {
    lookingFor = value;
  }

  void onGotreChanged(dynamic value) {
    this.gotre = value;
  }

  List<DropdownMenuItem> getDropdownItems(List items) {
    List<DropdownMenuItem> dropDownlist = [];
    for (int i = 0; i < items.length; i++) {
      dropDownlist.add(DropdownMenuItem(
          child: Text(items[i].toString().split(".").last.tr()),
          value: items[i]));
    }
    return dropDownlist;
  }

  Future<void> onSubmit() async {}
}

class UpdateMatrimonialProfileData extends CreateMatrimonialProfileData {
  ProfileFor profileFor;
  String state_id;
  String district_id;
  String height;
  Sibling brothers;
  Sibling sisters;
  Rashi rashi;

  UpdateMatrimonialProfileData(MatrimonialProfile matrimonialProfile) {
    this.id =
        matrimonialProfile?.id ?? Services.globalDataNotifier.localUser.id;
    this.name = matrimonialProfile?.name ?? "";
    this.caste = matrimonialProfile?.caste ?? "";
    this.gotre = matrimonialProfile?.gotre;
    this.maritalStatus = matrimonialProfile?.maritalStatus;
    this.education = matrimonialProfile?.education;
    this.lookingFor = matrimonialProfile?.lookingFor;
    this.gender = ValueNotifier<Gender>(matrimonialProfile?.gender);
    this.profileFor = matrimonialProfile?.profileFor;
    this.height = matrimonialProfile?.height;
    this.occupation = matrimonialProfile?.occupation ?? "";
    this.brothers = Sibling(
        total: matrimonialProfile?.brothers != null
            ? matrimonialProfile.brothers.total
            : null,
        married: matrimonialProfile?.brothers != null
            ? matrimonialProfile.brothers.married
            : null);
    this.sisters = Sibling(
        total: matrimonialProfile?.sisters != null
            ? matrimonialProfile.sisters.total
            : null,
        married: matrimonialProfile.sisters != null
            ? matrimonialProfile.sisters.married
            : null);
    this.rashi = matrimonialProfile?.rashi;
    this.images = matrimonialProfile?.images;
  }

  List<String> generateHeightList(int startHeightInFeet, int endHeightInFeet) {
    List<String> heightList = [];
    for (int feet = startHeightInFeet; feet < endHeightInFeet; feet++) {
      for (int inch = 0; inch < 12; inch++) {
        if (inch == 0) {
          heightList.add("${feet}ft");
        } else {
          heightList.add("${feet}ft ${inch}inch");
        }
      }
    }
    return heightList;
  }

  List<int> generateSiblingList(int start, int end) {
    List<int> siblingList = [];
    for (int i = start; i <= end; i++) {
      siblingList.add(i);
    }
    return siblingList;
  }

  void onEducationChanged(value) {
    this.education = value;
  }

  void onProfileForChanged(value) {
    this.profileFor = value;
  }

  void onMaritalStatusChanged(value) {
    this.maritalStatus = value;
  }

  void onHeightChanged(value) {
    this.height = value;
  }

  void onRashiChanged(value) {
    this.rashi = value;
  }

  void onTotalSisterChanged(value) {
    this.sisters.total = value;
  }

  void onTotalBrotherChanged(value) {
    this.brothers.total = value;
  }

  // Method to get dropdown of places
  List<DropdownMenuItem<String>> makeDropDownList(
      List<Places> listOfPlaces, BuildContext context) {
    List<DropdownMenuItem<String>> dropDownList = <DropdownMenuItem<String>>[];
    for (int i = 0; i < listOfPlaces.length; i++) {
      dropDownList.add(DropdownMenuItem<String>(
        child: Text(GetPlaceName.getPlaceName(listOfPlaces[i], context)),
        value: listOfPlaces[i].id,
      ));
    }
    dropDownList.sort((a, b) {
      return a.value.compareTo(b.value);
    });
    return dropDownList;
  }

  List<DropdownMenuItem> getDropdownItemsFromListOfString(List items) {
    List<DropdownMenuItem> dropDownlist = [];
    for (int i = 0; i < items.length; i++) {
      dropDownlist.add(
          DropdownMenuItem(child: Text(items[i].toString()), value: items[i]));
    }
    return dropDownlist;
  }
}
