// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/approveDesignatedUsersFeed.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class DesignatedMembersRegistrationRequestsScreen extends StatelessWidget {
  const DesignatedMembersRegistrationRequestsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getPageAppBar(
          context: context,
          text: REVIEW_REQUESTS,
        ),
        body: ApproveDesignatedUsersFeed());
  }
}
