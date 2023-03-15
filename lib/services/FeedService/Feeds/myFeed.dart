// ignore_for_file: file_names, annotate_overrides

import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';

import '../multiPageFeed.dart';

class MyFeed extends MultiPageFeed {
  MyFeed() {
    feedType = FeedType.MyFeed;
  }

  Future<FeedQueryData> getPosts() async {
    return await Services
        .gqlQueryService.getPostWithTagsByUserIdAndSortByCreatedAt
        .getPostByUserId(
      userId: Services.globalDataNotifier.localUser.id,
      nextToken: nextToken,
      numberOfPostsTofetch: numberOfPostsToFetch,
    );
  }
}
