// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

AppBar getPageAppBar({
  @required BuildContext context,
  bool showBackArrow = true,
  String text,
  double elevation,
  List<Widget> action,
}) {
  return AppBar(
    actions: action ?? [],
    elevation: elevation,
    leading: showBackArrow
        ? IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => {Navigator.pop(context)},
          )
        : null,
    title: text != null
        ? Text(
            text,
            style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.m)),
          ).tr()
        : null,
    // titleSpacing: 20.0,
    automaticallyImplyLeading: true,
  );
}
