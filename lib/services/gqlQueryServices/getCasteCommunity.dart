// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetCasteCommunity {
  static const String GET_CASTE_COMMUNITY_QUERY_DOCUMENT_NAME =
      "GetCasteCommunity";

  final String getCasteCommunityQueryDocument = '''
  query GetCasteCommunity(\$id: ID!) {
  getCasteCommunity(id: \$id) {
    users {
      items {
        id
        name
        image
        designation
      }
      nextToken
    }
  }
}
  ''';
  Future<List<User>> getListOfUsersInACommunity(
      {@required String communityId}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {'id': communityId};

      response = await RunQuery.runQuery(
          operationName: GET_CASTE_COMMUNITY_QUERY_DOCUMENT_NAME,
          mutationDocument: getCasteCommunityQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);

      List listOfUserJson = body['data']['getCasteCommunity']["users"]["items"];
      List<User> listOfUsers = <User>[];
      listOfUsers = listOfUserJson.map((element) {
        User user;
        try {
          user = User.fromJson(element);
        } catch (e) {
          print(e.toString() + "EXCEPTION");
        }
        return user;
      }).toList();
      return listOfUsers;
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return <User>[];
  }
}
