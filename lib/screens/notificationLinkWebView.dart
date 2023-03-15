// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/Data/suppressedUrl.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'in_app_web_view_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationLinkWebView extends StatelessWidget {
  final SuppressedUrl suppressedUrl;
  const NotificationLinkWebView({
    Key key,
    @required this.suppressedUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InAppWebViewScreen(
              url: suppressedUrl.url.toString(),
              appbar: AppBar(
                actions: [
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.times,
                    ),
                    onPressed: () => {Navigator.pop(context)},
                  )
                ],
                elevation: 0.0,
                title: Text(
                  suppressedUrl?.name ?? "",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.m)),
                ),
                automaticallyImplyLeading: false,
              ),
            ),
          ),
          CustomButton(
            autoSize: false,
            text: CONTINUE,
            borderRadius: 0.0,
            onPressed: () {
              context.vxNav.pop();
            },
          )
        ],
      ),
    );
  }
}
