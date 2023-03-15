// ignore_for_file: file_names, constant_identifier_names

import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/matrimonialRequestStatus.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;


class CreateMatrimonialFollowRequest {
  static const String CREATE_MATRIMONIAL_FOLLOW_REQUEST_OPERATION_NAME =
      'createMatrimonialFollowRequest';

  final createMatrimonialFollowRequestMutationDocument = ''' 
      mutation createMatrimonialFollowRequest(\$status: MatrimonialRequestStatus, \$responderId: ID!, \$requesterId: ID!) {
  createMatrimonialFollowRequest(input: {requesterId: \$requesterId, responderId: \$responderId, status: \$status}) {
    requesterId
    requesterProfile {
      id
    }
    responderId
    responderProfile {
      id
    }
    status
  }
}
''';

  static const String UPDATE_MATRIMONIAL_FOLLOW_REQUEST_OPERATION_NAME =
      'updateMatrimonialFollowRequest';

  final updateMatrimonialFollowRequestMutationDocument = ''' 
      mutation updateMatrimonialFollowRequest(\$requesterId: ID!, \$responderId: ID!, \$status: MatrimonialRequestStatus = APPROVED, \$updatedAt: AWSDateTime) {
  updateMatrimonialFollowRequest(input: {requesterId: \$requesterId, responderId: \$responderId, updatedAt: \$updatedAt, status: \$status}) {
    createdAt
    requesterId
    responderId
    status
    updatedAt
  }
}
''';

  Future<bool> createFollowRequest(
      {@required String requesterId,
      @required String responderId,
      MatrimonialRequestStatus status =
          MatrimonialRequestStatus.PENDING}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'requesterId': requesterId,
        'responderId': responderId,
        'status': enumToString(status),
      };

      response = await RunQuery.runQuery(
          operationName: CREATE_MATRIMONIAL_FOLLOW_REQUEST_OPERATION_NAME,
          mutationDocument: createMatrimonialFollowRequestMutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);

      if (body["data"]['createMatrimonialFollowRequest'] == null) return false;

      return true;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return false;
    }
  }

  Future<bool> updateFollowRequest(
      {@required String requesterId,
      @required String responderId,
      MatrimonialRequestStatus status = MatrimonialRequestStatus.APPROVED,
      TemporalDateTime updatedAt}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'requesterId': requesterId,
        'responderId': responderId,
        'status': enumToString(status),
        'updatedAt': updatedAt
      };

      response = await RunQuery.runQuery(
          operationName: UPDATE_MATRIMONIAL_FOLLOW_REQUEST_OPERATION_NAME,
          mutationDocument: updateMatrimonialFollowRequestMutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);

      if (body["data"]['updateMatrimonialFollowRequest'] == null) return false;

      return true;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return false;
    }
  }
}
