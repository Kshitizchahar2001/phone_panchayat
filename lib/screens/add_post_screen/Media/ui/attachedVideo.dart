// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/mediaUploadData.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/ui/attachedMedia.dart';
import 'package:online_panchayat_flutter/screens/widgets/betterPlayerFrame.dart';

class AttachedVideo extends AttachedMedia {
  // final AddPostScreenData addPostScreenData;
  final MediaUploadData videoUploadData;

  AttachedVideo({Key key, @required this.videoUploadData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (videoUploadData.url != null)
      return BetterPlayerFrame(
        url: videoUploadData.url,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          showControls: false,
        ),
      );
    else
      return BetterPlayerFrame(
        file: videoUploadData.pickedFile,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          showControls: false,
        ),
      );
  }
}
