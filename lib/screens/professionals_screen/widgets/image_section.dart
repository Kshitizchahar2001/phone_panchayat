// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({
    Key key,
    @required this.image,
    @required this.content,
    @required this.buttonText,
    @required this.service,
    this.currentUserId,
  }) : super(key: key);
  final String image;
  final Widget content;
  final Text buttonText;
  final String currentUserId;
  final Map service;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.safePercentHeight * 1.3,
            horizontal: context.safePercentWidth * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                content,
                SizedBox(width: context.safePercentWidth * 1.9),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              RectangularImageLoading(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                //Firebase analytics
                AnalyticsService.firebaseAnalytics.logEvent(
                    name: "sp_bottom_property_and_dabbawala",
                    parameters: {
                      "user_id": currentUserId ?? "",
                      "buttonText": buttonText
                    });

                context.vxNav.push(Uri.parse(MyRoutes.professionalList),
                    params: service);
              },
              child: buttonText,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(maroonColor)),
            ),
          ],
        ),
      ),
    );
  }
}
