// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/getPageAppBar.dart';

import 'widgets/Feed/LocalIssueFeed/localIssueFeed.dart';

class ViewAllComplaintsScreen extends StatefulWidget {
  const ViewAllComplaintsScreen({Key key}) : super(key: key);

  @override
  _ViewAllComplaintsScreenState createState() =>
      _ViewAllComplaintsScreenState();
}

class _ViewAllComplaintsScreenState extends State<ViewAllComplaintsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: COMPLAINTS,
      ),
      body: LocalIssueFeed(
        feed: Services.globalDataNotifier.pincodeLocalIssuesFeed,
      ),
    );
  }
}
