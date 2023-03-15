// ignore_for_file: prefer_initializing_formals, unnecessary_this

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/lookingFor.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getMatchesByGender.dart';

class MatchesListData extends ChangeNotifier {
  List<MatrimonialProfile> matches = <MatrimonialProfile>[];
  Gender requestedGender;
  bool loading = true;
  bool locationPermissonDenied = false;
  String nextToken;
  MatrimonialProfile currentProfile;

  MatchesListData({MatrimonialProfile currentProfile}) {
    this.currentProfile = currentProfile;
    if (this.currentProfile.lookingFor == LookingFor.BRIDE) {
      this.requestedGender = Gender.FEMALE;
    } else {
      this.requestedGender = Gender.MALE;
    }
    getMatchesList();
  }

  getMatchesList() async {
    loading = true;
    // matches.clear();
    notifyListeners();
    Map<String, dynamic> data =
        await GetMatchesByGender().getMatchesByGenderAndMaritalStatus(
      gender: requestedGender,
      nextToken: nextToken,
    );
    if (data != null && data["matches"] != null && data["matches"].isNotEmpty) {
      matches.addAll(data["matches"]);
      nextToken = data["nextToken"];
    }

    loading = false;
    notifyListeners();
  }
}
