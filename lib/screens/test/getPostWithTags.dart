// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Identifiers.dart';
// import 'package:online_panchayat_flutter/models/Identifiers.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetIdentifiers {
  static const String OperationName = 'GetIdentifiers';

  final String queryDocument = '''
  query $OperationName(\$id: ID!) {
  getIdentifiers(id: \$id) {
    name
    id
  }
}


  ''';

  final String createMutationDoc = '''
mutation MyMutation {
  createIdentifiers(input: {pincode: "12", type: PANCHAYAT_SAMITI}) {
    createdAt
    id
    pincode
  }
}

''';

  Future<Identifiers> getIdentifiers({@required String id}) async {
    http.Response response;
    Map<String, dynamic> variables = {'id': id};
    Identifiers identifiers;
    try {
      response = await RunQuery.runQuery(
          operationName: OperationName,
          mutationDocument: queryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      Map postJson = body['data']['getIdentifiers'];
      identifiers = Identifiers.fromJson(postJson);
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return identifiers;
  }

  Future<void> createIdentifiers() async {
    http.Response response;

    try {
      response = await RunQuery.runQuery(
          operationName: 'MyMutation',
          mutationDocument: createMutationDoc,
          variables: {});
      var body = jsonDecode(response.body);
      print(body.toString());
      // Map postJson = body['data']['getIdentifiers'];
      // identifiers = Identifiers.fromJson(postJson);
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
