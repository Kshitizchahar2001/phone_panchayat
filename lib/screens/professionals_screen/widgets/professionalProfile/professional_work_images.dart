// ignore_for_file: implementation_imports, deprecated_member_use, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class ProfessionalWorkImages extends StatelessWidget {
  const ProfessionalWorkImages({Key key, @required this.workImages})
      : super(key: key);

  final List<String> workImages;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          WORK_IMAGES,
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: context.safePercentHeight * 0.8),
        Wrap(
          children: workImages.map((image) {
            return InkWell(
              onTap: () {
                context.vxNav.push(Uri.parse(MyRoutes.seeFullScreenImage),
                    params: image);
              },
              child: Container(
                width: context.safePercentWidth * 20,
                margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: maroonColor),
                child: Hero(
                    tag: image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                RectangularImageLoading(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
