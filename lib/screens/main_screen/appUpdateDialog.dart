// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/services/appUpdateService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class AppUpdateDialog extends StatelessWidget {
  final AppUpdateService appUpdateService;
  const AppUpdateDialog({Key key, @required this.appUpdateService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RemovableWidget(
      onRemoved: () {
        appUpdateService.removeCompleteUpdateDialog();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Card(
                child: Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.mobileAlt,
                          color: maroonColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          NEW_UPDATE_IS_READY_FOR_INSTALL.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          appUpdateService.completeFlexibleUpdate();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            INSTALL_NOW.tr(),
                            style: TextStyle(
                              color: maroonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
