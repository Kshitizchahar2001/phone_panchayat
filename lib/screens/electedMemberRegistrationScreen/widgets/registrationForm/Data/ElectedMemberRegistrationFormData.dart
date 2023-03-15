// ignore_for_file: file_names

import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/designatedUserDesignation.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/screens/widgets/selectUserPlaceWidget/selectUserAreaIdentifiersData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';

Map<DesignatedUserDesignation, String> electedMembersDesignation = {
  DesignatedUserDesignation.CHAIR_PERSON: CHAIR_PERSON.tr(),
  DesignatedUserDesignation.PHONE_PANCHAYAT_MODERATOR:
      PHONE_PANCHAYAT_MODERATOR.tr(),
  DesignatedUserDesignation.SARPANCH: SARPANCH.tr(),
  DesignatedUserDesignation.WARD_MEMBER: WARD_MEMBER.tr(),
  DesignatedUserDesignation.SECRETARY: SECRETARY.tr(),
};

class ElectedMemberRegistrationFormData extends SelectUserAreaIdentifiersData {
  List<DesignatedUserDesignation> designationsList;

  DesignatedUserDesignation selectedDesignation =
      DesignatedUserDesignation.SARPANCH;

  ElectedMemberRegistrationFormData() {
    designationsList = <DesignatedUserDesignation>[];
    electedMembersDesignation.forEach((key, value) {
      designationsList.add(key);
    });
  }

  @override
  Future<void> onSubmit() async {
    await Services.gqlMutationService.createDesignatedUser.createDesignatedUser(
      identifier_1: selectedUserType.itemSelection1.selectedItem.name_hi,
      identifier_2: selectedUserType.itemSelection2.selectedItem.name_hi,
      identifier_1_id: selectedUserType.itemSelection1.selectedItem.id,
      identifier_2_id: selectedUserType.itemSelection2.selectedItem.id,
      pincode: Services.globalDataNotifier.localUser.pincode,
      id: Services.globalDataNotifier.localUser.id,
      type: selectedUserType.designatedUserType,
      designation: selectedDesignation,
      status: DesignatedUserStatus.UNVERIFIED,
    );
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "register_as_representative", parameters: {
      "identifier_1":
          selectedUserType.itemSelection1.selectedItem.name_hi.toString(),
      "identifier_2":
          selectedUserType.itemSelection2.selectedItem.name_hi.toString(),
      "identifier_1_id":
          selectedUserType.itemSelection1.selectedItem.id.toString(),
      "identifier_2_id":
          selectedUserType.itemSelection2.selectedItem.id.toString(),
      "type": selectedUserType.designatedUserType.toString(),
      "designation": selectedDesignation.toString(),
    });
  }
}
