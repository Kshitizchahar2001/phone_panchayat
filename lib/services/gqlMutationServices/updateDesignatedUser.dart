// ignore_for_file: file_names, constant_identifier_names, avoid_print, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/DesignatedUserData/designatedUserData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;

class UpdateDesignatedUser {
  static const String UPDATE_REACTION_OPERATION_NAME = 'UpdateDesignatedUser';
  final updateDesignatedUserMutationDocument =
      '''mutation UpdateDesignatedUser(\$id: ID! , \$expectedVersion: Int!, \$status: DesignatedUserStatus, \$updatedAt: AWSDateTime) {
  updateDesignatedUser(input: {id: \$id, expectedVersion: \$expectedVersion, status: \$status,updatedAt: \$updatedAt}) {
    designation
    createdAt
  }
}
''';

  updateDesignatedUser({
    @required String id,
    @required DesignatedUserStatus designatedUserStatus,
    @required DesignatedUserData designatedUserData,
    // @required updatedAt, //
  }) async {
    try {
      http.Response response = await RunQuery.runQuery(
          operationName: UPDATE_REACTION_OPERATION_NAME,
          mutationDocument: updateDesignatedUserMutationDocument,
          variables: {
            'id': id,
            'expectedVersion': designatedUserData.version,
            'status': designatedUserStatus.toString().split('.').last,
            'updatedAt': designatedUserData.designatedUser.updatedAt.toString(),
          });
      var body = jsonDecode(response.body);
      print(body);
      if (body['data']['updateDesignatedUser'] == null)
        throw Exception([
          "User tried to update like too frequently",
          "Two updateDesignatedUser mutations with same version number"
        ]);
      designatedUserData.version =
          body['data']['updateDesignatedUser']['version'];
      // print("new version is ${postData.getReaction.version}");
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
