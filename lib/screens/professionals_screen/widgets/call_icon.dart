// ignore_for_file: implementation_imports, deprecated_member_use

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class CallIcon extends StatelessWidget {
  const CallIcon({Key key, @required this.professional}) : super(key: key);

  final Professional professional;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            AnalyticsService.firebaseAnalytics
                .logEvent(name: "call_professional", parameters: {
              "professional_phone_number": professional.mobileNumber,
              "profession": professional.occupationName,
              "professional_name": professional.mobileNumber,
              "caller_id": Services.globalDataNotifier.localUser.id,
            });
            launch('tel:${professional.mobileNumber}');
          },
          icon: Icon(
            Icons.phone,
            size: responsiveFontSize(context, size: ResponsiveFontSizes.l),
            color: Colors.green,
          ),
          padding: EdgeInsets.symmetric(
              vertical: context.safePercentHeight * 0.1,
              horizontal: context.safePercentWidth * 1.2),
        ),
        Text(
          CALL,
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize: responsiveFontSize(
                context,
                size: ResponsiveFontSizes.xs,
              ),
              color: lightGreySubheading),
        ).tr(),
      ],
    );
  }
}
