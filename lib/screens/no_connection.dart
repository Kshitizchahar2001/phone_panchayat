// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class NoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wifi_off_outlined,
          color: Theme.of(context).textTheme.headline2.color,
          size: context.safePercentHeight * 10,
        ),
        SizedBox(
          height: context.safePercentHeight * 2,
        ),
        Text(
          "No internet connection",
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        )
      ],
    )));
  }
}
