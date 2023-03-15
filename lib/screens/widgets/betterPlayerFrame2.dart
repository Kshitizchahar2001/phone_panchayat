// ignore_for_file: file_names, prefer_const_constructors_in_immutables, annotate_overrides, unnecessary_this, avoid_print, curly_braces_in_flow_control_structures, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:online_panchayat_flutter/screens/loading.dart';

import 'Feed/PostFeed/PostData/PostData.dart';
import 'Feed/PostFeed/PostData/cacheVideoSource.dart';

class BetterPlayerFrame2 extends StatefulWidget
    implements BetterPlayerInterface {
  final CacheVideoSource cacheVideoSource;
  final BetterPlayerConfiguration betterPlayerConfiguration;
  final PostData postData;
  BetterPlayerFrame2({
    Key key,
    @required this.cacheVideoSource,
    @required this.betterPlayerConfiguration,
    @required this.postData,
  }) : super(key: key);

  @override
  _BetterPlayerFrame2State createState() => _BetterPlayerFrame2State();

  additonalEventListener(BetterPlayerEvent event) {}

  @override
  skipToNextVideo() {}
}

class _BetterPlayerFrame2State extends State<BetterPlayerFrame2> {
  BetterPlayerController betterPlayerController;
  BetterPlayerDataSource betterPlayerDataSource;
  Future<void> futureBetterPlayerController;

  @override
  void initState() {
    futureBetterPlayerController = initialiseBetterPlayerController();
    super.initState();
  }

  Future<void> initialiseBetterPlayerController() async {
    if (widget.cacheVideoSource.betterPlayerDataSource != null) {
      this.betterPlayerDataSource =
          widget.cacheVideoSource.betterPlayerDataSource;
    } else {
      this.betterPlayerDataSource =
          await widget.cacheVideoSource.futureBetterPlayerDataSource;
    }
    initialiseControllerWithDataSource();
    if (betterPlayerController == null) return;
    betterPlayerController?.addEventsListener(eventListener);
    manageVideoStatus();
  }

  void eventListener(BetterPlayerEvent event) {
    widget.additonalEventListener(event);
    if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
      betterPlayerController.removeEventsListener(eventListener);
      print(event.parameters.toString());
      // betterPlayerController.pause();
      print("this is a exception url was ${betterPlayerDataSource.url}");
      if (widget.postData.videoUrlContainsYoutubeVideoDownloadLink()) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          widget.postData.onYoutubeLinkExpire();
        });
      }
    }
  }

  initialiseControllerWithDataSource() {
    if (this.betterPlayerDataSource != null)
      this.betterPlayerController = BetterPlayerController(
          widget.betterPlayerConfiguration,
          betterPlayerDataSource: betterPlayerDataSource);
  }

  manageVideoStatus() {
    if (!betterPlayerController.isPlaying()) betterPlayerController.play();
  }

  @override
  void dispose() {
    betterPlayerController?.removeEventsListener(eventListener);
    betterPlayerController?.pause();
    betterPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return FutureBuilder<void>(
          future: futureBetterPlayerController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Loading();
            else if (betterPlayerController != null) {
              return BetterPlayer(
                controller: betterPlayerController,
              );
            } else {
              return Builder(
                builder: (context) {
                  widget.skipToNextVideo();
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "This video cannot be played",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}

abstract class BetterPlayerInterface {
  additonalEventListener(BetterPlayerEvent event);
  skipToNextVideo();
}
