// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class MyCustomModelBottomSheet extends StatelessWidget {
  final List<BottomSheetIconModel> bottomSheetIconModels = [
    // BottomSheetIconModel(
    //     image: text_icon, label: TEXT, route: MyRoutes.createPostRoute),
    // BottomSheetIconModel(
    //   image: camera,
    //   label: PHOTO_VIDEO,
    // ),
    // BottomSheetIconModel(
    //   image: question,
    //   label: QUESTION,
    // ),
    // BottomSheetIconModel(
    //   image: alert_icon,
    //   label: WARNING,
    // ),
    // BottomSheetIconModel(
    //   image: poll,
    //   label: VOTE,
    // ),
  ];

  MyCustomModelBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.safePercentHeight * 45,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              START_PANCHAYAT,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.m)),
            ).tr(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomSheetIconButton(
                  bottomSheetIconModel: bottomSheetIconModels[0],
                ),
                BottomSheetIconButton(
                  bottomSheetIconModel: bottomSheetIconModels[1],
                ),
                BottomSheetIconButton(
                  bottomSheetIconModel: bottomSheetIconModels[2],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: context.safePercentWidth * 2,
                ),
                BottomSheetIconButton(
                  bottomSheetIconModel: bottomSheetIconModels[3],
                ),
                BottomSheetIconButton(
                  bottomSheetIconModel: bottomSheetIconModels[4],
                ),
                SizedBox(
                  width: context.safePercentWidth * 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetIconButton extends StatelessWidget {
  final BottomSheetIconModel bottomSheetIconModel;
  BottomSheetIconButton({this.bottomSheetIconModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (bottomSheetIconModel.route != null)
          {
            Navigator.pop(context),
            context.vxNav.push(Uri.parse(bottomSheetIconModel.route)),
          }
      },
      child: Column(
        children: [
          Image(
            image: AssetImage(bottomSheetIconModel.image),
            height: context.safePercentHeight * 12,
          ),
          Text(
            bottomSheetIconModel.label,
            style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w500,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s)),
          ).tr()
        ],
      ),
    );
  }
}

class BottomSheetIconModel {
  BottomSheetIconModel({
    this.label = "",
    this.image,
    this.route,
  });
  String label;
  String route;
  String image;
}
