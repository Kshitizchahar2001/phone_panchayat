// ignore_for_file: file_names, unused_import

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/models/LocalIssue.dart';
import 'package:online_panchayat_flutter/models/LocalIssueWithTag.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';

class LocalIssueData {
  LocalIssueWithTag localIssue;
  int version;
  PostData postData;

  LocalIssueData({
    @required this.localIssue,
    @required this.postData,
    @required this.version,
  });
}
