// ignore_for_file: file_names, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/firestoreModels/Panchayat.dart';
import 'package:online_panchayat_flutter/screens/find_professionals_screen.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/velocity_x.dart';

class PanchayatTile extends StatelessWidget {
  final Panchayat panchayat;
  final Location myLocation;
  final bool selected;
  final NumberFormat f = NumberFormat('#######0.##');
  PanchayatTile({
    Key key,
    this.panchayat,
    this.myLocation,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPostWidgetSymmetricPadding(
        context,
        horizontal: 0,
        vertical: 0.0,
      ),
      child: Card(
        color: Theme.of(context).cardColor,
        shadowColor: Theme.of(context).shadowColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          side: selected
              ? BorderSide(
                  color: maroonColor,
                  width: 1.0,
                )
              : BorderSide(
                  color: Colors.transparent,
                ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: context.safePercentWidth * 2.5,
              ),
              Flexible(
                flex: 6,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${capitalise(panchayat.panchayatName)}',
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: responsiveFontSize(
                            context,
                            size: ResponsiveFontSizes.s10,
                          ),
                        ),
                  ),
                ),
              ),
              SizedBox(
                width: context.safePercentWidth * 2.5,
              ),
              selected
                  ? Icon(
                      Icons.done,
                      color: maroonColor,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
