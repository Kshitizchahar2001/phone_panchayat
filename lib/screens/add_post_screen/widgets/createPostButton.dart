// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import '../addPostScreenData.dart';

class CreatePostButton extends StatelessWidget {
  final GlobalDataNotifier globalDataNotifier;
  final AddPostScreenData addPostScreenData;
  CreatePostButton({
    @required this.globalDataNotifier,
    @required this.addPostScreenData,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPostWidgetSymmetricPadding(context, vertical: 0),
      child: Align(
        alignment: Alignment.center,
        child: ValueListenableBuilder<bool>(
          valueListenable:
              Provider.of<AddPostScreenData>(context, listen: false)
                  .isPostButtonEnabled,
          builder: (context, isPostButtonEnabled, child) {
            return InkWell(
              onTap: () async {
                if (isPostButtonEnabled) {
                  try {
                    await addPostScreenData.onPostButtonPressed(context);
                  } catch (e, s) {
                    String exception = "Exception : " + e.toString();
                    print(exception);
                    FirebaseCrashlytics.instance.recordError(exception, s);
                  }
                }
              },
              child: Text(
                POST.tr().toUpperCase(),
                style: TextStyle(
                    color: (isPostButtonEnabled)
                        ? lightBlueBrightColor
                        : lightBlueBrightColor.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.m)),
              ),
            );
          },
        ),
      ),
    );
  }
}
