// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class AadhaarVerificationStatus extends StatefulWidget {
  final TextEditingController aadharNumberTextEditingController;
  AadhaarVerificationStatus({@required this.aadharNumberTextEditingController});

  @override
  _AadhaarVerificationStatusState createState() =>
      _AadhaarVerificationStatusState();
}

class _AadhaarVerificationStatusState extends State<AadhaarVerificationStatus> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.safePercentWidth * 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveHeight(
              heightRatio: 5,
            ),
            HeadingAndSubheading(
              heading: AADHAAR_VERIFICATION_IN_PROCESS, //image
              subheading:
                  "${YOUR_AADHAAR_NUMBER.tr()} ${widget.aadharNumberTextEditingController.text}\n\n${AADHAAR_VERIFICATION_IN_PROCESS_DESCRIPTION.tr()}", //image
            ),
            ResponsiveHeight(
              heightRatio: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DialogBoxButton(
                    text: CLOSE,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
              ],
            ),
            ResponsiveHeight(heightRatio: 5),
          ],
        ),
      ),
    );
  }
}
