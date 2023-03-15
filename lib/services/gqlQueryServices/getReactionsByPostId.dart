// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/models/Reactions.dart';

// getReactionsbyPostId
class GetReactionsbyPostId {
  static const String GET_REACTIONS_BY_POST_ID_OPERATION_NAME =
      'GetReactionsbyPostId';

  final String getReactionsbyPostIdQueryDocument = ''' 
query GetReactionsbyPostId(\$postId: ID) {
  getReactionsbyPostId(postId: \$postId, filter: {status: {eq: ACTIVE}}) {
    items {
      postId
      reactionType
      status
      user {
        id
        name
        designation
        image
      }
    }
  }
}
  ''';

  Future<List<Reactions>> getReactionsbyPostId({
    @required String postId,
  }) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'postId': postId,
      };

      response = await RunQuery.runQuery(
          operationName: GET_REACTIONS_BY_POST_ID_OPERATION_NAME,
          mutationDocument: getReactionsbyPostIdQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      print(body);

      if (body['data']['getReactionsbyPostId'] == null) return <Reactions>[];
      List reactions = body['data']['getReactionsbyPostId']["items"];
      List<Reactions> listOfReactions =
          reactions.map((element) => Reactions.fromJson(element)).toList();
      return listOfReactions;
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return <Reactions>[];
  }
}
