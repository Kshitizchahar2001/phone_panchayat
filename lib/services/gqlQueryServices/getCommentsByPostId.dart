// ignore_for_file: file_names, duplicate_import, constant_identifier_names, prefer_conditional_assignment, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/Comment.dart';
import 'package:online_panchayat_flutter/models/Comment.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentQueryData {
  String nextToken;
  List<Comment> list = <Comment>[];

  set setNextToken(String nextToken) {
    this.nextToken = nextToken;
  }

  set setList(List<Comment> list) {
    this.list = list;
  }
}

class GetCommentsByPostId {
  static const String GET_COMMENTS_BY_POST_ID = 'GetCommentsByPostId';
  final String getCommentsByPostIdQueryDocument = '''
 query GetCommentsByPostId(\$nextToken: String, \$postId: ID, \$limit: Int ) {
  getCommentsByCreatedTime(postId: \$postId, sortDirection: ASC, nextToken: \$nextToken, limit: \$limit) {
    items {
      content
      postId
      imageURL
      user {
        name
        id
        image
        designation
      }
    }
    nextToken
  }
}
  ''';

  Future<CommentQueryData> getCommentsByPostId({
    @required String postId,
    @required int numberOfCommentsTofetch,
    @required String nextToken,
  }) async {
    CommentQueryData commentQueryData = CommentQueryData();
    http.Response response;
    Map<String, dynamic> variables;

    if (nextToken == lastNextTokenEqualToNull) {
      commentQueryData.nextToken = nextToken;
      return commentQueryData;
    }
    variables = {
      'postId': postId,
      'limit': numberOfCommentsTofetch,
      'nextToken': nextToken
    };

    try {
      response = await RunQuery.runQuery(
          operationName: GET_COMMENTS_BY_POST_ID,
          mutationDocument: getCommentsByPostIdQueryDocument,
          variables: variables);

      var body = jsonDecode(response.body);

      nextToken = body['data']['getCommentsByCreatedTime']["nextToken"];

      if (nextToken == null) {
        nextToken = lastNextTokenEqualToNull;
      }

      commentQueryData.setNextToken = nextToken;

      List listOfCommentJson =
          body['data']['getCommentsByCreatedTime']["items"];
      // print("items returned from query : ${listOfCommentJson.length}");
      commentQueryData.setList = listOfCommentJson.map((element) {
        Comment comment;
        try {
          comment = Comment.fromJson(element);
        } catch (e) {
          print(e.toString() + "EXCEPTION");
        }
        return comment;
      }).toList();
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return commentQueryData;
  }
}
