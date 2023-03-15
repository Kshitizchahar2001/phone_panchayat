// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateUserDeviceToken {
  static const String UPDATE_USER_DEVICE_TOKEN_OPERATION_NAME =
      'UpdateUserDeviceToken';
  final updateUserDeviceTokenDocument =
      '''mutation UpdateUserDeviceToken(\$id: ID! , \$expectedVersion: Int! , \$deviceToken: String ) {
  updateUser(input: {id: \$id, expectedVersion: \$expectedVersion, deviceToken: \$deviceToken}) {
    version
  }
}
''';

  updateToken({
    @required String userId,
    @required String deviceToken,
    @required int expectedVersion,
    @required FirebaseMessagingService messagingService,
  }) async {
    // print('update device token ********************************');
    // runMutation(
    //     operationName: UPDATE_USER_DEVICE_TOKEN_OPERATION_NAME,
    //     mutationDocument: updateUserDeviceTokenDocument,
    //     variables: {
    // 'id': userId,
    // 'expectedVersion': expectedVersion,
    // 'deviceToken': deviceToken,
    //     });
    http.Response response;

    try {
      Map<String, dynamic> variables = {
        'id': userId,
        'expectedVersion': expectedVersion,
        'deviceToken': deviceToken,
      };

      response = await RunQuery.runQuery(
          operationName: UPDATE_USER_DEVICE_TOKEN_OPERATION_NAME,
          mutationDocument: updateUserDeviceTokenDocument,
          variables: variables);

      var body = jsonDecode(response.body);
      if (body['data']['updateUser'] == null) {
        return null;
      }
      int version = body['data']['updateUser']['version'];
      messagingService.setUserVersion = version;
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
