// ignore_for_file: file_names

import 'package:online_panchayat_flutter/models/DesignatedUser.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/LocalIssueFeed/localIssueData/localIssueData.dart';

class FeedQueryData {
  String nextToken;
  List list;
  Map<String, int> postVersion = <String, int>{};

  set setList(List list) {
    this.list = list;
  }

  set setNextToken(String nextToken) {
    this.nextToken = nextToken;
  }
}

class NormalPostQueryData extends FeedQueryData {
  NormalPostQueryData() {
    list = <PostWithTags>[];
  }
}

class SearchDesignatedUserQueryData extends FeedQueryData {
  SearchDesignatedUserQueryData() {
    list = <DesignatedUser>[];
  }
}

class SearchLocalIssuesQueryData extends FeedQueryData {
  SearchLocalIssuesQueryData() {
    list = <LocalIssueData>[];
  }
}
