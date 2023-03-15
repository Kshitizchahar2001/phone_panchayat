// ignore_for_file: implementation_imports, deprecated_member_use, prefer_const_constructors

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class ProfessionalWorkSpeciality extends StatelessWidget {
  const ProfessionalWorkSpeciality({Key key, @required this.workSpeciality})
      : super(key: key);
  final List<String> workSpeciality;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          WORK_SPECIALITY,
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: context.safePercentHeight * 0.8),
        Wrap(
          children: workSpeciality.map((work) {
            return Container(
              margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: maroonColor),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(work).tr(),
            );
          }).toList(),
        ),
      ],
    );
  }
}
