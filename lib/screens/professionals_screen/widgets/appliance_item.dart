// ignore_for_file: implementation_imports, prefer_const_constructors, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/velocity_x.dart';

class ApplianceItem extends StatelessWidget {
  const ApplianceItem(
      {Key key, @required this.service, @required this.currentUserId})
      : super(key: key);

  final Map service;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Firebase analytics
        AnalyticsService.firebaseAnalytics.logEvent(
            name: "sp_select_service",
            parameters: {
              "user_id": currentUserId ?? "",
              "serviceName": service["name"]
            });

        // Send to professional list screen
        context.vxNav
            .push(Uri.parse(MyRoutes.professionalList), params: service);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: maroonColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5.0)),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: context.safePercentWidth * 2,
            vertical: context.safePercentHeight * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: service["image"],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    RectangularImageLoading(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: context.safePercentHeight * 0.9),
            Text(
              service["name"],
              style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.s)),
            ).tr(),
          ],
        ),
      ),
    );
  }
}
