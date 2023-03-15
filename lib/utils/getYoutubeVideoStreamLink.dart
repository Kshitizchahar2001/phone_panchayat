// ignore_for_file: file_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<String> getYoutubeVideoStreamLink(String youtubeVideoId) async {
  var yt = YoutubeExplode();
  MuxedStreamInfo selectedStreamInfo;
  String streamUrl;

  List<VideoQuality> videoQualities = [
    VideoQuality.low240,
    VideoQuality.medium360,
    VideoQuality.medium480,
    VideoQuality.high720,
  ];

  try {
    StreamManifest manifest =
        await yt.videos.streamsClient.getManifest(youtubeVideoId);
    print(
        "streams available for this video" + manifest.muxed.length.toString());
    // selectedStreamInfo = manifest.muxed.sortByBitrate().last;
    selectedStreamInfo = manifest.muxed.sortByVideoQuality().last;

    for (int i = 0; i < manifest.muxed.length; i++) {
      MuxedStreamInfo tempStreamInfo;
      tempStreamInfo = manifest.muxed.toList()[i];

      print(tempStreamInfo.videoQuality.toString());

      if (videoQualities.contains(tempStreamInfo.videoQuality)) {
        int indexOfTemporaryStreamInfo =
            videoQualities.indexOf(tempStreamInfo.videoQuality);

        int indexOfSelectedStreamInfoQuality =
            videoQualities.indexOf(selectedStreamInfo.videoQuality);

        if (indexOfSelectedStreamInfoQuality == -1) {
          selectedStreamInfo = tempStreamInfo;
        } else if (indexOfSelectedStreamInfoQuality >
            indexOfTemporaryStreamInfo) {
          selectedStreamInfo = tempStreamInfo;
        }
      }
    }

    print("Selected Quality is " + selectedStreamInfo.videoQuality.toString());

    // selectedStreamInfo = manifest.muxed.sortByBitrate()[0];
    streamUrl = selectedStreamInfo.url.toString();
  } catch (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
    print(e);
  }
  yt.close();
  return streamUrl;
}
