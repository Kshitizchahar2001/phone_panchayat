// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/postDataInitialisation.dart';
import 'package:online_panchayat_flutter/services/services.dart';

abstract class CommentData extends PostDataInitialisation {
  CommentData({
    @required PostWithTags post,
    @required int version,
  }) : super(
          post: post,
          version: version,
        );

  String nextToken;
  @override
  refreshComment() async {
    commentList = [];
    nextToken = null;
    await Services.gqlQueryService.getCommentsByPostId
        .getCommentsByPostId(
            postId: post.id, numberOfCommentsTofetch: 10, nextToken: nextToken)
        .then((value) {
      nextToken = value.nextToken;
      commentList = value.list;
    });
    hasMoreComment = commentList.length < 10 ? false : true;
    notifyListeners();
  }

  @override
  updateList() async {
    await Services.gqlQueryService.getCommentsByPostId
        .getCommentsByPostId(
            postId: post.id, numberOfCommentsTofetch: 10, nextToken: nextToken)
        .then((value) {
      nextToken = value.nextToken;
      for (int i = 0; i < value.list.length; i++) {
        commentList.add(value.list[i]);
      }
    });
    hasMoreComment = commentList.length % 10 == 0 ? true : false;
    notifyListeners();
  }
}
