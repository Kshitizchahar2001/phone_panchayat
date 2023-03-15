// ignore_for_file: file_names, constant_identifier_names, avoid_print, prefer_conditional_assignment

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/LocalIssueWithTag.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/LocalIssueFeed/localIssueData/localIssueData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String postDetails = '''
    items {
      post {
      shareURL
      content
      version
      status
      comments(sortDirection: ASC,limit: 2)  {
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
      postCategory
      }
      place1 {
        id
        name_en
        name_hi
      }
      place2 {
        name_en
        name_hi
        id
      }
      id
      createdAt
      identifier_1
      identifier_2
      version
      updatedAt
      status
      postId
      }
    nextToken

''';

class SearchLocalIssuesbyTagAndIdentifiers {
  static const String OPERATION_NAME = 'SearchLocalIssuesbyTagAndIdentifiers';
  static const String QueryDocument = '''
query SearchLocalIssuesbyTagAndIdentifiers(\$sortDirection: ModelSortDirection = DESC, \$tagId: String, \$nextToken: String, \$limit: Int ) {
  searchLocalIssuesbyTagAndIdentifiers(sortDirection: \$sortDirection, tagId: \$tagId, nextToken: \$nextToken, limit: \$limit, identifier_1Identifier_2UpdatedAt: {}) {
        $postDetails
  }
}

  ''';
  static const String searchLocalIssuesByPincodeAndIdentifiersQueryDocument =
      '''
query SearchLocalIssuesbyTagAndIdentifiers(\$sortDirection: ModelSortDirection = DESC, \$tagId: String, \$nextToken: String, \$limit: Int, \$identifier_1: ID!, \$identifier_2: ID!) {
  searchLocalIssuesbyTagAndIdentifiers(sortDirection: \$sortDirection, tagId: \$tagId, nextToken: \$nextToken, limit: \$limit, identifier_1Identifier_2UpdatedAt: {beginsWith: {identifier_2: \$identifier_2, identifier_1: \$identifier_1}}) {
    $postDetails
  }
}

  ''';

  Future<FeedQueryData> searchLocalIssuesbyTagAndIdentifiers({
    @required String tagId,
    @required int limit,
    @required String nextToken,
    @required String identifier_1,
    @required String identifier_2,
  }) async {
    return await searchLocalIssuesbyTag(
      tagId: tagId,
      limit: limit,
      nextToken: nextToken,
      identifier_1: identifier_1,
      identifier_2: identifier_2,
      mutationDocument: searchLocalIssuesByPincodeAndIdentifiersQueryDocument,
    );
  }

  Future<SearchLocalIssuesQueryData> searchLocalIssuesbyTag(
      {@required String tagId,
      @required int limit,
      @required String nextToken,
      String identifier_1,
      String identifier_2,
      String mutationDocument = QueryDocument}) async {
    SearchLocalIssuesQueryData feedQueryData = SearchLocalIssuesQueryData();
    http.Response response;
    Map<String, dynamic> variables;

    if (nextToken == lastNextTokenEqualToNull) {
      feedQueryData.nextToken = nextToken;
      return feedQueryData;
    }
    variables = {
      'tagId': tagId,
      'limit': limit,
      'nextToken': nextToken,
    };

    if (identifier_1 != null) {
      variables.addEntries({
        'identifier_1': identifier_1,
        'identifier_2': identifier_2,
      }.entries);
    }

    try {
      response = await RunQuery.runQuery(
          operationName: OPERATION_NAME,
          mutationDocument: mutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);
      print("local issues****" + body.toString());

      nextToken =
          body['data']['searchLocalIssuesbyTagAndIdentifiers']["nextToken"];

      if (nextToken == null) {
        nextToken = lastNextTokenEqualToNull;
      }

      feedQueryData.setNextToken = nextToken;

      List listOfLocalIssuesJson =
          body['data']['searchLocalIssuesbyTagAndIdentifiers']["items"];

      feedQueryData.setList =
          listOfLocalIssuesJson.map(generateLocalIssueDataFromJson).toList();
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return feedQueryData;
  }

  LocalIssueData generateLocalIssueDataFromJson(dynamic element) {
    LocalIssueData localIssueData;
    try {
      PostWithTags post = PostWithTags.fromJson(element['post']);
      PostData postData =
          PostData(post: post, version: element['post']['version']);

      localIssueData = LocalIssueData(
        localIssue: LocalIssueWithTag.fromJson(element),
        postData: postData,
        version: element['version'],
      );
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(
          "Error in generateLocalIssueDataFromJson  " + e.toString(), s);
      print(e.toString() + "EXCEPTION");
    }
    return localIssueData;
  }
}
