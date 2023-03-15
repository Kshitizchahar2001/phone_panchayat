// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';

class UpArrow extends StatelessWidget {
  final double bottomPadding;
  const UpArrow({
    Key key,
    this.bottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 12.0),
      child: Container(
        padding: EdgeInsets.all(9.0),
        decoration: BoxDecoration(shape: BoxShape.circle, color: maroonColor),
        child: Icon(
          FontAwesomeIcons.angleUp,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
