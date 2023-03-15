// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class HeadingAndSubheading extends StatelessWidget {
  final String heading;
  final String subheading;
  HeadingAndSubheading({this.heading, this.subheading});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading,
                style: Theme.of(context).textTheme.headline2.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.l)))
            .tr(),
        SizedBox(
          height: context.safePercentHeight * 2,
        ),
        subheading != null
            ? Text(subheading,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)))
                .tr()
            : const SizedBox(),
      ],
    );
  }
}
