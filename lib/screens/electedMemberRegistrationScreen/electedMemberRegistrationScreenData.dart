// ignore_for_file: file_names, avoid_print, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getDesignatedUser.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class ElectedMemberRegistrationScreenData extends ChangeNotifier {
  bool loading;
  ElectedMemberRegistrationScreenData() {
    loading = false;
    fetchDesignatedUser();
  }
  // DesignatedUser designatedUser
  DesignatedUserQueryData designatedUserQueryData;

  Future<void> fetchDesignatedUser() async {
    loading = true;
    notifyListeners();
    designatedUserQueryData = await getDesignatedUserQueryData();
    print("is success : ${designatedUserQueryData.success}");
    loading = false;
    notifyListeners();
  }

  Future<DesignatedUserQueryData> getDesignatedUserQueryData() async {
    Future.delayed(Duration(seconds: 2));
    return await Services.gqlQueryService.getDesignatedUser
        .getDesignatedUser(id: Services.globalDataNotifier.localUser.id);
  }
}
