// ignore_for_file: implementation_imports, prefer_if_null_operators, deprecated_member_use, prefer_const_constructors

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

SnackBar showResultSnackBar(
    BuildContext context, String label, Icon displayIcon) {
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        displayIcon != null ? displayIcon : Container(),
        SizedBox(width: context.safePercentWidth * 0.6),
        Expanded(
          child: Text(
            label.tr(),
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.s),
                  color: Colors.white,
                ),
          ),
        ),
      ],
    ),
    backgroundColor: maroonColor,
    elevation: 2.0,
    duration: Duration(seconds: 2),
    margin: EdgeInsets.symmetric(
        vertical: context.safePercentHeight * 6,
        horizontal: context.safePercentWidth * 13),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: maroonColor)),
    behavior: SnackBarBehavior.floating,
  );
}
