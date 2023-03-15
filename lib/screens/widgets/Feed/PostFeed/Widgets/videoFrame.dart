// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoFrame extends StatefulWidget with VideoFrameInterface {
  final String url;
  final int index;
  final Feed feed;
  final ValueNotifier<int> pageIndex;
  const VideoFrame({
    Key key,
    @required this.url,
    @required this.index,
    @required this.pageIndex,
    @required this.feed,
  }) : super(key: key);

  @override
  additonalEventListener(YoutubePlayerValue event) {}

  @override
  skipToNextVideo() {}

  @override
  _VideoFrameState createState() => _VideoFrameState();
}

class _VideoFrameState extends State<VideoFrame> {
  YoutubePlayerController _controller;
  bool _isVideoPlaying;
  YoutubePlayerValue globalVideoEvent;
  List<PlayerState> playerLoadingState = <PlayerState>[
    PlayerState.unStarted,
    PlayerState.unknown,
    PlayerState.buffering,
    PlayerState.cued,
  ];
  @override
  void initState() {
    _isVideoPlaying = false;
    initialiseController();
    widget.pageIndex.addListener(pageControllerListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageControllerListener();
    });
    super.initState();
  }

  initialiseController() {
    // ignore: duplicate_ignore
    YoutubePlayerController _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(widget.url),
      autoPlay: false,
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        // useHybridComposition: false,
      ),
    );
    _controller.listen(videoControllerListener);
  }

  void videoControllerListener(YoutubePlayerValue event) {
    if (globalVideoEvent == null) {
      globalVideoEvent = event;
    }
    if (playerLoadingState.contains(globalVideoEvent.playerState) &&
        !playerLoadingState.contains(event.playerState)) {
      globalVideoEvent = event;
      setState(() {});
    }
    widget.additonalEventListener(event);

    if (event.playerState == PlayerState.cued) {
      // event.playerState == PlayerState.playing
      if (_isVideoPlaying && !(event.playerState == PlayerState.ended)) {
        _controller.playVideo();
      }
    }
  }

  void pageControllerListener() {
    try {
      if (widget.index + widget.feed.postAdjustmentNumber ==
          widget.pageIndex.value) {
        print("playing.....");
        _isVideoPlaying = true;
        _controller.playVideo();
      } else {
        _isVideoPlaying = false;
        _controller.pauseVideo();
      }
    } catch (e) {
      print("Error in page controller listener *************" + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Builder(
            builder: (context) {
              if (globalVideoEvent == null ||
                  playerLoadingState.contains(globalVideoEvent.playerState)) {
                return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(
                        child: SpinKitFadingCircle(
                      color: maroonColor,
                    )));
              } else
                return Container();
            },
          ),
          VisibilityDetector(
            onVisibilityChanged: onVisibilityChanged,
            key: widget.key,
            child: YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
              gestureRecognizers: {},
            ),
          ),
        ],
      ),
    );
  }

  void onVisibilityChanged(VisibilityInfo visibilityInfo) {
    if (widget.index + widget.feed.postAdjustmentNumber !=
        widget.pageIndex.value) return;
    if (visibilityInfo.visibleFraction > 0) {
      if (!_isVideoPlaying) {
        _controller.playVideo();
        _isVideoPlaying = true;
      }
    } else {
      print("video not visible");
      if (_isVideoPlaying) {
        print("video was playing");
        _controller.pauseVideo();
        _isVideoPlaying = false;
      }
    }
  }

  @override
  void dispose() {
    _controller.close();
    widget.pageIndex.removeListener(pageControllerListener);
    super.dispose();
  }
}

abstract class VideoFrameInterface {
  additonalEventListener(YoutubePlayerValue event);
  skipToNextVideo();
}
