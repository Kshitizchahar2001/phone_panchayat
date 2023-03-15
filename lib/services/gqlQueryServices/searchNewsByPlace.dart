// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/LiveNews.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchNewsByPlace {
  static const String OPERATION_NAME = 'SearchNewsByPlace';

  final String queryDocument = '''
  query SearchNewsByPlace(\$placeId: ID!) {
  searchNewsByPlace(placeId: \$placeId, sortDirection: DESC) {
    items {
      createdAt
      id
      imageUrl
      name
      placeId
      postId
      updatedAt
    }
  }
}

  ''';

  Future<List<LiveNews>> searchNewsByPlace({@required String placeId}) async {
    http.Response response;
    Map<String, dynamic> variables = {'placeId': placeId};
    List<LiveNews> list = <LiveNews>[];
    try {
      response = await RunQuery.runQuery(
          operationName: OPERATION_NAME,
          mutationDocument: queryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      if (body['data']['searchNewsByPlace'] == null) {
        return <LiveNews>[];
      }
      List liveNewsList = body['data']['searchNewsByPlace']["items"];
      list = liveNewsList.map((element) => LiveNews.fromJson(element)).toList();
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return list;
  }
}
