// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/enum/shareMethod.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/screens/widgets/linkify/linkify.dart';
import 'package:online_panchayat_flutter/services/dynamicLinksService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/shareService.dart';

import 'PostData.dart';

class SharePost {
  PostWithTags post;
  PostData postData;
  dynamic shareURL;
  ShareService _shareService;

  SharePost({@required this.postData}) {
    post = postData.post;
    _shareService = ShareService();
    getShareLink().then((value) {
      // print("got share link ");
      shareURL = value;
    });
  }

  Future<dynamic> getShareLink() async {
    if (post.shareURL != null) {
      return post.shareURL;
    }
    dynamic dynamicLink = await getDynamicLink();
    updateShareLink(dynamicLink);
    return dynamicLink;
  }

  Future<dynamic> getDynamicLink() {
    return DynamicLinkService.generatePostSpecificShortDynamicLink(
      postId: post.id,
      postThumbnail: post.imageURL ?? APP_ICON_URL,
      postDescription: postContentWithLinksRemoved(post.content),
    );
  }

  Future<void> updateShareLink(dynamic link) async {
    await Services.gqlMutationService.updatePost
        .updatePostShareURL(postData: postData, shareURL: link.toString());
  }

  Future<void> onShareButtonPressed({@required ShareMethod shareMethod}) async {
    await _shareService.shareOnSocialMedia(
      postId: post.id,
      completeUrl: shareURL ?? await getDynamicLink(),
      postContent: postContentWithLinksRemoved(post.content),
      shareMethod: shareMethod,
    );
  }

  String postContentWithLinksRemoved(String text) {
    String content = "";
    for (var element in linkify(text)) {
      if (element is TextElement) content += element.text;
    }
    return content;
  }
}






//










//
  // Future<String> getThumbnailFromContent(CommunityPost post) async {
  //   String url;

  //   for (var element in linkify(post.content)) {
  //     if (element is LinkableElement) {
  //       url = await GetMetaData().getImageUrl(element.url);

  //       if (url != 'NoImage') break;
  //     }
  //   }

  //   if (url == 'NoImage') url = APP_ICON_URL;

  //   return url;
  // }
  // Future<String> replaceLinksWithTitle(dynamic post) async {
  //   String content = "";

  //   for (var element in linkify(post.content)) {
  //     if (element is LinkableElement) {
  //       content += await GetMetaData().getTitleFromLink(element.url);
  //     } else
  //       content += element.text;
  //   }

  //   return content;
  // }

