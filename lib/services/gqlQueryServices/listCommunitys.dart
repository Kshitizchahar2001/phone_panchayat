// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/CasteCommunity.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ListCasteCommunitys {
  static const String LIST_CAST_COMMUNITYS_OPERATION_NAME =
      'ListCasteCommunitys';
  final String listCommunitysQueryDocument = '''
query ListCasteCommunitys(\$eq: String)  {
  listCasteCommunitys(filter: {pincode: {eq: \$eq}}) {
    items {
      name
      id
    }
  }
}
''';

  Future<List<CasteCommunity>> listCasteCommunitys(
      {@required String pincode}) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: LIST_CAST_COMMUNITYS_OPERATION_NAME,
          mutationDocument: listCommunitysQueryDocument,
          variables: {
            "eq": pincode,
          });
      var body = jsonDecode(response.body);
      print(body);
      if (body['data']['listCasteCommunitys']["items"] == []) {
        return <CasteCommunity>[];
      }

      List listOfCommunitysJson = body['data']['listCasteCommunitys']["items"];
      List<CasteCommunity> listOfCommunitys = listOfCommunitysJson
          .map((element) => CasteCommunity.fromJson(element))
          .toList();

      return listOfCommunitys;
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return <CasteCommunity>[];
  }
}
