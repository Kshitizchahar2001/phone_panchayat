// ignore_for_file: file_names, constant_identifier_names

import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/screens/user_profile_screen/follow_relationships_query_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';

class CreateFollowRelationships {
  final createFollowRelationsDocument = '''
mutation CreateFollowRelationships(\$followeeId: ID!, \$followerId: ID!, \$status: Status!) {
  createFollowRelationships(input: {followeeId: \$followeeId, followerId: \$followerId, status: \$status}) {
    createdAt
    followeeId
    followerId
    status
    updatedAt
    version
  }
}

''';

  static const String CREATE_FOLLOW_RELATIONSHIPS_OPERATION_NAME =
      'CreateFollowRelationships';

  Future<FollowRelationQueryData> createFollowRelationships({
    @required String followerId,
    @required String followeeId,
    @required Status status,
  }) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: CREATE_FOLLOW_RELATIONSHIPS_OPERATION_NAME,
          mutationDocument: createFollowRelationsDocument,
          variables: {
            'followerId': followerId,
            'followeeId': followeeId,
            'status': status.toString().split('.').last,
          });
      var body = jsonDecode(response.body);

      return FollowRelationQueryData(
        success: true,
        version: body["data"]["createFollowRelationships"]["version"],
      );
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return FollowRelationQueryData(
        success: false,
      );
    }
  }
}
