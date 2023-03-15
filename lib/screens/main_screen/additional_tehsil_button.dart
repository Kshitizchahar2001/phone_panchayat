// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/placeState.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:velocity_x/velocity_x.dart';

class AdditionalTehsilButton extends StatelessWidget {
  const AdditionalTehsilButton({Key key}) : super(key: key);

  void onAdditonalTehsil(BuildContext context) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "additional_tehsil_button_click", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "subscription":
          Services.globalDataNotifier.localUser.subscriptionPlan.toString() ??
              ""
    });
    context.vxNav.push(
      Uri.parse(MyRoutes.selectAdditionalTehsil),
      params: PlaceState(),
    );

    // context.vxNav
    //     .push(Uri.parse(MyRoutes.shareAdditionalTehsil));
  }

  @override
  Widget build(BuildContext context) {
    return CustomButtonWithIcon(
      icon: Icon(
        Icons.add_circle_outline,
        size: 20.0,
        color: Colors.white,
      ),
      label: Text(ADD_OTHER_TEHSIL,
              style: TextStyle(fontSize: 15, color: Colors.white))
          .tr(),
      onClick: () => onAdditonalTehsil(context),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    Key key,
    @required this.onClick,
    this.borderRadius = 20.0,
    @required this.label,
    @required this.icon,
    this.buttonColor = maroonColor,
  }) : super(key: key);

  final Function onClick;
  final double borderRadius;
  final Widget label;
  final Widget icon;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton.icon(
        onPressed: onClick,
        clipBehavior: Clip.antiAlias,
        icon: icon,
        label: label,
        style: ElevatedButton.styleFrom(
            primary: buttonColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius))),
      ),
    );
  }
}
