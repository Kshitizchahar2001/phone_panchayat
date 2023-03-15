// ignore_for_file: file_names, constant_identifier_names, prefer_conditional_assignment, avoid_print, empty_catches

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPostByTag {
  static const String OPERATION_NAME = 'SearchPostByTag';
  static const String QUERY_DOCUMENT = '''
  query SearchPostByTag(\$limit: Int, \$tagId: ID, \$nextToken: String ) {
  searchPostByTag(tagId: \$tagId, limit: \$limit, sortDirection: DESC, nextToken: \$nextToken) {
    nextToken
    items {
      postId
      createdAt
      tagId
      ttl
      tag {
        name
      }
      post {
        comments(sortDirection: ASC, limit: 2) {
          nextToken
          items {
            content
            status
            imageURL
            user {
              id
              image
              name
              designation
            }
          }
        }
        content
        createdAt
        hashTag
        id
        imageURL
        imageUrlsList
        location {
          lat
          lon
        }
        noOfLikes
        noOfViews
        postCategory
        postContentType
        reactionDisabled
        shareDisabled
        shareURL
        status
        tag
        ttl
        updatedAt
        userId
        version
        videoURL
        user {
          designation
          name
          id
          image
        }
        commentDisabled
      }
    }
  }
}


  ''';

  Future<FeedQueryData> searchPostByTag({
    @required String tag,
    @required int numberOfPostsTofetch,
    @required String nextToken,
  }) async {
    FeedQueryData postQueryData = NormalPostQueryData();
    http.Response response;
    Map<String, dynamic> variables;

    if (nextToken == lastNextTokenEqualToNull) {
      postQueryData.nextToken = nextToken;
      return postQueryData;
    }
    variables = {
      'tagId': tag,
      'limit': numberOfPostsTofetch,
      'nextToken': nextToken
    };

    try {
      response = await RunQuery.runQuery(
        operationName: OPERATION_NAME,
        mutationDocument: QUERY_DOCUMENT,
        variables: variables,
      );

      var body = jsonDecode(response.body);

      nextToken = body['data']['searchPostByTag']["nextToken"];

      if (nextToken == null) {
        nextToken = lastNextTokenEqualToNull;
      }

      postQueryData.setNextToken = nextToken;

      List listOfPostJson = body['data']['searchPostByTag']["items"];
      postQueryData.setList = getPostList(listOfPostJson, postQueryData);
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return postQueryData;
  }

  List<PostWithTags> getPostList(
      List listOfPostJson, FeedQueryData postQueryData) {
    List<PostWithTags> list = <PostWithTags>[];
    for (int i = 0; i < listOfPostJson.length; i++) {
      try {
        PostWithTags post = fun(listOfPostJson[i], postQueryData);
        list.add(post);
      } catch (e) {}
    }
    return list;
  }

  PostWithTags fun(dynamic element, FeedQueryData postQueryData) {
    var postJson = element['post'];
    PostWithTags post;
    post = PostWithTags.fromJson(postJson);
    postQueryData.postVersion[postJson['id']] = postJson['version'];
    return post;
  }
}
