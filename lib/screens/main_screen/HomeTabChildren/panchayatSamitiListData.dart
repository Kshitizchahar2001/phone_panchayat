// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class PanchayatSamitiListData extends ChangeNotifier {
  List<Places> list;
  bool loading;
  PanchayatSamitiListData() {
    list = <Places>[];
    loading = false;
    getPanchayatSamitiList();
  }

  Future<void> getPanchayatSamitiList() async {
    loading = true;
    list = await Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(
      parentId: Services.globalDataNotifier.localUser.district_id,
      placeType: PlaceType.PANCHAYAT_SAMITI,
    );
    loading = false;
    notifyListeners();
  }
}
