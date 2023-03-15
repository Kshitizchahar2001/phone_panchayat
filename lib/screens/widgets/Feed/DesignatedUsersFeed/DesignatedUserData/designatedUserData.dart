// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:online_panchayat_flutter/models/DesignatedUser.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getUserById.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class DesignatedUserData extends ChangeNotifier {
  DesignatedUser designatedUser;
  int version;
  bool isUserVerified;

  DesignatedUserData({this.designatedUser, this.version}) {
    isUserVerified = designatedUser.status == DesignatedUserStatus.VERIFIED;
  }

  Future<void> approveUser() async {
    GetUserQueryData getUserQueryData = await Services
        .gqlQueryService.getUserById
        .getUserData(id: designatedUser.id);

    await Services.gqlMutationService.updateUser.verifyDesignatedUser(
      id: designatedUser.id,
      expectedVersion: getUserQueryData.version,
      isDesignatedUser: true,
    );

    await Services.gqlMutationService.updateDesignatedUser.updateDesignatedUser(
      id: designatedUser.id,
      designatedUserStatus: DesignatedUserStatus.VERIFIED,
      designatedUserData: this,
    );

    isUserVerified = true;
    notifyListeners();
  }
}
