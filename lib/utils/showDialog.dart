// ignore_for_file: file_names, unnecessary_new, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';
import 'customResponsiveValues.dart';

showMaterialDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => Material(
            type: MaterialType.transparency,
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.safePercentWidth * 42),
                  child: new AspectRatio(
                      aspectRatio: 1,
                      child: new CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(maroonColor),
                        // strokeWidth: 3,
                      )),
                ),
              ),
            ),
          ));
}

class DialogBoxButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  DialogBoxButton({@required this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? null,
      child: Container(
        alignment: Alignment.center,
        width: context.safePercentWidth * 35,
        decoration: BoxDecoration(
            color: maroonColor,
            borderRadius: BorderRadius.all(Radius.circular(
              context.safePercentWidth * 20,
            )),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 5.0),
                  blurRadius: 5,
                  color: Theme.of(context).shadowColor),
            ]),
        child: Padding(
          padding: getPostWidgetSymmetricPadding(context, horizontal: 0),
          child: Text(text.tr().firstLetterUpperCase(),
              style: TextStyle(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.m),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.9,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
