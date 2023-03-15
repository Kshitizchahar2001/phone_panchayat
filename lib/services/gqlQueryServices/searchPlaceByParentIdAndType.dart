// ignore_for_file: file_names, curly_braces_in_flow_control_structures, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'dart:convert';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;

class SearchPlacedByParentIdAndType {
  static const String searchPlacedByParentIdAndTypeOperationName =
      'SearchPlacedByParentIdAndType';

  final String searchPlacedByParentIdAndTypeQueryDocument =
      '''query SearchPlacedByParentIdAndType(\$parentId: String , \$eq: String) {
  searchPlacedByParentIdAndType(parentId: \$parentId, type: {eq: \$eq}) {
    items {
      createdAt
      id
      name_en
      name_hi
      parentId
      type
      tag {
        id
        name
      }
    }
  }
}
''';

  Future<List<Places>> searchPlacedByParentIdAndType({
    @required String parentId,
    PlaceType placeType,
  }) async {
    http.Response response;
    Map<String, dynamic> variables = {
      'parentId': parentId,
    };

    if (placeType != null)
      variables.addEntries(
        {
          'eq': placeType.toString().split(".").last,
        }.entries,
      );

    List<Places> list;

    try {
      response = await RunQuery.runQuery(
        operationName: searchPlacedByParentIdAndTypeOperationName,
        mutationDocument: searchPlacedByParentIdAndTypeQueryDocument,
        variables: variables,
      );
      var body = jsonDecode(response.body);

      List listOfPostJson =
          body['data']['searchPlacedByParentIdAndType']["items"];
      list = listOfPostJson.map((element) {
        Places places;
        try {
          places = Places.fromJson(element);
        } catch (e) {
          print(e.toString() + "EXCEPTION");
        }
        return places;
      }).toList();
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return list;
  }
}
