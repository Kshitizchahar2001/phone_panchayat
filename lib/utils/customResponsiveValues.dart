// ignore_for_file: file_names, curly_braces_in_flow_control_structures, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

EdgeInsetsGeometry getPostWidgetSymmetricPadding(BuildContext context,
    {double vertical = 1.2, double horizontal = 4}) {
  if (context.orientation == Orientation.landscape)
    return EdgeInsets.symmetric(
        horizontal: context.safePercentWidth * horizontal * 0.6,
        vertical: context.safePercentHeight * vertical * 1.4);
  else
    return EdgeInsets.symmetric(
        horizontal: context.safePercentWidth * horizontal,
        vertical: context.safePercentHeight * vertical);
}

enum ResponsiveFontSizes { xs, xs10, s, s10, m, m10, l, xl }

double responsiveFontSize(BuildContext context, {ResponsiveFontSizes size}) {
  double fontSize;
  switch (size) {
    case ResponsiveFontSizes.xs:
      fontSize = context.safePercentWidth * 2.6;
      break;
    case ResponsiveFontSizes.xs10:
      fontSize = context.safePercentWidth * 3.0;
      break;

    case ResponsiveFontSizes.s:
      fontSize = context.safePercentWidth * 3.6;
      break;

    case ResponsiveFontSizes.s10:
      fontSize = context.safePercentWidth * 4.2;
      break;

    case ResponsiveFontSizes.m:
      fontSize = context.safePercentWidth * 4.7;
      break;
    case ResponsiveFontSizes.m10:
      fontSize = context.safePercentWidth * 5.8;
      break;

    case ResponsiveFontSizes.l:
      fontSize = context.safePercentWidth * 7.5;
      break;

    case ResponsiveFontSizes.xl:
      fontSize = context.safePercentWidth * 10;
      break;

    default:
      fontSize = context.safePercentWidth * 2.5;
      break;
  }
  if (context.orientation == Orientation.landscape) fontSize = fontSize / 1.5;
  return fontSize;
}

class ResponsiveHeight extends StatelessWidget {
  final double heightRatio;
  ResponsiveHeight({this.heightRatio = 4});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.safePercentHeight * heightRatio,
    );
  }
}
