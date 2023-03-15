// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/enum/lookingFor.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({Key key, @required this.value, @required this.onChanged})
      : super(key: key);
  final LookingFor value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            dense: true,
            title: Align(
              child: Text(
                LookingFor.BRIDE.toString().split(".").last.tr(),
                style: Theme.of(context).textTheme.headline3.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                      color: value == LookingFor.BRIDE
                          ? maroonColor
                          : Theme.of(context).textTheme.headline3.color,
                    ),
              ),
              alignment: Alignment(-2.4, 0),
            ),
            leading: Radio<LookingFor>(
              value: LookingFor.BRIDE,
              groupValue: value,
              onChanged: onChanged,
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            dense: true,
            title: Align(
              child: Text(
                LookingFor.GROOM.toString().split(".").last.tr(),
                style: Theme.of(context).textTheme.headline3.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                      color: value == LookingFor.GROOM
                          ? maroonColor
                          : Theme.of(context).textTheme.headline3.color,
                    ),
              ),
              alignment: Alignment(-2.4, 0),
            ),
            leading: Radio<LookingFor>(
                value: LookingFor.GROOM,
                groupValue: value,
                onChanged: onChanged),
          ),
        ),
      ],
    );
  }
}
