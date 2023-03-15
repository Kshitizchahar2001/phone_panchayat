// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/postMediaType.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';

abstract class PostMedia {
  PostData postData;
  PostMediaType postMediaType;
  PostMedia({@required this.postData});
  bool showPlayIcon = false;
  void onMediaClicked(BuildContext context);

  void mediaClicked(BuildContext context) {
    logEvent();
    onMediaClicked(context);
  }

  void logEvent() {
    Map<String, dynamic> parameters = {
      "post_id": "${postData?.post?.id}",
      "post_owner_id": "${postData?.post?.user?.id}",
      "post_media_type": '${postMediaType?.toString()?.split(".")?.last}',
    };
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "post_media_click", parameters: parameters);
  }
}
