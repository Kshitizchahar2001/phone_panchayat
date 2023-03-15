// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/postMediaType.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'postMedia.dart';

class FacebookVideoPost extends PostMedia {
  FacebookVideoPost({@required PostData postData}) : super(postData: postData) {
    showPlayIcon = true;
    postMediaType = PostMediaType.FACEBOOK_VIDEO;
  }

  @override
  void onMediaClicked(BuildContext context) {}
}
