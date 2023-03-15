// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class MenuItemTile extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function onTap;
  final Color iconColor;
  const MenuItemTile({
    Key key,
    @required this.text,
    @required this.onTap,
    this.iconData,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                text,
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.m),
                    ),
              ),
            ),
            iconData != null
                ? Icon(
                    iconData,
                    color: iconColor ??
                        Theme.of(context).textTheme.headline1.color,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
