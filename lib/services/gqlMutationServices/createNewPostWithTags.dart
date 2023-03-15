// ignore_for_file: file_names, constant_identifier_names, unnecessary_null_in_if_null_operators, avoid_print, duplicate_ignore

import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/PostCategory.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;

class CreateNewPostWithTags {
  static const String CREATE_POST_OPERATION_NAME = 'CreatePostWithTags';

  final createPostMutationDocument =
      ''' mutation CreatePostWithTags(\$content: String, \$imageURL: String, \$location: LocationInput !, \$noOfLikes: Int!, \$noOfViews: Int!, \$postCategory: PostCategory, \$shareURL: String, \$status: Status, \$tag: [String] , \$imageUrlsList: [String], \$userId: ID!, \$videoURL: String) {
  createPostWithTags(input: {content: \$content, imageURL: \$imageURL, location: \$location, noOfLikes: \$noOfLikes, noOfViews: \$noOfViews, postCategory: \$postCategory, shareURL: \$shareURL, status: \$status, tag: \$tag,imageUrlsList: \$imageUrlsList, userId: \$userId, videoURL: \$videoURL}) {
    id
  }
}

''';

  Future<CreatePostQueryResponse> createNewPostWithTags({
    @required String videoURL,
    @required String imageURL,
    @required String content,
    @required Location location,
    @required String userId,
    @required int noOfViews,
    @required int noOfLikes,
    @required PostCategory postCategory,
    @required List<String> tag,
    @required List<String> imageUrlsList,
    String hashTag,
  }) async {
    bool wasPostCreationSuccessful = true;
    http.Response response;
    CreatePostQueryResponse createPostQueryResponse =
        CreatePostQueryResponse(success: true);
    try {
      Map<String, dynamic> variables = {
        'noOfLikes': 0,
        'noOfViews': 0,
        'userId': userId ?? "",
        'location': location?.toJson() ?? null,
        'content': content ?? "",
        'imageURL': imageURL ?? "",
        'videoURL': videoURL ?? "",
        'status': Status.ACTIVE.toString().split('.').last,
        'postCategory': postCategory.toString().split('.').last,
        'tag': tag,
        'imageUrlsList': imageUrlsList,
      };

      if (hashTag != null) {
        variables.addEntries({'hashTag': hashTag}.entries);
      }

      response = await RunQuery.runQuery(
        operationName: CREATE_POST_OPERATION_NAME,
        mutationDocument: createPostMutationDocument,
        variables: variables,
      ).catchError((e, s) {
        wasPostCreationSuccessful = false;
        // ignore: avoid_print
        print(e);
        FirebaseCrashlytics.instance.recordError(e, s);
      });

      var body = jsonDecode(response.body);
      createPostQueryResponse.id = body['data']['createPostWithTags']['id'];

      print(body);
    } catch (e, s) {
      wasPostCreationSuccessful = false;
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    createPostQueryResponse.success =
        response.statusCode == 200 && wasPostCreationSuccessful;

    return createPostQueryResponse;
  }
}

class CreatePostQueryResponse {
  bool success;
  String id;
  CreatePostQueryResponse({this.success, this.id});
}
