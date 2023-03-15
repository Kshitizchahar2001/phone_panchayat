// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/find_professionals_data.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

showLogoutDialog(context) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(
            context.safePercentWidth * 5,
          ))),
          title: Text(LOGOUT_CONFIRMATION_TEXT).tr(),
          // content: Text(
          //   "",
          //   style: Theme.of(context).textTheme.headline3.copyWith(
          //       fontSize:
          //           responsiveFontSize(context, size: ResponsiveFontSizes.s)),
          // ).tr(),
          actions: <Widget>[
            DialogBoxButton(
              text: NO.tr(),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            DialogBoxButton(
              text: YES.tr(),
              onPressed: () async {
                showMaterialDialog(context);

                /// To clear the data of static variables used in services section
                // FindProfessionalsData.currentProfessional = null;
                // FindProfessionalsData.isRegisteredAsProfessional = false;
                Provider.of<FindProfessionalsData>(context, listen: false)
                    .logOut();
                AnalyticsService().registerSigoutEvent();

                if (Provider.of<AuthStatusNotifier>(context, listen: false)
                        .authenticationStatus ==
                    AuthenticationStatus.SIGNEDIN) {
                  await Provider.of<AuthenticationService>(context,
                          listen: false)
                      .cognitoSignout();
                } else {
                  await StoreGlobalData.guestUserId.remove();
                }

                await Provider.of<AuthenticationService>(context, listen: false)
                    .initialiseAuthenticationService();
                Provider.of<GlobalDataNotifier>(context, listen: false)
                    .homeFeed
                    .clearList();
                Navigator.pop(context);
                Provider.of<AuthStatusNotifier>(context, listen: false)
                    .rebuildRoot();
              },
            ),
          ],
        ),
      );
    },
  );
}
