// ignore_for_file: file_names

import 'package:online_panchayat_flutter/screens/electedMemberRegistrationScreen/widgets/registrationForm/Data/ElectedMemberRegistrationFormData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class RecommendRepresentativeData extends ElectedMemberRegistrationFormData {
  // @override
  Future<bool> onFormSubmit(String name, String phoneNumber) async {
    //
    return await Services.gqlMutationService.createMemberRecommendation
        .createMemberRecommendation(
      userId: Services.globalDataNotifier.localUser.id,
      electedMemberName: name,
      electedMemberPhoneNumber: phoneNumber,
      identifier_1: selectedUserType.itemSelection1.selectedItem.id,
      identifier_2: selectedUserType.itemSelection2.selectedItem.id,
      type: selectedUserType.designatedUserType,
      district: district.selectedItem.id,
      designation: selectedDesignation,
    )
        .whenComplete(() {
      AnalyticsService.firebaseAnalytics
          .logEvent(name: "recommend_representative", parameters: {
        "identifier_1": selectedUserType.itemSelection1.selectedItem.id,
        "identifier_2": selectedUserType.itemSelection2.selectedItem.id,
        "type": selectedUserType.designatedUserType.toString(),
        "designation": selectedDesignation.toString(),
        "electedMemberName": name,
        "electedMemberPhoneNumber": phoneNumber,
      });
    });
  }
}
