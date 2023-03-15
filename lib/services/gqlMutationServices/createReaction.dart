// ignore_for_file: file_names, constant_identifier_names, avoid_print, curly_braces_in_flow_control_structures

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/ReactionTypes.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';

class CreateReaction {
  final createReactionDocument =
      '''mutation CreateReaction(\$postId: ID !, \$reactionType: ReactionTypes!, \$status: Status!, \$userId: ID!) {
  createReactions(input: {postId: \$postId, reactionType: \$reactionType, status: \$status, userId: \$userId}) {
    createdAt
    version
  }
}''';
  static const String CREATE_REACTION_OPERATION_NAME = 'CreateReaction';

  Future<void> createReaction({
    @required String postId,
    @required String userId,
    @required Status status,
    @required ReactionTypes reactionType,
    @required PostData postDataWithReaction,
  }) async {
    try {
      http.Response response = await RunQuery.runQuery(
          operationName: CREATE_REACTION_OPERATION_NAME,
          mutationDocument: createReactionDocument,
          variables: {
            'postId': postId,
            'reactionType': reactionType.toString().split('.').last,
            'status': status.toString().split('.').last,
            'userId': userId
          });
      var body = jsonDecode(response.body);
      print(body);

      if (body['data']['createReactions'] == null)
        throw Exception(["Reaction not created"]);
      postDataWithReaction.getReaction.version =
          body['data']['createReactions']['version'];
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
