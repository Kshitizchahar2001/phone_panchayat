// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/utils/StringCaseChange.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';

class UserDetail extends StatelessWidget {
  final String heading;
  final String value;
  const UserDetail({
    Key key,
    @required this.heading,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: Theme.of(context).textTheme.headline3.copyWith(
                fontWeight: FontWeight.normal,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s),
              ),
        ),
        Text(
          StringCaseChange.onlyFirstLetterCapital(value),
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontWeight: FontWeight.normal,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s),
              ),
        ),
      ],
    );
  }
}
