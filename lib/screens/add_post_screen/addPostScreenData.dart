// ignore_for_file: file_names, prefer_is_empty, curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls, prefer_is_not_empty, unnecessary_this

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/firestoreModels/postTag.dart';
import 'package:online_panchayat_flutter/models/PostCategory.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/mediaUploadData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createNewPostWithTags.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/thumb_nail.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'Media/data/imageData.dart';
import 'Media/data/videoData.dart';
import 'add_post_screen_utilities.dart';
import 'widgets/postOperationStatusDialog.dart';

class AddPostScreenData extends ChangeNotifier {
  MediaUploadData image;
  MediaUploadData video;
  List<MediaUploadData> images = <MediaUploadData>[];

  ValueNotifier<bool> isPostButtonEnabled;
  final TextEditingController controller;
  static GlobalDataNotifier globalDataNotifier;

  String postId;
  int expectedVersion;

  /// postData of post which is being edited;
  /// incase of new post creation, postData will be null
  PostData postData;
  PostTag postTag;

  AddPostScreenData({
    @required this.controller,
  }) {
    if (controller == null) return;
    image = ImageData()..isThumbnailImage = true;
    video = VideoData(imageUploadData: image);
    isPostButtonEnabled = ValueNotifier<bool>(false);
    controller.addListener(() {
      if ((controller.text == null || controller.text.trim().length == 0) &&
          (!image.mediaAvailable.value && !video.mediaAvailable.value))
        disablePostButton();
      else if (controller.text.trim().length >= 1 && !isPostButtonEnabled.value)
        enablePostButton();
    });
  }

  void initialise(PostData postData) {
    this.postData = postData;
    controller.text = postData.post.content;
    postData.imageList.forEach((element) {
      if (!element.isEmpty &&
          element != null &&
          element != postData.post.imageURL) {
        ImageData imageData = ImageData();
        imageData.mediaAvailable.value = true;
        imageData.url = element;
        images.add(imageData);
      }
    });
    image.url = postData.post.imageURL;
    image.mediaAvailable.value = (image.url != null && image.url != "");

    video.url = postData.post.videoURL;
    video.mediaAvailable.value = (video.url != null && video.url != "");
    postId = postData.post.id;
    expectedVersion = postData.version;
  }

  insertImage(File file) {
    if (image.mediaAvailable.value == true)
      images.add(ImageData()..setPickedFile(file));
    else
      image.setPickedFile(file);
    notifyListeners();
    enablePostButton();
  }

  insertVideo(File file) {
    video.setPickedFile(file);
    enablePostButton();
  }

  enablePostButton() {
    isPostButtonEnabled.value = true;
  }

  disablePostButton() {
    isPostButtonEnabled.value = false;
  }

  bool _isAnyImageUploadInProgress() {
    bool flag = false;
    for (MediaUploadData imageData in images) {
      if (imageData.uploadInProgress.value == true) {
        flag = true;
        break;
      }
    }
    return flag;
  }

  bool _isAtleastOneImageAttached() {
    bool flag = false;
    if (image.mediaAvailable.value == true) flag = true;
    for (MediaUploadData imageData in images) {
      if (imageData.mediaAvailable.value == true) {
        flag = true;
        break;
      }
    }
    return flag;
  }

  Future<void> _addImageFromLink() async {
    List<String> urls = AddPostScreenUtilities.fetchLinksFromContent(
        controller.text,
        fetchAllLinks: true);
    if (urls.length > 0) {
      String requiredUrl = urls[0];
      String _imgUrl = await GetMetaData().getImageUrl(requiredUrl);
      if (_imgUrl != "NoImage") {
        image.url = _imgUrl;
        image.mediaAvailable.value = true;
        notifyListeners();
      }
    }
  }

  Future<void> _addUrlTitleInPostDescription() async {
    controller.text = controller.text.trim();
    if (AddPostScreenUtilities.containsTextElement(controller.text)) return;
    //else add title to desription
    List<String> allUrls = AddPostScreenUtilities.fetchLinksFromContent(
        controller.text,
        fetchAllLinks: true);
    if (allUrls.length > 0) {
      String text = await GetMetaData().getTitleFromLink(allUrls[0]);
      controller.text = text + " " + controller.text;
    }
  }

  Future<bool> _createPost() async {
    User user = Services.globalDataNotifier.localUser;
    List<String> imagesList =
        AddPostScreenUtilities.getImageUrlsListFromMediaUploadDataList(images);

    CreatePostQueryResponse createPostQueryResponse =
        await Services.gqlMutationService.createNewPostWithTags
            .createNewPostWithTags(
      videoURL: video.url,
      imageURL: AddPostScreenUtilities.getImageUrlFromMediaUploadData(
          imagesList, image),
      imageUrlsList: imagesList,
      content: controller.text,
      location:
          Services.locationNotifier.currentLocation ?? user.homeAdressLocation,
      userId: user.id,
      noOfViews: 0,
      noOfLikes: 0,
      postCategory: PostCategory.PUBLIC,
      tag: <String>[globalDataNotifier.localUser?.tag],
      hashTag: postTag != null ? "${postTag.en.toString()}_${user.tag}" : null,
    )
            .whenComplete(() {
      AnalyticsService.firebaseAnalytics
          .logEvent(name: "post_created", parameters: {
        "user_id": user.id,
        "tag": user.tag,
      });
    });

    return createPostQueryResponse.success;
  }

  Future<bool> _updatePost() async {
    List<String> imagesList =
        AddPostScreenUtilities.getImageUrlsListFromMediaUploadDataList(images);

    return await Services.gqlMutationService.updatePost.updatePostWithTags(
      id: postId,
      content: controller.text,
      imageURL: AddPostScreenUtilities.getImageUrlFromMediaUploadData(
        imagesList,
        image,
      ),
      imageUrlsList: imagesList,
      videoURL: video.url,
      expectedVersion: expectedVersion,
      postData: this.postData,
    );
  }

  Future<void> onPostButtonPressed(BuildContext context) async {
    if (controller.text.length == 0 &&
        !_isAtleastOneImageAttached() &&
        !video.mediaAvailable.value) {
      AddPostScreenUtilities.showSnackBar(
          context, "कृपया लिखें या फिर फोटो/वीडियो जोड़ें");
      return;
    }
    if (_isAnyImageUploadInProgress()) {
      AddPostScreenUtilities.showSnackBar(context, "Image upload in progress!");
      return;
    }
    if (video.uploadInProgress.value) {
      AddPostScreenUtilities.showSnackBar(context, "Video upload in progress!");
      return;
    }

    showMaterialDialog(context);

    if (!_isAtleastOneImageAttached()) {
      await _addImageFromLink();
    }
    await _addUrlTitleInPostDescription();

    bool wasOperationSuccessful;

    if (postId == null)
      wasOperationSuccessful = await _createPost().whenComplete(() {
        if (postTag != null) Navigator.pop(context);
      });
    else
      wasOperationSuccessful = await _updatePost();

    Navigator.pop(context);
    Navigator.pop(context);

    globalDataNotifier.homeFeed.refreshData();

    showDialog(
      context: context,
      builder: (_) => PostCreationStatusDialog(
        wasOperationSuccessful: wasOperationSuccessful,
        postId: postId,
      ),
    );
  }
}
