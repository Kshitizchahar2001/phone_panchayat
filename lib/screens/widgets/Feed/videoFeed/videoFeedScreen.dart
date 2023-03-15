// ignore_for_file: file_names, overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/Widgets/videoFrame.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({Key key}) : super(key: key);

  @override
  _VideoFeedScreenState createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  GlobalDataNotifier _globalDataNotifier;
  // ignore: unused_field
  Feed _feed;

  int quarterTurns = 1;

  @override
  void initState() {
    _globalDataNotifier = Provider.of(context, listen: false);
    _feed = _globalDataNotifier.videosFeed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Scaffold(
    //   body: ChangeNotifierProvider.value(
    //     value: _feed,
    //     builder: (context, child) {
    //       return Consumer<Feed>(
    //         builder: (context, value, child) {
    //           if (_feed.currentPageIndex.value >=
    //               _feed.latestListOfPostId().length) {
    //             if (_feed.hasMoreData) {
    //               _feed.addMorePosts();
    //               return LoadingMorePosts();
    //             } else {
    //               return Center(
    //                 child: Text("No more videos to show",
    //                     style: Theme.of(context).textTheme.headline1.copyWith(
    //                             fontSize: responsiveFontSize(
    //                           context,
    //                           size: ResponsiveFontSizes.s10,
    //                         ))),
    //               );
    //             }
    //           } else
    //             return ValueListenableBuilder<int>(
    //               valueListenable: _feed.currentPageIndex,
    //               builder: (context, value, child) {
    //                 print("current index is $value");
    //                 return ChangeNotifierProvider<PostData>.value(
    //                   value: _globalDataNotifier.postReservoir[_feed
    //                       .latestListOfPostId()[_feed.currentPageIndex.value]],
    //                   builder: (context, child) {
    //                     return Consumer<PostData>(
    //                       builder: (context, value, child) {
    //                         return RotatedBox(
    //                           quarterTurns: quarterTurns,
    //                           child: Stack(
    //                             children: [
    //                               Center(
    //                                 child: Builder(
    //                                   builder: (context) {
    //                                     if (value.videoUrlsTypeMap[
    //                                             value.videoURL] ==
    //                                         VideoUrlType.Youtube) {
    //                                       return VideoFeedVideoFrame(
    //                                         _feed,
    //                                         url: value.videoURL,
    //                                         index: _feed.currentPageIndex.value,
    //                                         key: ValueKey(
    //                                           "${value.post.id} ${value.videoURL}",
    //                                         ),
    //                                         pageIndex: _feed.currentPageIndex,
    //                                       );
    //                                       //;
    //                                     } else if (value.videoUrlsTypeMap[
    //                                             value.videoURL] ==
    //                                         VideoUrlType.Facebook) {
    //                                       return FacebookVideoPlayer(
    //                                           src: value.videoURL);
    //                                     } else
    //                                       return VideoFeedBetterPlayer(
    //                                         cacheVideoSource: value
    //                                             .videoSourceMap[value.videoURL],
    //                                         key: ValueKey(
    //                                           "${value.post.id} ${value.videoURL}",
    //                                         ),
    //                                         index: _feed.currentPageIndex.value,
    //                                         feed: _feed,
    //                                       );
    //                                   },
    //                                 ),
    //                               ),
    //                               Positioned(
    //                                 right: 20,
    //                                 top: 20,
    //                                 child: IconButton(
    //                                   onPressed: () {
    //                                     setState(() {
    //                                       quarterTurns =
    //                                           quarterTurns == 1 ? 0 : 1;
    //                                     });
    //                                   },
    //                                   icon: Container(
    //                                     decoration: BoxDecoration(
    //                                       shape: BoxShape.circle,
    //                                       color: Theme.of(context).cardColor,
    //                                     ),
    //                                     child: Padding(
    //                                       padding: const EdgeInsets.all(4.0),
    //                                       child: Icon(
    //                                         Icons.fullscreen,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         );
    //                       },
    //                     );
    //                   },
    //                 );
    //               },
    //             );
    //         },
    //       );
    //     },
    //   ),
    // );
  }
}

// class VideoFeedBetterPlayer extends BetterPlayerFrame2 {
//   final Feed feed;
//   VideoFeedBetterPlayer({
//     Key key,
//     CacheVideoSource cacheVideoSource,
//     int index,
//     @required this.feed,
//   }) : super(
//           cacheVideoSource: cacheVideoSource,
//           index: index,
//           key: key,
//           betterPlayerConfiguration: BetterPlayerConfiguration(
//             controlsConfiguration:
//                 BetterPlayerControlsConfiguration(enableFullscreen: false),
//             fit: BoxFit.contain,
//           ),
//         );

//   @override
//   additonalEventListener(BetterPlayerEvent event) {
//     if (event.betterPlayerEventType == BetterPlayerEventType.finished)
//       nextVideo();
//   }

//   @override
//   skipToNextVideo() => nextVideo();

//   nextVideo() {
//     // feed.currentPageIndex.value = feed.currentPageIndex.value + 1;
//     // if (feed.currentPageIndex.value >= feed.listOfPostId.length)
//     //   feed.notifyFeedListeners();
//   }
// }

class VideoFeedVideoFrame extends VideoFrame {
  final Feed feed;

  final String url;
  final int index;
  final ValueNotifier<int> pageIndex;

  const VideoFeedVideoFrame(
    this.feed, {
    Key key,
    @required this.url,
    @required this.index,
    @required this.pageIndex,
  }) : super(
          url: url,
          index: index,
          pageIndex: pageIndex,
          key: key,
          feed: feed,
        );

  @override
  additonalEventListener(YoutubePlayerValue event) {
    if (event.playerState == PlayerState.ended) {
      nextVideo();
    }
  }

  @override
  skipToNextVideo() => nextVideo();

  nextVideo() {
    // feed.currentPageIndex.value = feed.currentPageIndex.value + 1;
    // if (feed.currentPageIndex.value >= feed.listOfPostId.length)
    //   feed.notifyFeedListeners();
  }
}
