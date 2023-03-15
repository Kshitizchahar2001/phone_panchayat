// ignore_for_file: file_names, prefer_is_empty

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:velocity_x/velocity_x.dart';
import 'bannerPostMedia.dart';
import 'package:online_panchayat_flutter/enum/postMediaType.dart';

class BannerImagePost extends BannerPostMedia {
  BannerImagePost({@required PostData postData}) : super(postData: postData) {
    showPlayIcon = false;
    postMediaType = PostMediaType.IMAGE;
  }
  // ImagePost

  @override
  void onMediaClicked(BuildContext context) {
    if (postData.postContentLinkElements.length > 0) {
      context.vxNav.push(
        Uri.parse(MyRoutes.inAppWebViewScreen),
        params: postData.postContentLinkElements[0].text,
      );
      AnalyticsService.firebaseAnalytics
          .logEvent(name: "post_image_link_open", parameters: {
        "link": postData.postContentLinkElements[0].text.toString(),
        "post_id": postData.post.id.toString(),
        "post_owner_id": postData.post.user.id.toString(),
      });
    }
  }
}
