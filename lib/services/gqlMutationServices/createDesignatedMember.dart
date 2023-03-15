// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names, avoid_print, curly_braces_in_flow_control_structures

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/enum/designatedUserDesignation.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/models/DesignatedUserType.dart';
import 'dart:convert';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';

class CreateDesignatedUser {
  final createDesignatedUserDocument = '''
 mutation CreateDesignatedUser(\$designation: DesignatedUserStatusDesignation!, \$id: ID!, \$identifier_1: String!, \$identifier_2: String!, \$pincode: String!, \$status: DesignatedUserStatus!, \$type: DesignatedUserType!, \$updatedAt: AWSDateTime, \$identifier_1_id: String,\$identifier_2_id: String) {
  createDesignatedUser(input: {designation: \$designation, id: \$id, identifier_1: \$identifier_1, identifier_2: \$identifier_2, pincode: \$pincode, status: \$status, type: \$type, updatedAt: \$updatedAt, identifier_1_id: \$identifier_1_id, identifier_2_id: \$identifier_2_id}) {
    designation
  }
}


''';
  static const String CREATE_DESIGNATED_USER_OPERATION_NAME =
      'CreateDesignatedUser';

  Future<void> createDesignatedUser({
    @required String identifier_1,
    @required String identifier_2,
    @required String identifier_1_id,
    @required String identifier_2_id,
    @required String pincode,
    @required String id,
    @required DesignatedUserType type,
    @required DesignatedUserDesignation designation,
    @required DesignatedUserStatus status,
  }) async {
    try {
      Map<String, dynamic> variables = {
        'identifier_1': identifier_1,
        'identifier_2': identifier_2,
        'identifier_1_id': identifier_1_id,
        'identifier_2_id': identifier_2_id,
        'pincode': pincode,
        'id': id,
        'type': type.toString().split('.').last,
        'designation': designation.toString().split('.').last,
        'status': status.toString().split('.').last,
      };
      print(variables);
      http.Response response = await RunQuery.runQuery(
          operationName: CREATE_DESIGNATED_USER_OPERATION_NAME,
          mutationDocument: createDesignatedUserDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      print(body);

      if (body['data']['createDesignatedUser'] == null)
        throw Exception(["designated user not created"]);
      // postDataWithReaction.getReaction.version =
      //     body['data']['createDesignatedUser']['version'];
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
