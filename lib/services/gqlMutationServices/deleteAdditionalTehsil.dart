// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/AdditionalTehsil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class DeleteAdditionalTehsils {
  final deleteAdditionalTehsilsDocument = '''
mutation deleteAdditionalTehsils(\$placeId: ID!, \$userId: ID!) {
  deleteAdditionalTehsils(input: {placeId: \$placeId, userId: \$userId}) {
    placeId
    userId
    updatedAt
    place {
      id
      name_en
      name_hi
      tag {
        id
      }
      type
      parentId
    }
  }
}''';
  static const String DELETE_ADDITIONAL_TEHSIL_OPERATION_NAME =
      'deleteAdditionalTehsils';

  Future<AdditionalTehsils> deleteAdditionalTehsil({
    @required String userId,
    @required String placeId,
  }) async {
    try {
      http.Response response = await RunQuery.runQuery(
          operationName: DELETE_ADDITIONAL_TEHSIL_OPERATION_NAME,
          mutationDocument: deleteAdditionalTehsilsDocument,
          variables: {'placeId': placeId, 'userId': userId});
      var body = jsonDecode(response.body);
      print(body);

      if (body['data']['deleteAdditionalTehsils'] == null) return null;

      AdditionalTehsils additionalTehsil =
          AdditionalTehsils.fromJson(body['data']['deleteAdditionalTehsils']);
      return additionalTehsil;
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  Future<bool> removeAdditionalTehsilList(
      {@required List<String> tehsilIds}) async {
    bool result = true;

    for (int i = 0; i < tehsilIds.length; i++) {
      AdditionalTehsils additionalTehsils = await deleteAdditionalTehsil(
          userId: Services.globalDataNotifier.localUser.id,
          placeId: tehsilIds[i]);

      if (additionalTehsils != null) {
        Services.globalDataNotifier.localUser.additionalTehsils.removeWhere(
            (element) => element.placeId == additionalTehsils.placeId);
        Services.globalDataNotifier.additionalTehsilList.value.removeWhere(
            (element) => element.placeId == additionalTehsils.placeId);
        result = result && true;
      } else {
        result = false;
      }
    }

    Services.globalDataNotifier.additionalTehsilList.notifyListeners();

    return result;
  }
}
