// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetPostWithTags {
  static const String GET_POST_QUERY_DOCUMENT = 'GetPostWithTags';

  final String getPostQueryDocument = '''
  query GetPostWithTags(\$id: ID!) {
  getPostWithTags(id: \$id) {
    shareURL
    imageUrlsList
    postCategory
    content
    version
    status
    comments(sortDirection: ASC) {
      nextToken
      items {
        content
        status
        imageURL
        user {
          id
          name
          image
          designation
        }
      }
    }
    id
    createdAt
    noOfLikes
    noOfViews
    imageURL
    location {
      lat
      lon
    }
    postContentType
    updatedAt
    userId
    videoURL
    user {
      id
      designation
      image
      name
    }
  }
}


  ''';

  Future<FeedQueryData> getPostWithTags({@required String postId}) async {
    http.Response response;
    Map<String, dynamic> variables = {'id': postId};
    FeedQueryData postQueryData = NormalPostQueryData();
    try {
      response = await RunQuery.runQuery(
          operationName: GET_POST_QUERY_DOCUMENT,
          mutationDocument: getPostQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      if (body['data']['getPostWithTags'] == null) {
        postQueryData.setList = <PostWithTags>[];
        return postQueryData;
      }
      Map postJson = body['data']['getPostWithTags'];
      PostWithTags post = PostWithTags.fromJson(postJson);
      postQueryData.setList = <PostWithTags>[post];
      postQueryData.postVersion[postJson['id']] = postJson['version'];
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return postQueryData;
  }
}
