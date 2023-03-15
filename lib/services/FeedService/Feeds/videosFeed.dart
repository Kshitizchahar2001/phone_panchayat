// ignore_for_file: file_names

import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/enum/videoUrlType.dart';
import 'package:online_panchayat_flutter/models/PostCategory.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/homeFeed.dart';

class VideosFeed extends HomeFeed {
  VideosFeed() {
    feedType = FeedType.VideosFeed;
  }
  @override
  bool getFeedSpecificConditionForPostAddition(PostData postData) =>
      postData.videoURL != null &&
      (postData.post.postCategory == null ||
          postData.post.postCategory == PostCategory.PUBLIC) &&
      postData.videoUrlsTypeMap[postData.videoURL] != VideoUrlType.Facebook;
}
