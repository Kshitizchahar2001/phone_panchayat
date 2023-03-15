// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';

class MatrimonialCardButton extends StatelessWidget {
  const MatrimonialCardButton(
      {Key key,
      @required this.onPress,
      this.buttonColor = maroonColor,
      this.icon,
      this.text})
      : super(key: key);

  final Function onPress;
  final Color buttonColor;
  final Icon icon;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: onPress,
          icon: icon,
          label: text),
    );
  }
}
