// ignore_for_file: prefer_const_constructors, duplicate_ignore, deprecated_member_use

// ignore_for_file: prefer_const_constructors

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class AllServices extends StatelessWidget {
  const AllServices({Key key, @required this.servicesList}) : super(key: key);

  final List<Map> servicesList;

  /// Options used for animation in list of services
  final listAnimationOptions = const LiveOptions(
    showItemInterval: Duration(milliseconds: 50),
    showItemDuration: Duration(milliseconds: 100),
    visibleFraction: 0.001,
    reAnimateOnVisibility: false,
  );

  void listTileOnTap(BuildContext context, Map service) {
    if (service["subServices"] != null) {
      context.vxNav.push(Uri.parse(MyRoutes.seeAllServices),
          params: service["subServices"]);
      return;
    }
    context.vxNav.push(Uri.parse(MyRoutes.professionalList), params: service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: maroonColor),
        title: Text(
          SELECT_A_SERVICE,
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
      ),
      body: LiveList.options(
        options: listAnimationOptions,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: servicesList.length,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, -0.1),
                  end: Offset.zero,
                ).animate(animation),
                child: Card(
                  elevation: 0,
                  color: Theme.of(context).cardColor,
                  child: ListTile(
                    onTap: () => listTileOnTap(context, servicesList[index]),
                    leading: CachedNetworkImage(
                      imageUrl: servicesList[index]["image"],
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        child: CircleAvatar(
                            backgroundColor: lightGreySubheading),
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: Text(
                      servicesList[index]["name"],
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
