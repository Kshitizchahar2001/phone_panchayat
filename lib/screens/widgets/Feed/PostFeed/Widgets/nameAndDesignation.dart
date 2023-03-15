// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/LocalIssueFeed/localIssueData/localIssueData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:online_panchayat_flutter/utils/StringCaseChange.dart';
import 'package:online_panchayat_flutter/utils/getTimeDifference.dart';
import 'package:online_panchayat_flutter/utils/locationDistanceCalculator.dart';
import 'package:provider/provider.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:easy_localization/easy_localization.dart';

class NameAndDesignation extends StatefulWidget {
  final PostData postData;
  final Feed feed;
  NameAndDesignation({this.postData, this.feed});

  @override
  _NameAndDesignationState createState() => _NameAndDesignationState();
}

class _NameAndDesignationState extends State<NameAndDesignation> {
  LocationNotifier _locationNotifier;
  @override
  Widget build(BuildContext context) {
    _locationNotifier = Provider.of<LocationNotifier>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.white,
          foregroundImage:
              (widget.postData.post.user?.image?.toString() != null)
                  ? NetworkImage(widget.postData.post.user.image)
                  : null,
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            children: [
              Text(
                "${widget.postData.post.user?.name} ",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.xs10),
                    ),
              ),
              Text(
                getTimeDifference(
                        recent: DateTime.now(),
                        old: widget.postData.postCreationDateTime,
                        locale: EasyLocalization.of(context)
                            .currentLocale
                            .toString())
                    .toString(),
                style: Theme.of(context).textTheme.headline4.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.xs)),
              ),
            ],
          ),
        )
      ],
    );
  }

  String getDistance() {
    double distance = LocationDistanceCalculator().getDistance(
      lat1: _locationNotifier.currentLocation.lat,
      lon1: _locationNotifier.currentLocation.lon,
      lat2: widget.postData.post.location.lat,
      lon2: widget.postData.post.location.lon,
    );
    return distance.toString();
  }
}

class PostTags extends StatelessWidget {
  final bool isUrban;
  final LocalIssueData localIssueData;
  const PostTags({
    Key key,
    @required this.isUrban,
    @required this.localIssueData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        Label(
          text: StringCaseChange.onlyFirstLetterCapital(
            (localIssueData.localIssue.place1?.name_hi ??
                    localIssueData.localIssue.place1?.name_en)
                .toString(),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Label(
          text: isUrban
              ? "वार्ड : " +
                  StringCaseChange.onlyFirstLetterCapital(
                    (localIssueData.localIssue.place2?.name_hi ??
                            localIssueData.localIssue.place2?.name_en)
                        .toString(),
                  )
              : StringCaseChange.onlyFirstLetterCapital(
                  (localIssueData.localIssue.place2?.name_hi ??
                          localIssueData.localIssue.place2?.name_en)
                      .toString(),
                ),
        ),
      ],
    );
  }
}

class Label extends StatelessWidget {
  final String text;
  const Label({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 1.5,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 2,
        ),
        decoration: BoxDecoration(
            // color: maroonColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: maroonColor,
              width: 1,
            )),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                fontWeight: FontWeight.normal,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.xs10),
                color: maroonColor,
              ),
        ),
      ),
    );
  }
}
