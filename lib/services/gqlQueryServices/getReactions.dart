// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/GetReaction.dart';
import 'package:online_panchayat_flutter/models/ReactionTypes.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:http/http.dart' as http;

class GetReactions {
  static const String GET_REACTIONS_OPERATION_NAME = 'GetReactions';

  final String getReactionsQueryDocument = ''' 
  query GetReactions(\$postId:ID!,\$reactionType: ReactionTypes! , \$userId: ID!) {
  getReactions(postId: \$postId, reactionType: \$reactionType, userId: \$userId) {
    status
    version
  }
}
  ''';

  Future<GetReaction> getReactions({
    @required String postId,
    @required ReactionTypes reactionType,
    @required String userId,
  }) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'postId': postId,
        'reactionType': enumToString(reactionType),
        'userId': userId
      };

      response = await RunQuery.runQuery(
          operationName: GET_REACTIONS_OPERATION_NAME,
          mutationDocument: getReactionsQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);

      if (body['data']['getReactions'] == null) return GetReaction();
      GetReaction getReaction =
          GetReaction.fromJson(body['data']['getReactions']);
      // print(" ${getReaction.status}  ${getReaction.version}");

      return getReaction;

      // String status = body['data']['getReactions']['status'];
      // if (status.compareTo("ACTIVE") == 0) return Status.ACTIVE;

    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return GetReaction();
  }
}
