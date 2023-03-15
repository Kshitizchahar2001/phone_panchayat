// ignore_for_file: file_names, annotate_overrides

import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';

import '../singlePageFeed.dart';

class SinglePost extends SinglePageFeed {
  SinglePost() {
    feedType = FeedType.SinglePost;
  }

  Future<FeedQueryData> getPosts() async {
    return await Services.gqlQueryService.getPostWithTags.getPostWithTags(
      postId: uniqueId,
    );
  }
}
