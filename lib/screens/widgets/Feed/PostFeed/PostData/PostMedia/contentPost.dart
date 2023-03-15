// ignore_for_file: file_names, annotate_overrides

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/postMediaType.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'postMedia.dart';

class ContentPost extends PostMedia {
  ContentPost({@required PostData postData}) : super(postData: postData) {
    showPlayIcon = false;
    postMediaType = PostMediaType.NO_MEDIA;
  }

  void onMediaClicked(BuildContext context) {}
}
