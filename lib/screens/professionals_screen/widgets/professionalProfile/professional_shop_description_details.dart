// ignore_for_file: implementation_imports, deprecated_member_use

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class ProfessionalShopDescriptionDetails extends StatelessWidget {
  const ProfessionalShopDescriptionDetails(
      {Key key, @required this.shopDescription, @required this.workExperience})
      : super(key: key);
  final String shopDescription;
  final String workExperience;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          SHOP_DESCRIPTION,
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: context.safePercentHeight * 0.8),
        Text(
          shopDescription,
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ),
        SizedBox(height: context.safePercentHeight * 0.8),
        Text(
          "${WORK_EXPERIENCE.tr()} : $workExperience ${YEAR.tr()}",
          style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s),
              ),
        ).tr(),
      ],
    );
  }
}
