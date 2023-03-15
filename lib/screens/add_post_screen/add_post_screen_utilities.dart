// ignore_for_file: prefer_is_empty, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/mediaUploadData.dart';
import 'package:online_panchayat_flutter/screens/widgets/linkify/linkify.dart';
import 'package:youtube_parser/youtube_parser.dart';

class AddPostScreenUtilities {
  static showSnackBar(BuildContext context, String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text.toString()),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String getImageUrlFromMediaUploadData(
      List<String> images, MediaUploadData image) {
    if (image.url != null && image.url != '') return image.url;
    if (images != null && images.length > 0) {
      return images[0];
    }
    return null;
  }

  static List<String> getImageUrlsListFromMediaUploadDataList(
      List<MediaUploadData> images) {
    List<String> list = <String>[];

    images.forEach((element) {
      if (element.mediaAvailable.value == true &&
          element.url != null &&
          element.url != "") {
        list.add(element.url);
      }
    });

    return list;
  }

  static bool containsTextElement(String text) {
    bool hasText = false;
    linkify(
      text,
    ).forEach((element) {
      if (element is TextElement) hasText = true;
    });
    return hasText;
  }

  static bool isYoutubeLink(String url) {
    String youtubeVideoId = getIdFromUrl(url);
    if (youtubeVideoId == null) return false;
    return true;
  }

  static List<String> fetchLinksFromContent(String text,
      {bool fetchAllLinks = false}) {
    List<String> links = <String>[];
    linkify(
      text,
    ).forEach((element) {
      if (element is LinkableElement) {
        if (fetchAllLinks)
          links.add(element.url);
        else if (!AddPostScreenUtilities.isYoutubeLink(element.url))
          links.add(element.url);
      }
    });
    return links;
  }
}
