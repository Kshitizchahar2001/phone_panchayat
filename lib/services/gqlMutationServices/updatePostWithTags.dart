// ignore_for_file: file_names, constant_identifier_names, avoid_print, curly_braces_in_flow_control_structures, prefer_conditional_assignment

import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/PostCategory.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;

class UpdatePost {
  static const String UPDATE_POST_OPERATION_NAME = 'UpdatePostWithTags';
  final updatePostMutationDocument =
      '''mutation UpdatePostWithTags(\$content: String, \$createdAt: AWSDateTime, \$expectedVersion: Int!, \$id: ID!, \$imageURL: String, \$status: Status, \$updatedAt: AWSDateTime, \$videoURL: String, \$postCategory: PostCategory, \$shareURL: String, \$imageUrlsList: [String]) {
  updatePostWithTags(input: {content: \$content, createdAt: \$createdAt, expectedVersion: \$expectedVersion, id: \$id, imageURL: \$imageURL, status: \$status, updatedAt: \$updatedAt, videoURL: \$videoURL,postCategory:\$postCategory, shareURL: \$shareURL, imageUrlsList: \$imageUrlsList}) {
    content
    status
    version
  }
}

''';

  updatePostShareURL({
    @required PostData postData,
    @required String shareURL,
  }) async {
    try {
      http.Response response = await RunQuery.runQuery(
          operationName: UPDATE_POST_OPERATION_NAME,
          mutationDocument: updatePostMutationDocument,
          variables: {
            'id': postData.post.id,
            'expectedVersion': postData.version,
            'shareURL': shareURL,
            'updatedAt': postData.post.updatedAt.toString(),
            'postCategory':
                getPostCategory(postData).toString().split(".").last,
          });
      var body = jsonDecode(response.body);
      print("Post update complete " + body.toString());
      if (body['data']['updatePostWithTags'] == null)
        throw Exception([
          "post update failed",
        ]);
      postData.version = body['data']['updatePostWithTags']['version'];
      // print("new version is ${postData.getReaction.version}");
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  updatePostVideoUrl({
    @required PostData postData,
  }) async {
    try {
      http.Response response = await RunQuery.runQuery(
          operationName: UPDATE_POST_OPERATION_NAME,
          mutationDocument: updatePostMutationDocument,
          variables: {
            'id': postData.post.id,
            'expectedVersion': postData.version,
            'videoURL': postData.videoURL,
            'updatedAt': postData.post.updatedAt.toString(),
            'postCategory':
                getPostCategory(postData).toString().split(".").last,
          });
      var body = jsonDecode(response.body);
      print("Post update complete " + body.toString());
      if (body['data']['updatePostWithTags'] == null)
        throw Exception([
          "post update failed",
        ]);
      postData.version = body['data']['updatePostWithTags']['version'];
      // print("new version is ${postData.getReaction.version}");
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  PostCategory getPostCategory(PostData postData) {
    PostCategory postCategory = (postData.post).postCategory;
    if (postCategory == null) postCategory = PostCategory.PUBLIC;
    return postCategory;
  }

  Future<bool> updatePostWithTags({
    @required String id,
    @required int expectedVersion,
    @required String content,
    @required String imageURL,
    @required String videoURL,
    @required PostData postData,
    @required List<String> imageUrlsList,
  }) async {
    bool wasPostCreationSuccessful = true;
    http.Response response;

    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_POST_OPERATION_NAME,
          mutationDocument: updatePostMutationDocument,
          variables: {
            'id': id,
            'expectedVersion': expectedVersion,
            'content': content,
            'videoURL': videoURL,
            'imageURL': imageURL,
            'imageUrlsList': imageUrlsList,
            'status': Status.ACTIVE.toString().split('.').last,
            'updatedAt': postData.post.updatedAt.toString(),
            'postCategory':
                getPostCategory(postData).toString().split(".").last,

            // 'updatedAt': postData.post.updatedAt.toString(),
          });
      var body = jsonDecode(response.body);
      print("Post update complete " + body.toString());
      if (body['data']['updatePostWithTags'] == null)
        throw Exception([
          "post update failed",
        ]);
      postData.version = body['data']['updatePostWithTags']['version'];
      // print("new version is ${postData.getReaction.version}");
    } catch (e, s) {
      wasPostCreationSuccessful = false;
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }

    return wasPostCreationSuccessful && response.statusCode == 200;
  }

  Future<bool> deletePost({
    @required PostData postData,
  }) async {
    bool wasPostDeletionSuccessful = true;
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_POST_OPERATION_NAME,
          mutationDocument: updatePostMutationDocument,
          variables: {
            'id': postData.post.id,
            'expectedVersion': postData.version,
            // 'videoURL': postData.videoURL,
            // 'updatedAt': postData.post.updatedAt.toString(),
            'status': Status.INACTIVE.toString().split('.').last,
            'updatedAt': postData.post.updatedAt.toString(),
            'postCategory':
                getPostCategory(postData).toString().split(".").last,
          });
      var body = jsonDecode(response.body);
      print("Post update complete " + body.toString());
      if (body['data']['updatePostWithTags'] == null)
        throw Exception([
          "post update failed",
        ]);
      // postData.version = body['data']['updatePostWithTags']['version'];
      // print("new version is ${postData.getReaction.version}");
    } catch (e, s) {
      wasPostDeletionSuccessful = false;
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }

    return wasPostDeletionSuccessful && response.statusCode == 200;
  }
}
