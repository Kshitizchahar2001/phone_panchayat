// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/screens/user_profile_screen/follow_relationships_query_data.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class GetFollowRelationships {
  static const String GET_FOLLOW_RELATIONSHIPS_OPERATION_NAME =
      'GetFollowRelationships';

  final String getFollowRelationshipsQueryDocument = ''' 
query GetFollowRelationships(\$followeeId: ID!, \$followerId: ID!) {
  getFollowRelationships(followeeId: \$followeeId, followerId: \$followerId) {
    createdAt
    followeeId
    followerId
    status
    updatedAt
    version
  }
}

  ''';

  Future<FollowRelationQueryData> getFollowRelationships({
    @required String followeeId,
    @required String followerId,
  }) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'followeeId': followeeId,
        'followerId': followerId,
      };

      response = await RunQuery.runQuery(
          operationName: GET_FOLLOW_RELATIONSHIPS_OPERATION_NAME,
          mutationDocument: getFollowRelationshipsQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);

      if (body['data']['getFollowRelationships'] != null) {
        return FollowRelationQueryData(
            recordFound: true,
            success: true,
            version: body['data']['getFollowRelationships']["version"],
            status: enumFromString<Status>(
                body['data']['getFollowRelationships']["status"],
                Status.values));
      } else {
        return FollowRelationQueryData(
          recordFound: false,
          success: true,
        );
      }
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      return FollowRelationQueryData(success: false);
    }
  }
}
