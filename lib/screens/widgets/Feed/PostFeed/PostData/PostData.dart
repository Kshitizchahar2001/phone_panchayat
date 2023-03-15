// ignore_for_file: file_names, curly_braces_in_flow_control_structures, avoid_print, prefer_collection_literals, unnecessary_this

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/enum/videoUrlType.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/models/ReactionTypes.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'cacheVideoSource.dart';
import 'commentData.dart';

class PostData extends CommentData {
  PostData({
    @required PostWithTags post,
    @required int version,
  }) : super(post: post, version: version);

  void onLikeButtonPressed() {
    if (myLikeStatus == null) {
      myLikeStatus = Status.ACTIVE;
      Services.gqlMutationService.createReaction
          .createReaction(
              postId: post.id,
              userId: Services.globalDataNotifier.localUser.id,
              status: Status.ACTIVE,
              reactionType: ReactionTypes.LIKE,
              postDataWithReaction: this)
          .then((value) {
        AnalyticsService.firebaseAnalytics
            .logEvent(name: "like_created", parameters: {
          "post_id": post.id,
        });
      });
    } else {
      toggleLikeStatus();
      Services.gqlMutationService.updateReaction.updateReactions(
          postId: post.id,
          userId: Services.globalDataNotifier.localUser.id,
          status: myLikeStatus,
          postData: this);
    }
    changeLikesCount();
    notifyListeners();
  }

  changeLikesCount() {
    if (myLikeStatus == Status.ACTIVE)
      numberOfLikes += 1;
    else
      numberOfLikes -= 1;
  }

  toggleLikeStatus() {
    if (myLikeStatus == Status.ACTIVE) {
      myLikeStatus = Status.INACTIVE;
    } else {
      myLikeStatus = Status.ACTIVE;
    }
  }

  createView() {
    Services.gqlMutationService.createView.createView(
        postId: post.id, userId: Services.globalDataNotifier.localUser.id);
  }

  onYoutubeLinkExpire() {
    print("onYoutubeLinkExpire() called");
    // updateVideoUrlWithNewYoutubeLink();
  }

  // updateVideoUrlWithNewYoutubeLink() {
  //   clearVideoData();
  //   assingYoutubeLinkToVideoUrl();
  //   assignVideoDataSource();
  //   notifyListeners();
  // }

  @override
  clearVideoData() {
    videoUrlsTypeMap = Map<String, VideoUrlType>();
    videoSourceMap = Map<String, CacheVideoSource>();
  }

  @override
  bool assingYoutubeLinkToVideoUrl() {
    bool youtubeLinkAssigned;
    try {
      String element = fetchYoutubeLinksFromContent().first;
      videoURL = element;
      videoUrlsTypeMap[element] = VideoUrlType.Youtube;
      youtubeLinkAssigned = true;
      // print("youtube link found");
    } catch (e) {
      youtubeLinkAssigned = false;
      // print("no youtube links found in content");
    }
    return youtubeLinkAssigned;
  }

  @override
  assignVideoDataSource() {
    videoUrlsTypeMap.forEach((key, value) {
      videoSourceMap[key] = CacheVideoSource(
        url: key,
        videoUrlType: value,
        updatePostVideoUrl: updatePostVideoUrl,
      );
    });
  }

  bool videoUrlContainsYoutubeVideoDownloadLink() {
    // ignore: todo
    // TODO
    return true;
  }

  Future<void> updatePostVideoUrl(String newVideoUrl) async {
    this.videoURL = newVideoUrl;
    clearVideoData();
    videoUrlsTypeMap[this.videoURL] = VideoUrlType.Storage;
    assignVideoDataSource();

    await Services.gqlMutationService.updatePost
        .updatePostVideoUrl(postData: this);
  }

  bool isPostOwnedByLoggedInUserOrAdministrator() {
    String loggedInUserId = Services.globalDataNotifier.localUser.id;
    List postModerators;
    try {
      postModerators = RemoteConfigService.global_information["moderatorsList"];
    } catch (e, s) {
      String errorMessage =
          "Error getting list of moderators from remote config in post card widget : $e";
      print(errorMessage);
      FirebaseCrashlytics.instance.recordError(errorMessage, s);

      postModerators = ["+918949982614", "+918744886627"];
    }

    String postOwnerId = this.post?.user?.id;

    if (postModerators.contains(loggedInUserId)) return true;
    if (postOwnerId == null) return false;
    if (loggedInUserId == postOwnerId) return true;

    return false;
  }
}
