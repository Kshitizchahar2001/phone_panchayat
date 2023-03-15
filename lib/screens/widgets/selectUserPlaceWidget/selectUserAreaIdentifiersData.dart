// ignore_for_file: file_names

import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';

import 'Data/Identifiers/district.dart';
import 'Data/Identifiers/state.dart';
import 'Data/Identifiers/userAreaType.dart';
import 'Data/selectFirestoreIdentifiers.dart';
import 'Data/userTypeByArea.dart';

class SelectUserAreaIdentifiersData {
  UserTypeByArea rural;
  UserTypeByArea urban;
  UserTypeByArea selectedUserType;
  FirestoreItemSelection district;
  FirestoreItemSelection state;
  FirestoreItemSelection userAreaType;

  SelectUserAreaIdentifiersData() {
    state = State();
    district = District(preceedingIdentifier: state);
    userAreaType = UserAreaType(preceedingIdentifier: district);
    rural = Rural(userAreaType: userAreaType);
    urban = Urban(userAreaType: userAreaType);
    setUserType(rural);
  }

  setUserType(UserTypeByArea userTypeByArea) {
    selectedUserType = userTypeByArea;
    if (!selectedUserType.isInitialised) {
      selectedUserType.initialise();
      selectedUserType.isInitialised = true;
    }
  }

  Future<void> onSubmit() async {
    await Services.gqlMutationService.updateUser.updateUserIdentifiers(
      type: selectedUserType.designatedUserType,
      state_id: state.selectedItem.id,
      district_id: district.selectedItem.id,
      place_1_id: selectedUserType.itemSelection1.selectedItem.id,
      place_2_id: selectedUserType.itemSelection2.selectedItem.id,
    );
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "Select_area_identifers", parameters: {
      'type': selectedUserType.designatedUserType.toString(),
      'state_id': state.selectedItem.id.toString(),
      'district_id': district.selectedItem.id.toString(),
      'place_1_id': selectedUserType.itemSelection1.selectedItem.id.toString(),
      'place_2_id': selectedUserType.itemSelection2.selectedItem.id.toString(),
    });
  }
}
