// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/tour.dart';

class MyDescribedFeatureOverlay extends StatelessWidget {
  final Widget child;
  final Widget tapTarget;
  final String featureId;
  final Tour tour;
  final ContentLocation contentLocation;
  final Color backgroundColor;
  final Function onComplete;
  const MyDescribedFeatureOverlay({
    Key key,
    @required this.child,
    @required this.tapTarget,
    @required this.featureId,
    @required this.tour,
    this.contentLocation,
    this.backgroundColor,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DescribedFeatureOverlay(
        child: child,
        onComplete: onComplete,
        featureId: featureId,
        tapTarget: tapTarget,
        contentLocation: contentLocation ?? ContentLocation.trivial,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        title: Text(tour.title),
        textColor: Colors.white,
        overflowMode: OverflowMode.wrapBackground,
        description: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              tour.description,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                onComplete();
                FeatureDiscovery.completeCurrentStep(context);
              },
              child: Row(
                children: [
                  Text(
                    "और देखें",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.white,
                    size: 12.0,
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () => FeatureDiscovery.dismissAll(context),
              child: Text(
                "बंद करें",
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
