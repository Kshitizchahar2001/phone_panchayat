// ignore_for_file: file_names, avoid_print, curly_braces_in_flow_control_structures

import 'package:better_player/better_player.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/enum/videoUrlType.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:youtube_parser/youtube_parser.dart';

class CacheVideoSource {
  String url;
  VideoUrlType videoUrlType;
  Future<void> Function(String) updatePostVideoUrl;
  BetterPlayerDataSource betterPlayerDataSource;
  Future<BetterPlayerDataSource> futureBetterPlayerDataSource;

  CacheVideoSource({
    @required this.url,
    @required this.videoUrlType,
    @required this.updatePostVideoUrl,
  }) {
    initialiseDataSource();
  }

  initialiseDataSource() async {
    futureBetterPlayerDataSource = getVideoSource();
    betterPlayerDataSource = await futureBetterPlayerDataSource;
  }

  Future<BetterPlayerDataSource> getVideoSource() async {
    String youtubeVideoId;
    String youtubeVideoDirectStreamUrl;
    BetterPlayerDataSource betterPlayerDataSource;
    if (url != null && videoUrlType == VideoUrlType.Storage) {
      betterPlayerDataSource =
          BetterPlayerDataSource(BetterPlayerDataSourceType.network, url);
    } else if (url != null && videoUrlType == VideoUrlType.Youtube) {
      try {
        youtubeVideoId = getIdFromUrl(url);
        if (youtubeVideoId == null) throw Exception("Invalid youtube url");
      } catch (e, s) {
        print("catch block 1");
        FirebaseCrashlytics.instance.recordError(e, s);
        print(e);
        return null;
      }
      try {
        youtubeVideoDirectStreamUrl =
            await getYoutubeVideoStreamLink(youtubeVideoId);
        if (youtubeVideoDirectStreamUrl == null)
          throw Exception("could not get youtube video download link");
      } catch (e, s) {
        print("catch block 2");
        FirebaseCrashlytics.instance.recordError(e, s);
        print(e);
        return null;
      }

      betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, youtubeVideoDirectStreamUrl);
      updatePostVideoUrl(youtubeVideoDirectStreamUrl);
    }
    return betterPlayerDataSource;
  }
}
