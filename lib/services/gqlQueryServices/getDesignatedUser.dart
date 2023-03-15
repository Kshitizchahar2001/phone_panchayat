// class GetDesignatedUser{

// ignore_for_file: file_names, constant_identifier_names, avoid_print

// }
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:online_panchayat_flutter/models/DesignatedUser.dart';

class GetDesignatedUser {
  static const String GET_DESIGNATED_USER_OPERATION_NAME = 'GetDesignatedUser';

  final String getDesignatedUserQueryDocument = ''' 
query GetDesignatedUser(\$id: ID!) {
  getDesignatedUser(id: \$id) {
    createdAt
    designation
    id
    identifier_1
    identifier_2
    pincode
    status
    type
    updatedAt
    version
    user {
      id
      name
      isUserVerified
    }
  }
}

  ''';

  Future<DesignatedUserQueryData> getDesignatedUser(
      {@required String id}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'id': id,
      };

      response = await RunQuery.runQuery(
          operationName: GET_DESIGNATED_USER_OPERATION_NAME,
          mutationDocument: getDesignatedUserQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      print(body);

      if (body['data']['getDesignatedUser'] != null) {
        DesignatedUser designatedUser =
            DesignatedUser.fromJson(body['data']['getDesignatedUser']);
        return DesignatedUserQueryData(
          success: true,
          designatedUser: designatedUser,
          userFound: true,
          isUserVerified: designatedUser.user.isUserVerified,
        );
      } else {
        return DesignatedUserQueryData(
          success: true,
          userFound: false,
        );
      }
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      return DesignatedUserQueryData(
        success: false,
      );
    }
  }
}

class DesignatedUserQueryData {
  bool success;
  DesignatedUser designatedUser;
  bool userFound;
  bool isUserVerified;
  DesignatedUserQueryData({
    @required this.success,
    this.designatedUser,
    this.userFound,
    this.isUserVerified,
  });
}
