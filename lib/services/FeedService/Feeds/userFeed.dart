// ignore_for_file: file_names, annotate_overrides

import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';

import '../multiPageFeedWithChild.dart';

class UserFeed extends MultiPageFeedWithChild {
  UserFeed() {
    feedType = FeedType.UserFeed;
  }

  Future<FeedQueryData> getPosts() async {
    return await Services
        .gqlQueryService.getPostWithTagsByUserIdAndSortByCreatedAt
        .getPostByUserId(
      userId: uniqueId,
      nextToken: nextToken,
      numberOfPostsTofetch: numberOfPostsToFetch,
    );
  }
}
