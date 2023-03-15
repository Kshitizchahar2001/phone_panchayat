// ignore_for_file: file_names, constant_identifier_names, prefer_conditional_assignment, avoid_print, duplicate_ignore

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/CommunityPost.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetCommunityPostByUpdatedAt {
  static const int commentsToBeDisplayedOnFeedPage = 2;
  static const String GET_COMMUNITY_POST_BY_UPDATED_TIME_OPERATION_NAME =
      'GetCommunityPostByUpdatedAt';
  final String getCommunityPostByUpdatedAtQueryDocument =
      ''' query GetCommunityPostByUpdatedAt(\$nextToken: String , \$limit: Int , \$communityId: ID)  {
  getCommunityPostByUpdateAt(nextToken: \$nextToken, sortDirection: DESC, limit: \$limit,communityId: \$communityId) {
    nextToken
    items {
      content
      version
      status
      comments(sortDirection: DESC,limit: $commentsToBeDisplayedOnFeedPage)  {
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
}
''';

  Future<FeedQueryData> getCommunityPostByUpdatedTime({
    @required String communityId,
    @required int numberOfPostsTofetch,
    @required String nextToken,
  }) async {
    http.Response response;
    Map<String, dynamic> variables;
    FeedQueryData postQueryData = FeedQueryData();
    if (nextToken == lastNextTokenEqualToNull) {
      postQueryData.nextToken = nextToken;
      return postQueryData;
    }

    variables = {
      'communityId': communityId,
      'limit': numberOfPostsTofetch,
      'nextToken': nextToken
    };

    try {
      response = await RunQuery.runQuery(
          operationName: GET_COMMUNITY_POST_BY_UPDATED_TIME_OPERATION_NAME,
          mutationDocument: getCommunityPostByUpdatedAtQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);

      nextToken = body['data']['getCommunityPostByUpdateAt']["nextToken"];

      if (nextToken == null) {
        nextToken = lastNextTokenEqualToNull;
      }
      postQueryData.setNextToken = nextToken;

      List listOfPostJson = body['data']['getCommunityPostByUpdateAt']["items"];
      postQueryData.setList = listOfPostJson.map((element) {
        CommunityPost communityPost;
        try {
          communityPost = CommunityPost.fromJson(element);
          postQueryData.postVersion[element['id']] = element['version'];
        } catch (e) {
          // ignore: avoid_print
          print(e.toString() + "EXCEPTION");
        }
        return communityPost;
      }).toList();
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return postQueryData;
  }
}
