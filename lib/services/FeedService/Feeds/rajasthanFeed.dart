// ignore_for_file: file_names, annotate_overrides

import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/services/FeedService/multiPageFeedWithChild.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';

class RajasthanFeed extends MultiPageFeedWithChild {
  RajasthanFeed() {
    feedType = FeedType.RajasthanFeed;
  }

  Future<FeedQueryData> getPosts() async {
    return await Services.gqlQueryService.searchPostByTag.searchPostByTag(
      tag: Services.globalDataNotifier.localUser.state_place.tag.id,
      numberOfPostsTofetch: numberOfPostsToFetch,
      nextToken: nextToken,
    );
  }
}
