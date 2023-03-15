// ignore_for_file: implementation_imports, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class ProfessionalShopAddressDetails extends StatelessWidget {
  const ProfessionalShopAddressDetails(
      {Key key,
      @required this.isCurrentUserIsProfessional,
      @required this.userLocation,
      @required this.shopLocation,
      @required this.shopAddressLine})
      : super(key: key);
  final bool isCurrentUserIsProfessional;
  final Location userLocation;
  final Location shopLocation;
  final String shopAddressLine;

  @override
  Widget build(BuildContext context) {
    NumberFormat f = NumberFormat('#######0.##');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          SHOP_ADDRESS,
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: context.safePercentHeight * 0.8),
        Text(
          shopAddressLine ?? "",
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ),
        SizedBox(height: context.safePercentHeight * 0.8),
        if (!isCurrentUserIsProfessional)
          Text(
            '${DISTANCE_FROM_YOU.tr()} : ${f.format(Geolocator.distanceBetween(userLocation.lat, userLocation.lon, shopLocation.lat, shopLocation.lon) / 1000.0)} ${KMS.tr()}',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.normal,
                  color: lightBlueBrightColor,
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.s),
                ),
          ).tr(),
      ],
    );
  }
}
