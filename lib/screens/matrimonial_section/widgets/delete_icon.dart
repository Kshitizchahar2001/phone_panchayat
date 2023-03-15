// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class DeleteIcon extends StatelessWidget {
  const DeleteIcon({Key key, @required this.onTap}) : super(key: key);

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.safePercentWidth * 12,
        height: context.safePercentHeight * 6,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0))),
        child: Icon(Icons.delete_forever_outlined,
            color: maroonColor, size: context.safePercentWidth * 8),
      ),
    );
  }
}
