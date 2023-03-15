// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

import 'feed.dart';

abstract class SinglePageFeed extends Feed {
  SinglePageFeed() {
    numberOfPostsToFetch = 1;
  }
  @override
  int getItemCount() => 1;

  @override
  void showSinglePost(BuildContext context, String postId) {}
}
