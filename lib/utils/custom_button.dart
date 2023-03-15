// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_null_in_if_null_operators, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final Color textColor;
  final Color buttonColor;
  final void Function() onPressed;
  final double borderRadius;

  /// take all the horizontal space
  final bool autoSize;

  final String text;
  final double fontSize;
  final EdgeInsets edgeInsets;
  final List<BoxShadow> boxShadow;
  final BoxBorder boxBorder;
  final IconData iconData;
  CustomButton({
    @required this.text,
    this.buttonColor = maroonColor,
    this.onPressed,
    this.textColor,
    this.fontSize,
    this.edgeInsets,
    this.borderRadius = 10,
    Key key,
    this.autoSize = false,
    this.boxShadow,
    this.boxBorder,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? null,
      child: Container(
        alignment: autoSize ? Alignment.center : null,
        decoration: BoxDecoration(
            color: buttonColor ?? KThemeDarkGrey,
            border: boxBorder,
            borderRadius: BorderRadius.all(
              Radius.circular(
                borderRadius ?? context.safePercentWidth * 20,
              ),
            ),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                      offset: Offset(0.0, 5.0),
                      blurRadius: 5,
                      color: Theme.of(context).shadowColor),
                ]),
        width: autoSize ? double.infinity : null,
        child: Padding(
          padding: edgeInsets ??
              EdgeInsets.symmetric(
                horizontal: context.safePercentWidth * 10,
                vertical: context.safePercentHeight * 1.8,
              ),
          child: Row(
            mainAxisSize: autoSize ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,
                      style: TextStyle(
                          fontSize: fontSize ??
                              responsiveFontSize(context,
                                  size: ResponsiveFontSizes.m),
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.9,
                          color: textColor ?? Colors.white))
                  .tr(),
              iconData != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        iconData,
                        color: textColor ?? Colors.white,
                        size: 16,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
