// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/LocalIssueFeed/localIssueFeed.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/getPageAppBar.dart';

class ReviewConstituencyLocalIssues extends StatelessWidget {
  const ReviewConstituencyLocalIssues({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getPageAppBar(
          context: context,
          text: REVIEW_COMPLAINTS,
        ),
        body: LocalIssueFeed(
          feed: Services.globalDataNotifier.constituencyLocalIssuesFeed,
        ));
  }
}
