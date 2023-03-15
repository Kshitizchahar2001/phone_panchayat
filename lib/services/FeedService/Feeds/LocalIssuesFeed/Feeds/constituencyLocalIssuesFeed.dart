// ignore_for_file: file_names, annotate_overrides

import 'package:online_panchayat_flutter/services/FeedService/Feeds/LocalIssuesFeed/localIssuesFeed.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';

class ConstituencyLocalIssuesFeed extends LocalIssuesFeed {
  ConstituencyLocalIssuesFeed() {
    // feedType = FeedType.Complaint;
  }

  Future<FeedQueryData> getPosts() async {
    return await Services.gqlQueryService.searchLocalIssuesbyTagAndIdentifiers
        .searchLocalIssuesbyTagAndIdentifiers(
      nextToken: nextToken,
      limit: numberOfPostsToFetch,
      tagId: Services.globalDataNotifier.localUser.tag,
      identifier_1: Services
          .designatedUserDataNotifier.designatedUserModel.identifier_1
          .toString(),
      identifier_2: Services
          .designatedUserDataNotifier.designatedUserModel.identifier_2
          .toString(),
    );
  }
}
