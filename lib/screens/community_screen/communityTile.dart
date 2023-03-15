// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/CasteCommunity.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class CommunityTile extends StatefulWidget {
  final CasteCommunity casteCommunity;
  CommunityTile({@required this.casteCommunity});
  @override
  _CommunityTileState createState() => _CommunityTileState();
}

class _CommunityTileState extends State<CommunityTile> {
  ThemeMode themeMode;
  String theme;
  @override
  void initState() {
    themeMode = Provider.of<ThemeProvider>(context, listen: false).getThemeMode;
    theme = themeMode.toString().split(".").last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPostWidgetSymmetricPadding(
        context,
        horizontal: 0,
        vertical: 0.4,
      ),
      child: Card(
        color: Theme.of(context).cardColor,
        shadowColor: Theme.of(context).shadowColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
            // side: BorderSide(color: appThemeColor.shade200, width: 0.5),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          // getPostWidgetSymmetricPadding(context, vertical: 1.4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Icon(
                    Icons.people,
                    color: Theme.of(context).textTheme.headline2.color,
                  )),
              SizedBox(
                width: context.safePercentWidth * 2.5,
              ),
              Flexible(
                flex: 6,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${widget.casteCommunity?.name}",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getImageAccordingToTheme(String imagePath, String theme) {
  return imagePath.substring(0, imagePath.lastIndexOf("_") + 1) +
      theme +
      ".png";
}
