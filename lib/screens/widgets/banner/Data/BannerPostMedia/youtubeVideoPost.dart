// ignore_for_file: file_names, annotate_overrides

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:velocity_x/velocity_x.dart';
import 'bannerPostMedia.dart';
import 'package:online_panchayat_flutter/enum/postMediaType.dart';

class BannerYoutubeVideoPost extends BannerPostMedia {
  BannerYoutubeVideoPost({@required PostData postData})
      : super(postData: postData) {
    showPlayIcon = true;
    postMediaType = PostMediaType.YOUTUBE_VIDEO;
  }

  void onMediaClicked(BuildContext context) {
    context.vxNav.push(
      Uri.parse(
        MyRoutes.youtubeVideoScreen,
      ),
      params: postData.videoURL,
    );
  }
}
