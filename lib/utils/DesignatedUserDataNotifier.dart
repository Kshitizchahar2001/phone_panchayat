// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/models/DesignatedUser.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getDesignatedUser.dart';

class DesignatedUserDataNotifier extends ChangeNotifier {
  DesignatedUser _designatedUser;

  updateDesignatedUserDataAndNotifyListeners({String userId}) async {
    _designatedUser = await GetDesignatedUser()
        .getDesignatedUser(id: userId)
        .then((value) => value.designatedUser);
    notifyListeners();
  }

  DesignatedUser get designatedUserModel => _designatedUser;
}
