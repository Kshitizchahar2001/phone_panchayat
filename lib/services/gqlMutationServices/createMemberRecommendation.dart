// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/enum/designatedUserDesignation.dart';
import 'package:online_panchayat_flutter/models/DesignatedUserType.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';

class CreateMemberRecommendation {
  final createMemberRecommendationQueryDocument = '''
mutation CreateMemberRecommendation(\$designation: DesignatedUserStatusDesignation!, \$district: String!, \$electedMemberName: String!, \$electedMemberPhoneNumber: String!, \$id: ID, \$identifier_1: String!, \$identifier_2: String!,\$type: DesignatedUserType!, \$userId: ID!) {
  createMemberRecommendation(input: {designation: \$designation, district: \$district, electedMemberName: \$electedMemberName, electedMemberPhoneNumber: \$electedMemberPhoneNumber, id: \$id, identifier_1: \$identifier_1, identifier_2: \$identifier_2, type: \$type, userId: \$userId}) {
    createdAt
  }
}

''';

  static const String CREATE_MEMBER_RECOMMENDATION_OPERATION_NAME =
      'CreateMemberRecommendation';

  Future<bool> createMemberRecommendation({
    @required String userId,
    @required String electedMemberName,
    @required String electedMemberPhoneNumber,
    @required DesignatedUserDesignation designation,
    @required String district,
    @required DesignatedUserType type,
    @required String identifier_1,
    @required String identifier_2,
  }) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: CREATE_MEMBER_RECOMMENDATION_OPERATION_NAME,
          mutationDocument: createMemberRecommendationQueryDocument,
          variables: {
            'userId': userId,
            'electedMemberName': electedMemberName,
            'electedMemberPhoneNumber': electedMemberPhoneNumber,
            'designation': designation.toString().split('.').last,
            'district': district,
            'type': type.toString().split('.').last,
            'identifier_1': identifier_1,
            'identifier_2': identifier_2,
          });

      var body = json.decode(response.body);
      bool success;
      try {
        success =
            body['data']['createMemberRecommendation']['createdAt'] != null;
      } catch (e) {
        success = false;
      }
      print(body);
      return success;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return false;
    }
  }
}
