// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/placeState.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/velocity_x.dart';

class TopSnackBar extends StatelessWidget {
  final Map<String, dynamic> topSnackBarConfig;
  const TopSnackBar({Key key, @required this.topSnackBarConfig})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AnalyticsService.firebaseAnalytics
            .logEvent(name: "top-snackbar-click", parameters: {
          "user_id": Services.globalDataNotifier.localUser.id ?? "",
          "snackbar_title": topSnackBarConfig["displayText"] ?? "",
          "snackbar_action": topSnackBarConfig["action"] ?? ""
        });
        if (topSnackBarConfig["action"] == "OPEN_ADDITIONAL_TEHSIL_ROUTE") {
          context.vxNav.push(Uri.parse(MyRoutes.selectAdditionalTehsil),
              params: PlaceState());
        }
      },
      child: Card(
        elevation: 2.0,
        color: lightPink,
        child: SizedBox(
          width: double.infinity,
          height: context.safePercentHeight * 5,
          child: Center(
            child: Text(
              topSnackBarConfig["displayText"] ?? "",
              style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.xs),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
