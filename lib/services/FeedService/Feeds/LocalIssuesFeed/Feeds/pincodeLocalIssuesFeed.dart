// ignore_for_file: file_names, annotate_overrides

import 'package:online_panchayat_flutter/services/FeedService/Feeds/LocalIssuesFeed/localIssuesFeed.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';

class PincodeLocalIssuesFeed extends LocalIssuesFeed {
  PincodeLocalIssuesFeed() {
    // feedType = FeedType.Complaint;
  }

  Future<FeedQueryData> getPosts() async {
    return await Services.gqlQueryService.searchLocalIssuesbyTagAndIdentifiers
        .searchLocalIssuesbyTag(
      nextToken: nextToken,
      limit: numberOfPostsToFetch,
      tagId: Services.globalDataNotifier.localUser.tag,
    );
  }
}
