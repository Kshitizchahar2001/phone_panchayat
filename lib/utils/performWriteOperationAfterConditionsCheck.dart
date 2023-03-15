// ignore_for_file: file_names, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

void performWriteOperationAfterConditionsCheck({
  @required String registrationInstructionText,
  @required Function writeOperation,
  @required BuildContext context,
}) {
  switch (Services.authStatusNotifier.authenticationStatus) {
    case AuthenticationStatus.SIGNEDIN:
      if (!Services.globalDataNotifier.isuserProfileComplete())
        context.vxNav.push(Uri.parse(MyRoutes.registrationRoute),
            params: registrationInstructionText);
      else
        writeOperation();
      break;
    case AuthenticationStatus.GUESTSIGNEDIN:
      context.vxNav.push(
        Uri.parse(MyRoutes.verifyPhoneNumberRoute),
        params: StoreGlobalData.guestUserId.get(),
      );
      break;
    case AuthenticationStatus.SIGNEDOUT:
      throw Exception(
          'You are not signed in. Please sign in to perform this operation.');
      break;
  }

  // if (Services.authStatusNotifier.authenticationStatus ==
  //     AuthenticationStatus.GUESTSIGNEDIN) {

  // } else
}



// if (Services.authStatusNotifier.authenticationStatus ==
//       AuthenticationStatus.GUESTSIGNEDIN) {
//     context.vxNav.push(
//       Uri.parse(MyRoutes.verifyPhoneNumberRoute),
//       params: StoreGlobalData.guestUserId.get(),
//     );
//   } else if (!Services.globalDataNotifier.isuserProfileComplete())
//     context.vxNav.push(Uri.parse(MyRoutes.registrationRoute),
//         params: REGISTRATION_MESSAGE_BEFORE_POST_CREATION);
//   else
//     context.vxNav.push(Uri.parse(MyRoutes.selectPostTag));
