// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class InstructionText extends StatelessWidget {
  final String text;
  const InstructionText(
      {Key key,
      @required this.text,
      this.backgroundColor = const Color(0xFFE8F5E9),
      this.textColor = Colors.green})
      : super(key: key);
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Container(
            width: double.infinity,
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.headline1.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.normal,
                      fontSize: responsiveFontSize(
                        context,
                        size: ResponsiveFontSizes.s,
                      ),
                    ),
              ).tr(),
            ),
          )
        : Container();
  }
}
