// ignore_for_file: file_names, prefer_collection_literals, prefer_is_empty, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/enum/videoUrlType.dart';
import 'package:online_panchayat_flutter/models/GetReaction.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostMedia/contentPost.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostMedia/facebookVideoPost.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostMedia/imagePost.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostMedia/postMedia.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostMedia/uploadedVideoPost.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostMedia/youtubeVideoPost.dart';
import 'package:online_panchayat_flutter/screens/widgets/linkify/linkify.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:youtube_parser/youtube_parser.dart';
import 'animateButtons.dart';
import 'cacheVideoSource.dart';
import 'sharePost.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class PostDataInitialisation extends ChangeNotifier {
  PostWithTags post;
  GetReaction getReaction;
  Status myLikeStatus;
  int numberOfLikes;
  int mediaItemsCount = 0;
  List<String> imageList = <String>[];
  DateTime postCreationDateTime;
  int version;
  AnimateButtons animateButtons;
  int noOfViews;

  List<LinkifyElement> postContentTextElements = <LinkifyElement>[];
  List<LinkifyElement> postContentLinkElements = <LinkifyElement>[];
  bool showSeeMore = false;
  int maximumNumberOfLinkifyElementsInFeedPage = 0;

  String videoURL;
  SharePost sharePost;
  // List<String> videoUrls = <String>[];

  List<Comment> commentList = <Comment>[];
  bool hasMoreComment = true;

  Map<String, VideoUrlType> videoUrlsTypeMap = Map<String, VideoUrlType>();
  Map<String, CacheVideoSource> videoSourceMap =
      Map<String, CacheVideoSource>();

  PostMedia postMedia;

  PostDataInitialisation({
    @required this.post,
    @required this.version,
  }) {
    if (post != null) initialiseAllPostData();
  }
  initialiseAllPostData() {
    sharePost = SharePost(postData: this);
    initialiseNumberOfViews();
    initialiseDateTime();
    assignImage();
    checkIfThisPostIsLikedByUser();
    initialiseNumberOfLikes();
    initialiseVideoUrl();
    initialiseMediaItemsCount();
    initialisePostMedia();
    initializePostContentElementsAndSeeMore();
    refreshComment();
    animateButtons = AnimateButtons();
  }

  initialiseNumberOfViews() {
    noOfViews = post.noOfViews;
    noOfViews = noOfViews * getViewsMultiplicationFactor();
  }

  int getViewsMultiplicationFactor() {
    int factor = 1;
    try {
      factor = RemoteConfigService
          .global_information["views_multiplication_factor"] as int;
    } catch (e, s) {
      String errorMessage =
          "Error getting view multiplication factor from remote confif in post data : $e";
      FirebaseCrashlytics.instance.recordError(errorMessage, s);
      factor = 1;
    }
    return factor;
  }

  initialiseDateTime() {
    postCreationDateTime = post.createdAt.getDateTimeInUtc();
  }

  assignImage() {
    String image;
    if (post.imageURL != null && post.imageURL != "") image = post.imageURL;
    imageList = post.imageUrlsList ?? <String>[];
    if (image != null) {
      if (imageList.contains(image)) {
        int indexOfImage = imageList.indexOf(image);
        String temp = imageList[0];
        imageList[0] = imageList[indexOfImage];
        imageList[indexOfImage] = temp;
      } else {
        imageList.insert(0, image);
      }
    }
  }

  String getFirstImage() {
    if (imageList != null && imageList.length > 0) {
      String firstImageUrl = imageList[0];
      if (firstImageUrl.isNotEmpty) return firstImageUrl;
    }
    return null;
  }

  checkIfThisPostIsLikedByUser() async {
    getReaction = await Services.gqlQueryService.getReactions.getReactions(
        postId: post.id,
        reactionType: ReactionTypes.LIKE,
        userId: Services.globalDataNotifier.localUser.id);
    if (getReaction != null && getReaction.status != myLikeStatus) {
      myLikeStatus = getReaction.status;
      notifyListeners();
      if (myLikeStatus == Status.ACTIVE) {
        animateButtons.onLikeButtonPressed(logLikeEvent: false);
      }
    }
  }

  initialiseNumberOfLikes() {
    numberOfLikes = post.noOfLikes;
  }

  initialiseVideoUrl() {
    if (post.videoURL != null &&
        post.videoURL != "" &&
        post.videoURL.toString().contains('facebook')) {
      videoURL = post.videoURL;
      videoUrlsTypeMap[post.videoURL] = VideoUrlType.Facebook;
    } else if (assingYoutubeLinkToVideoUrl()) {
    } else if (post.videoURL != null && post.videoURL != "") {
      videoURL = post.videoURL;
      videoUrlsTypeMap[post.videoURL] = VideoUrlType.Storage;
      assignVideoDataSource();
    }
  }

  assignVideoDataSource();

  initialiseMediaItemsCount() {
    mediaItemsCount = 0;
    if ((imageList?.length ?? -1) > 0) mediaItemsCount++;
    if (videoURL != null) mediaItemsCount++;
  }

  initialisePostMedia() {
    if (videoURL != null) {
      if (videoUrlsTypeMap[videoURL] == VideoUrlType.Youtube) {
        postMedia = YoutubeVideoPost(postData: this);
      } else if (videoUrlsTypeMap[videoURL] == VideoUrlType.Facebook) {
        postMedia = FacebookVideoPost(postData: this);
      } else {
        postMedia = UploadedVideoPost(postData: this);
      }
    } else if ((imageList?.length ?? -1) > 0) {
      postMedia = ImagePost(postData: this);
    } else {
      postMedia = ContentPost(postData: this);
    }
  }

  int minimumTextLength;
  int maximumTextLength;
  initializePostContentElementsAndSeeMore() {
    if (post.content == null || post.content == "") {
      showSeeMore = false;
      return;
    }

    linkify(post.content, options: LinkifyOptions(humanize: false))
        .forEach((element) {
      if (element is TextElement) {
        postContentTextElements.add(element);
      } else if (element is LinkableElement) {
        postContentLinkElements.add(element);
      }
    });

    if (mediaItemsCount == 0) {
      minimumTextLength = 310;
      maximumTextLength = 330;
    } else {
      minimumTextLength = 110;
      maximumTextLength = 130;
    }
    initSeeMoreAndMaxLinkifyElements(minimumTextLength, maximumTextLength);
  }

  initSeeMoreAndMaxLinkifyElements(minimumTextLength, maximumTextLength) {
    int textLength = 0;
    postContentTextElements.forEach((element) {
      if (textLength < minimumTextLength) {
        textLength += element.text.length;
        maximumNumberOfLinkifyElementsInFeedPage++;
      } else if (textLength >= minimumTextLength &&
          textLength < maximumTextLength &&
          (element.text.length <= maximumTextLength - textLength)) {
        textLength += element.text.length;
        maximumNumberOfLinkifyElementsInFeedPage++;
      } else {
        if (!showSeeMore) showSeeMore = true;
      }
    });
  }

  refreshComment();
  updateList();
  /*

  Assign video Player data
  */

  List<String> fetchYoutubeLinksFromContent() {
    List<String> links;
    links = [];
    linkify(
      post.content,
    ).forEach((element) {
      if (element is LinkableElement) {
        if (isThisAYoutubeLink(element.url)) links.add(element.url);
      }
    });
    return links;
  }

  bool isThisAYoutubeLink(String url) {
    String youtubeVideoId = getIdFromUrl(url);
    if (youtubeVideoId == null) return false;
    return true;
  }

  void clearVideoData();
  bool assingYoutubeLinkToVideoUrl();
}
