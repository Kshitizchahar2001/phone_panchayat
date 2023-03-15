// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/AdditionalTehsil.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/services/services.dart';

class CreateAdditionalTehsil {
  final createAdditionalTehsilDocument =
      '''mutation createAdditionalTehsils(\$placeId: ID!, \$userId: ID!) {
  createAdditionalTehsils(input: {placeId: \$placeId, userId: \$userId}) {
    userId
    placeId
    updatedAt
    place {
      id
      name_en
      name_hi
      tag {
        id
      }
    }
  }
}
''';

  static const String CREATE_ADDITIONAL_TEHSIL_OPERATION_NAME =
      'createAdditionalTehsils';

  /// Creating Additional Tehsil
  Future<AdditionalTehsils> createAdditionalTehsil(
      {@required String userId, @required String placeId}) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: CREATE_ADDITIONAL_TEHSIL_OPERATION_NAME,
          mutationDocument: createAdditionalTehsilDocument,
          variables: {"placeId": placeId, "userId": userId});

      var body = json.decode(response.body);
      print(body);
      if (body['data']['createAdditionalTehsils'] != null) {
        AdditionalTehsils additonalTehsil =
            AdditionalTehsils.fromJson(body['data']['createAdditionalTehsils']);
        return additonalTehsil;
      }
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  Future<bool> addTehsilList({@required List<String> tehsilIds}) async {
    bool result = true;

    for (int i = 0; i < tehsilIds.length; i++) {
      AdditionalTehsils additionalTehsils = await createAdditionalTehsil(
          userId: Services.globalDataNotifier.localUser.id,
          placeId: tehsilIds[i]);

      if (additionalTehsils != null) {
        Services.globalDataNotifier.localUser.additionalTehsils
            .add(additionalTehsils);

        /// Updating value notifier
        Services.globalDataNotifier.additionalTehsilList.value
            .add(additionalTehsils);

        result = result && true;
      } else {
        result = false;
      }
    }
    Services.globalDataNotifier.additionalTehsilList.notifyListeners();

    return result;
  }
}
