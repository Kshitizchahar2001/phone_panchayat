// ignore_for_file: implementation_imports, deprecated_member_use

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class ProfessionalPersonalDetails extends StatelessWidget {
  const ProfessionalPersonalDetails(
      {Key key, @required this.mobileNumber, @required this.whatsappNumber})
      : super(key: key);
  final String mobileNumber;
  final String whatsappNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          PERSONAL_DETAILS,
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: context.safePercentHeight * 0.8),
        Text(
          '${MOBILE_NO.tr()} : $mobileNumber',
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ),
        SizedBox(height: context.safePercentHeight * 0.8),
        Text(
          '${WHATSAPP_NUMBER.tr()} : $whatsappNumber',
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ),
      ],
    );
  }
}
