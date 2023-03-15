// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/GetReaction.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetReactionsByUserId {
  static const String GET_REACTIONS_BY_USER_ID_OPERATION_NAME =
      'GetReactionsbyUserId';

  final String getReactionsByUserIdQueryDocument = ''' 
query GetReactionsbyUserId(\$userId: ID, \$limit: Int = 1) {
  getReactionsbyUserId(userId: \$userId, limit: \$limit) {
    items {
      postId
    }
  }
}
  ''';

  Future<GetReaction> getReactionsByUserId({
    @required String userId,
  }) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'userId': userId,
      };

      response = await RunQuery.runQuery(
        operationName: GET_REACTIONS_BY_USER_ID_OPERATION_NAME,
        mutationDocument: getReactionsByUserIdQueryDocument,
        variables: variables,
      );
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

String comment = '''
query GetCommentsByUserId {
  getCommentsByUserId(userId: "+918953446887", limit: 1) {
    items {
      content
    }
  }
}

''';
