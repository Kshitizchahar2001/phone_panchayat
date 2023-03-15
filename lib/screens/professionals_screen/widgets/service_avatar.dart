// ignore_for_file: implementation_imports, prefer_const_constructors, deprecated_member_use

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ServiceAvatar extends StatelessWidget {
  const ServiceAvatar(
      {Key key,
      @required this.serviceName,
      @required this.image,
      @required this.onClickServiceAvatar})
      : super(key: key);

  final String serviceName;
  final String image;
  final Function onClickServiceAvatar;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickServiceAvatar,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(color: Color(0xffD3DEDC), width: 0.5))),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.safePercentWidth * 1.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: lightGreySubheading,
                radius: 30,
                child: CachedNetworkImage(
                  imageUrl: image,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) => Shimmer.fromColors(
                    child: CircleAvatar(
                        backgroundColor: lightGreySubheading, radius: 30),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: context.safePercentHeight * 0.6),
              Text(
                serviceName,
                style: Theme.of(context).textTheme.headline2.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.s)),
              ).tr(),
            ],
          ),
        ),
      ),
    );
  }
}
