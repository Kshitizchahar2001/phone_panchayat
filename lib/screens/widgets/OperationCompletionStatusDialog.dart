// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class OperationCompletionStatusDialog extends StatelessWidget {
  final String heading;
  final String subheading;
  const OperationCompletionStatusDialog({
    Key key,
    @required this.heading,
    @required this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.safePercentHeight * 45,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.safePercentWidth * 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ResponsiveHeight(heightRatio: 4),
                  HeadingAndSubheading(
                    heading: heading,
                    subheading: subheading,
                  ),
                ],
              ),
              Column(
                children: [
                  CustomButton(
                    text: SUBMIT,
                    buttonColor: maroonColor,
                    autoSize: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
