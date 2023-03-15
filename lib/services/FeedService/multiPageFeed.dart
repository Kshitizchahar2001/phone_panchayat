// ignore_for_file: file_names, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'feed.dart';
import 'package:velocity_x/velocity_x.dart';

abstract class MultiPageFeed extends Feed {
  MultiPageFeed() {
    numberOfPostsToFetch = 20;
  }

  @override
  void showSinglePost(BuildContext context, String postId) {
    context.vxNav.push(Uri.parse(MyRoutes.singlePostViewMainScreenRoute),
        params: postId);
  }

  @override
  int getItemCount() {
    int _itemCount = 0;
    if (latestListOfPostId() != null)
      _itemCount = latestListOfPostId().length + 1;
    return _itemCount;
  }
}
