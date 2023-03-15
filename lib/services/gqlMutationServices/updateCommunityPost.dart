// ignore_for_file: file_names, constant_identifier_names, avoid_print, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;

class UpdateCommunityPost {
  static const String UPDATE_COMMUNITY_POST_OPERATION_NAME =
      'updateCommunityPost';
  final updateCommunityPostMutationDocument =
      '''mutation updateCommunityPost(\$content: String, \$createdAt: AWSDateTime, \$expectedVersion: Int!, \$id: ID!, \$imageURL: String, \$status: Status, \$updatedAt: AWSDateTime, \$videoURL: String) {
  updateCommunityPost(input: {content: \$content, createdAt: \$createdAt, expectedVersion: \$expectedVersion, id: \$id, imageURL: \$imageURL, status: \$status, updatedAt: \$updatedAt, videoURL: \$videoURL}) {
    content
    status
  }
}

''';

  updateCommunityPostVideoUrl({
    @required PostData postData,
  }) async {
    try {
      http.Response response = await RunQuery.runQuery(
          operationName: UPDATE_COMMUNITY_POST_OPERATION_NAME,
          mutationDocument: updateCommunityPostMutationDocument,
          variables: {
            'id': postData.post.id,
            'expectedVersion': postData.version,
            'videoURL': postData.videoURL,
            'updatedAt': postData.post.updatedAt.toString(),
          });
      var body = jsonDecode(response.body);
      print(body);
      print("Post update complete " + body.toString());
      if (body['data']['updateCommunityPost'] == null)
        throw Exception([
          "post update failed",
        ]);
      postData.version = body['data']['updateCommunityPost']['version'];
      // print("new version is ${postData.getReaction.version}");
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  updateCommunityPost({
    @required String id,
    @required String content,
    @required String imageURL,
    @required String videoURL,
    @required int expectedVersion,
  }) async {
    bool wasPostCreationSuccessful = true;
    http.Response response;

    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_COMMUNITY_POST_OPERATION_NAME,
          mutationDocument: updateCommunityPostMutationDocument,
          variables: {
            'id': id,
            'expectedVersion': expectedVersion,
            'content': content,
            'videoURL': videoURL,
            'imageURL': imageURL,
            'status': Status.ACTIVE.toString().split('.').last,
            // 'updatedAt': postData.post.updatedAt.toString(),
          });
      var body = jsonDecode(response.body);
      print("Post update complete " + body.toString());
      if (body['data']['updateCommunityPost'] == null)
        throw Exception([
          "post update failed",
        ]);
      // postData.version = body['data']['updatePost']['version'];
      // print("new version is ${postData.getReaction.version}");
    } catch (e, s) {
      wasPostCreationSuccessful = false;
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }

    return wasPostCreationSuccessful && response.statusCode == 200;
  }

  Future<bool> deleteCommunityPost({
    @required PostData postData,
  }) async {
    bool wasPostCreationSuccessful = true;
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_COMMUNITY_POST_OPERATION_NAME,
          mutationDocument: updateCommunityPostMutationDocument,
          variables: {
            'id': postData.post.id,
            'expectedVersion': postData.version,
            // 'videoURL': postData.videoURL,
            // 'updatedAt': postData.post.updatedAt.toString(),
            'status': Status.INACTIVE.toString().split('.').last,
          });
      var body = jsonDecode(response.body);
      print("Post update complete " + body.toString());
      if (body['data']['updateCommunityPost'] == null)
        throw Exception([
          "post update failed",
        ]);
      // postData.version = body['data']['updateCommunityPost']['version'];
      // print("new version is ${postData.getReaction.version}");
    } catch (e, s) {
      wasPostCreationSuccessful = false;
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }

    return wasPostCreationSuccessful && response.statusCode == 200;
  }
}
