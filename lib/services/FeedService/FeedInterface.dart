// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';

abstract class FeedInterface {
  int getItemCount();
  Future<void> addMorePosts();
  Future<FeedQueryData> getPosts();
  Future<void> renewPostsListData();
  List<String> latestListOfPostId();
  bool isUpdatePostInProgress();
  void showSinglePost(BuildContext context, String postId);
  void scrollToTop();
}
