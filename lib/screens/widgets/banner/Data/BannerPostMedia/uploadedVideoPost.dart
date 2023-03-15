// ignore_for_file: file_names, annotate_overrides, prefer_const_constructors

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/screens/widgets/betterPlayerFrame2.dart';
import 'bannerPostMedia.dart';
import 'package:online_panchayat_flutter/enum/postMediaType.dart';

class BannerUploadedVideoPost extends BannerPostMedia {
  BannerUploadedVideoPost({@required PostData postData})
      : super(postData: postData) {
    showPlayIcon = true;
    postMediaType = PostMediaType.STORAGE_VIDEO;
  }

  void onMediaClicked(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: BetterPlayerFrame2(
            cacheVideoSource: postData.videoSourceMap[postData.videoURL],
            key: ValueKey(
              "${postData.post.id} ${postData.videoURL}",
            ),
            postData: postData,
            betterPlayerConfiguration: BetterPlayerConfiguration(
                fit: BoxFit.contain,
                controlsConfiguration: BetterPlayerControlsConfiguration(
                  showControlsOnInitialize: false,
                )),
          ),
        );
      },
    ));
  }
}
