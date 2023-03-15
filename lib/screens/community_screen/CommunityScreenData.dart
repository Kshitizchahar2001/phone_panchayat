// ignore_for_file: file_names, curly_braces_in_flow_control_structures, unnecessary_this

import 'package:online_panchayat_flutter/models/CasteCommunity.dart';

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/gqlQueryService.dart';

class CommunityScreenData extends ChangeNotifier {
  List<CasteCommunity> listOfCommunitys;

  Future<List<CasteCommunity>> getListOfCastCommunitys({
    @required GQLQueryService gqlQueryService,
    @required String pincode,
  }) async {
    if (listOfCommunitys != null)
      return listOfCommunitys;
    else {
      listOfCommunitys =
          await gqlQueryService.listCasteCommunitys.listCasteCommunitys(
        pincode: pincode,
      );
      return listOfCommunitys;
    }
  }

  void rebuildCommunityScreen() {
    this.notifyListeners();
  }
}
