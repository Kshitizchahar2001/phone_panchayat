// ignore_for_file: file_names, overridden_fields, annotate_overrides, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/postMediaType.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostMedia/postMedia.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';

export './contentPost.dart';
export './facebookVideoPost.dart';
export './imagePost.dart';
export './uploadedVideoPost.dart';
export './youtubeVideoPost.dart';

abstract class BannerPostMedia extends PostMedia {
  PostData postData;
  PostMediaType postMediaType;
  BannerPostMedia({@required this.postData});
  bool showPlayIcon = false;

  void onMediaClicked(BuildContext context);

  void mediaClicked(BuildContext context) {
    logEvent();
    onMediaClicked(context);
  }

  @override
  void logEvent() {
    Map<String, dynamic> parameters = {
      "post_id": "${postData?.post?.id}",
      "post_owner_id": "${postData?.post?.user?.id}",
      "post_media_type": '${postMediaType?.toString()?.split(".")?.last}',
    };
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "banner_click", parameters: parameters);
  }
}
