// ignore_for_file: prefer_if_null_operators, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB(
      {Key key,
      @required this.label,
      this.icon,
      this.onPressed,
      this.color,
      this.textColor})
      : super(key: key);

  final String label;
  final Icon icon;
  final Function onPressed;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.safePercentWidth * 55,
      child: FloatingActionButton(
        backgroundColor: color != null ? color : Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.safePercentHeight * 0.3,
              horizontal: context.safePercentWidth * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.headline2.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.m),
                    color: textColor ?? maroonColor,
                    fontWeight: FontWeight.w600),
              ).tr(),
              SizedBox(width: context.safePercentWidth * 1.5),
              if (icon != null) ...[
                icon,
              ]
            ],
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
