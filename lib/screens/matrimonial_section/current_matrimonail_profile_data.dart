import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getMatimonialProfile.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class CurrentMatrimonailProfileData extends ChangeNotifier {
  MatrimonialProfile currentUserProfile;
  bool isUserRegistered;
  bool isPremiumPurchased;
  bool loadingProfile = false;
  bool isUserLoaded = true;
  User user;
  double currentProfilePercentage = 0;

  ///  check if isRegisteredAsProfessional is null or not befor query

  CurrentMatrimonailProfileData() {
    getCurrentMatrimonialProfile();
  }

  Future<MatrimonialProfile> getCurrentMatrimonialProfile() async =>
      currentUserProfile ?? await fetchMatrimonailProfile();

  Future<MatrimonialProfile> fetchMatrimonailProfile() async {
    // loadingProfessional = true;
    notifyListeners();
    String userId = Services.globalDataNotifier.localUser.id;
    if (userId == null) {
      isUserLoaded = false;
      notifyListeners();
      return null;
    }

    MatrimonialProfile currentProfile =
        await GetMatrimonialProfile().getMatrimonialProfile(id: userId);
    if (currentProfile != null) {
      currentUserProfile = currentProfile;
      isUserRegistered = true;
      setProfilePercentage();
    } else {
      isUserRegistered = false;
    }

    notifyListeners();
    return currentUserProfile;
  }

  void setProfilePercentage() {
    if (currentUserProfile.mobileNumber != null &&
        currentUserProfile.rashi != null &&
        currentUserProfile.profileFor != null) {
      currentProfilePercentage = 100;
      return;
    }

    currentProfilePercentage = 70;
  }

  void logOut() {
    isUserRegistered = null;
    currentUserProfile = null;
    notifyListeners();
  }

  get getMatrimonialProfile => currentUserProfile;
}
