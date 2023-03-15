// ignore_for_file: file_names, constant_identifier_names, avoid_print, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/ReactionTypes.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;

class UpdateReaction {
  static const String UPDATE_REACTION_OPERATION_NAME = 'UpdateReaction';
  final updateReactionsDocument =
      '''mutation UpdateReaction(\$postId: ID!, \$userId: ID!, \$expectedVersion: Int!, \$status: Status, \$reactionType: ReactionTypes!) {
  updateReactions(input: {expectedVersion: \$expectedVersion, postId: \$postId, status: \$status, userId: \$userId, reactionType: \$reactionType}) {
    status
    version
  }
}
''';

  updateReactions({
    @required String postId,
    @required String userId,
    @required Status status,
    // @required int expectedVersion,
    @required PostData postData,
  }) async {
    try {
      http.Response response = await RunQuery.runQuery(
          operationName: "UpdateReaction",
          mutationDocument: updateReactionsDocument,
          variables: {
            'postId': postId,
            'status': status.toString().split('.').last,
            'userId': userId,
            'expectedVersion': postData.getReaction.version,
            'reactionType': ReactionTypes.LIKE.toString().split('.').last,
          });
      var body = jsonDecode(response.body);
      print(body);
      if (body['data']['updateReactions'] == null)
        throw Exception([
          "User tried to update like too frequently",
          "Two updateReactions mutations with same version number"
        ]);
      postData.getReaction.version = body['data']['updateReactions']['version'];
      // print("new version is ${postData.getReaction.version}");
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
