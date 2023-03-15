// ignore_for_file: file_names, constant_identifier_names, prefer_conditional_assignment, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'dart:convert';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;

// int numberOfComments = 1;

class GetPostWithTagsByUserIdAndSortByCreatedAt {
  static const String GET_POST_BY_USER_ID =
      'GetPostWithTagsByUserIdAndSortByCreatedAt';

  final String getPostByUserIdQueryDocument = '''
    query GetPostWithTagsByUserIdAndSortByCreatedAt(\$userId: ID, \$limit: Int,\$nextToken: String) {
  getPostWithTagsByUserIdAndSortByCreatedAt(userId: \$userId, limit: \$limit,nextToken: \$nextToken, sortDirection: DESC) {
    nextToken
    items {
      shareURL
      imageUrlsList
      postCategory
      content
      version
      status
      comments(sortDirection: ASC, limit: 2) {
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
}

''';

  Future<FeedQueryData> getPostByUserId({
    @required String userId,
    @required int numberOfPostsTofetch,
    @required String nextToken,
  }) async {
    http.Response response;
    Map<String, dynamic> variables = {
      'userId': userId,
      'limit': numberOfPostsTofetch,
      'nextToken': nextToken,
    };
    FeedQueryData postQueryData = NormalPostQueryData();
    if (nextToken == lastNextTokenEqualToNull) {
      postQueryData.nextToken = nextToken;
      return postQueryData;
    }

    try {
      response = await RunQuery.runQuery(
          operationName: GET_POST_BY_USER_ID,
          mutationDocument: getPostByUserIdQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      nextToken = body['data']['getPostWithTagsByUserIdAndSortByCreatedAt']
          ["nextToken"];

      if (nextToken == null) {
        nextToken = lastNextTokenEqualToNull;
      }
      postQueryData.setNextToken = nextToken;

      List listOfPostJson =
          body['data']['getPostWithTagsByUserIdAndSortByCreatedAt']["items"];
      postQueryData.setList = listOfPostJson.map((element) {
        PostWithTags post;
        try {
          post = PostWithTags.fromJson(element);
          postQueryData.postVersion[element['id']] = element['version'];
        } catch (e) {
          print(e.toString() + "EXCEPTION");
        }
        return post;
      }).toList();
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return postQueryData;
  }
}
