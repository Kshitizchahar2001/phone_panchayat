// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/matrimonialRequestStatus.dart';
import 'package:online_panchayat_flutter/models/MatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetMatrimonialFollowRequest {
  static const String
      GET_FOLLOW_REQUEST_BY_REQUESTER_AND_RESPONDER_OPERATION_NAME =
      'getMatrimonialFollowRequest';

  final String getFollowRequestByRequesterAndResponderQueryDocument = ''' 
query getMatrimonialFollowRequest(\$requesterId: ID!, \$responderId: ID!) {
  getMatrimonialFollowRequest(requesterId: \$requesterId, responderId: \$responderId) {
    createdAt
    requesterId
    responderId
    status
    updatedAt
  }
}
  ''';

  static const String
      GET_FOLLOW_REQUEST_BY_REQUESTER_AND_STATUS_OPERATION_NAME =
      'getFollowRequestByRequesterIdAndStatus';

  final String getFollowRequestByRequesterAndStatusQueryDocument = ''' 
  query getFollowRequestByRequesterIdAndStatus(\$limit: Int = 100, \$nextToken: String, \$requesterId: ID!, \$status: MatrimonialRequestStatus) {
  getFollowRequestByRequesterIdAndStatus(nextToken: \$nextToken, limit: \$limit, requesterId: \$requesterId, statusUpdatedAt: {beginsWith: {status: \$status}}) {
    nextToken
    items {
      createdAt
      requesterId
      responderId
      status
      updatedAt
      responderProfile {
        caste
        createdAt
        dateOfBirth
        district_id
        brothers {
          married
          total
        }
        district_place {
          id
          name_en
          name_hi
        }
        education
        gender
        gotre
        height
        id
        images
        isPaymentComplete
        lookingFor
        maritalStatus
        mobileNumber
        name
        occupation
        profileFor
        profileImage
        rashi
        sisters {
          married
          total
        }
        state_id
        state_place {
          id
          name_en
          name_hi
        }
        updatedAt
      }
    }
  }
}
  ''';

  static const String
      GET_FOLLOW_REQUEST_BY_RESPONDER_AND_STATUS_OPERATION_NAME =
      'getFollowRequestByResponderIdAndStatus';

  final String getFollowRequestByResponderAndStatusQueryDocument = ''' 
  query getFollowRequestByResponderIdAndStatus(\$limit: Int = 100, \$nextToken: String, \$responderId: ID!, \$status: MatrimonialRequestStatus) {
  getFollowRequestByResponderIdAndStatus(limit: \$limit, nextToken: \$nextToken, responderId: \$responderId, statusUpdatedAt: {beginsWith: {status: \$status}}) {
    nextToken
    items {
      createdAt
      requesterId
      responderId
      status
      updatedAt
      requesterProfile {
        brothers {
          married
          total
        }
        caste
        createdAt
        dateOfBirth
        district_id
        district_place {
          id
          name_en
          name_hi
        }
        education
        gender
        gotre
        height
        id
        images
        isPaymentComplete
        lookingFor
        maritalStatus
        mobileNumber
        name
        occupation
        profileFor
        profileImage
        rashi
        sisters {
          married
          total
        }
        state_id
        state_place {
          id
          name_en
          name_hi
        }
        updatedAt
      }
    }
  }
}


  ''';

  Future<MatrimonialFollowRequest> getFollowRequestByRequesterAndResponder({
    @required String requesterId,
    @required String responderId,
  }) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'requesterId': requesterId,
        'responderId': responderId,
      };

      response = await RunQuery.runQuery(
          operationName:
              GET_FOLLOW_REQUEST_BY_REQUESTER_AND_RESPONDER_OPERATION_NAME,
          mutationDocument:
              getFollowRequestByRequesterAndResponderQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);

      if (body['data']['getMatrimonialFollowRequest'] != null) {
        return MatrimonialFollowRequest.fromJson(
            body['data']['getMatrimonialFollowRequest']);
      } else {
        return null;
      }
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  /// Get follow requests with the help of requester id
  /// Get full object of responder
  Future<Map<String, dynamic>> getFollowRequestByRequesterAndStatus(
      {@required String requesterId,
      @required MatrimonialRequestStatus status,
      String nextToken}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'requesterId': requesterId,
        'status': status.toString().split(".").last,
      };

      if (nextToken != null) variables.addAll({'nextToken': nextToken});

      response = await RunQuery.runQuery(
          operationName:
              GET_FOLLOW_REQUEST_BY_REQUESTER_AND_STATUS_OPERATION_NAME,
          mutationDocument: getFollowRequestByRequesterAndStatusQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      print(body);

      if (body["data"] == null) return null;
      List matches =
          body["data"]["getFollowRequestByRequesterIdAndStatus"]["items"];

      List<MatrimonialFollowRequest> allMatches = [];
      if (matches != null && matches.isNotEmpty) {
        for (int i = 0; i < matches.length; i++) {
          MatrimonialFollowRequest match =
              MatrimonialFollowRequest.fromJson(matches[i]);
          allMatches.add(match);
        }

        return {
          "requestList": allMatches,
          "nextToken": body["data"]["getFollowRequestByRequesterIdAndStatus"]
              ["nextToken"]
        };
      }
      return null;
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }

  /// Get follow requests with the help of responder id
  /// Get full object of requester
  Future<Map<String, dynamic>> getFollowRequestByResoponderAndStatus(
      {@required String responderId,
      @required MatrimonialRequestStatus status,
      String nextToken}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'responderId': responderId,
        'status': status.toString().split(".").last,
      };

      if (nextToken != null) variables.addAll({'nextToken': nextToken});

      response = await RunQuery.runQuery(
          operationName:
              GET_FOLLOW_REQUEST_BY_RESPONDER_AND_STATUS_OPERATION_NAME,
          mutationDocument: getFollowRequestByResponderAndStatusQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);

      print(body);

      if (body["data"] == null) return null;
      List matches =
          body["data"]["getFollowRequestByResponderIdAndStatus"]["items"];

      List<MatrimonialFollowRequest> allMatches = [];
      if (matches != null && matches.isNotEmpty) {
        for (int i = 0; i < matches.length; i++) {
          MatrimonialFollowRequest match =
              MatrimonialFollowRequest.fromJson(matches[i]);
          allMatches.add(match);
        }

        return {
          "requestList": allMatches,
          "nextToken": body["data"]["getFollowRequestByResponderIdAndStatus"]
              ["nextToken"]
        };
      }
      return null;
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }
}
