import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/videoUrlType.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';

import 'BannerPostMedia/bannerPostMedia.dart';

class BannerPostData extends PostData {
  BannerPostData({
    @required PostWithTags post,
    @required int version,
  }) : super(post: post, version: version);

  @override
  initialisePostMedia() {
    if (videoURL != null) {
      if (videoUrlsTypeMap[videoURL] == VideoUrlType.Youtube) {
        postMedia = BannerYoutubeVideoPost(postData: this);
      } else if (videoUrlsTypeMap[videoURL] == VideoUrlType.Facebook) {
        postMedia = BannerFacebookVideoPost(postData: this);
      } else {
        postMedia = BannerUploadedVideoPost(postData: this);
      }
    } else if (getFirstImage() != null) {
      postMedia = BannerImagePost(postData: this);
    } else {
      postMedia = BannerContentPost(postData: this);
    }
  }
}
