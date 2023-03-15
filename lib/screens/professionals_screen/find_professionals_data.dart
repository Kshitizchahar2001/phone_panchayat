import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getProfessionalList.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class FindProfessionalsData extends ChangeNotifier {
  Professional currentProfessional;
  bool isRegisteredAsProfessional;
  bool loadingProfessional = false;
  bool updateProfessionalComplete;
  User user;

  ///  check if isRegisteredAsProfessional is null or not befor query

  FindProfessionalsData() {
    getProfessional();
  }

  Future<Professional> getProfessional() async =>
      currentProfessional ?? await fetchProfessional();

  Future<Professional> fetchProfessional() async {
    // loadingProfessional = true;
    // notifyListeners();
    String userId = Services.globalDataNotifier.localUser.id;
    Professional currentUserAsProfessional =
        await GetProfessionals().getProfessionalById(id: userId);
    if (currentUserAsProfessional != null) {
      isRegisteredAsProfessional = true;
      currentProfessional = currentUserAsProfessional;
    } else {
      isRegisteredAsProfessional = false;
    }

    notifyListeners();
    return currentUserAsProfessional;
  }

  void logOut() {
    isRegisteredAsProfessional = null;
    currentProfessional = null;
    notifyListeners();
  }

  get getCurrentProfessional => currentProfessional;
}
