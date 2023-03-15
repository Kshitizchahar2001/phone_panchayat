// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment, avoid_print, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoScreen extends StatefulWidget {
  final String url;
  const YoutubeVideoScreen({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  _YoutubeVideoScreenState createState() => _YoutubeVideoScreenState();
}

class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
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
    super.initState();
  }

  initialiseController() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(widget.url),
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: false,
        // useHybridComposition: false,
        playsInline: false,
        // desktopMode: true,
      ),
    );
    _controller.listen(videoControllerListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("playing.....");
      _isVideoPlaying = true;
      _controller.playVideo();
    });
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

    if (event.playerState == PlayerState.cued) {
      // event.playerState == PlayerState.playing
      if (_isVideoPlaying && !(event.playerState == PlayerState.ended)) {
        _controller.playVideo();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: [
              Builder(
                builder: (context) {
                  if (globalVideoEvent == null ||
                      playerLoadingState
                          .contains(globalVideoEvent.playerState)) {
                    return Center(
                        child: SpinKitFadingCircle(
                      color: Colors.white,
                    ));
                  } else
                    return Container();
                },
              ),
              YoutubePlayer(
                controller: _controller,
                aspectRatio: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height,
                gestureRecognizers: {},
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}


          
          // FacebookVideoPlayer(
          // src:
          //     'https://www.youtube.com/embed/rUWxSEwctFU?mute=1&modestbranding=0&autoplay=1&autohide=1&rel=1&showinfo=1&controls=1&disablekb=1&enablejsapi=1&iv_load_policy=3&loop=1&playsinline=0&fs=0&allowfullscreen=true&frameborder=0&allow=autoplay',
          // src: 'https://www.youtube.com/watch?v=rq8ikMZSPDU',