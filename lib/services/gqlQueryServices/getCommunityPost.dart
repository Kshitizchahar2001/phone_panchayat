// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/CommunityPost.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetCommunityPost {
  static const String GET_COMMUNITY_POST_QUERY_DOCUMENT = 'GetCommunityPost';

  final String getCommunityPostQueryDocument = '''
  query GetCommunityPost(\$id: ID!) {
  getCommunityPost(id: \$id) {
    content
    version
    status
    comments(sortDirection: DESC)  {
      nextToken
      items {
        content
        status
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
    pincode
    postContentType
    postType
    updatedAt
    userId
    videoURL
    communityId
    user {
      id
      designation
      image
      name
    }
  }
}

  ''';

  Future<FeedQueryData> getCommunityPost({@required String postId}) async {
    http.Response response;
    Map<String, dynamic> variables = {'id': postId};
    FeedQueryData postQueryData = FeedQueryData();
    try {
      response = await RunQuery.runQuery(
          operationName: GET_COMMUNITY_POST_QUERY_DOCUMENT,
          mutationDocument: getCommunityPostQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      if (body['data']['getCommunityPost'] == null) {
        postQueryData.setList = <CommunityPost>[];
        return postQueryData;
      }
      Map postJson = body['data']['getCommunityPost'];
      CommunityPost post = CommunityPost.fromJson(postJson);

      postQueryData.setList = <CommunityPost>[post];
      postQueryData.postVersion[postJson['id']] = postJson['version'];
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return postQueryData;
  }
}
