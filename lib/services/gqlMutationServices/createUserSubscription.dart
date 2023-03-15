// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/subscriptionType.dart';
import 'package:online_panchayat_flutter/enum/subscription_plan.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/models/UserSubscription.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;


class CreateUserSubscription {
  static const String CREATE_SUBSCRIPTION_BY_USER_OPERATION_NAME =
      'createUserSubscription';

  final createSubscriptionByUserMutationDocument =
      '''mutation createUserSubscription(\$expiryDate: AWSDateTime, \$planType: SubscriptionType, \$startDate: AWSDateTime, \$status: Status!, \$subscriptionId: String, \$subscriptionPlan: SubscriptionPlan!, \$userId: ID!) {
  createUserSubscription(input: {expiryDate: \$expiryDate, planType: \$planType, userId: \$userId, subscriptionPlan: \$subscriptionPlan, subscriptionId: \$subscriptionId, status: \$status, startDate: \$startDate}) {
    createdAt
    expiryDate
    paymentGatewayStatus
    planType
    startDate
    status
    subscriptionId
    subscriptionPlan
    updatedAt
    userId
  }
}
''';

  static const String UPDATE_SUBSCRIPTION_BY_USER_OPERATION_NAME =
      'updateUserSubscription';

  final updateSubscriptionByUserMutationDocument =
      '''mutation updateUserSubscription(\$userId: ID!, \$subscriptionPlan: SubscriptionPlan!, \$status: Status!) {
  updateUserSubscription(input: {userId: \$userId, subscriptionPlan: \$subscriptionPlan, status: \$status}) {
    createdAt
    expiryDate
    paymentGatewayStatus
    planType
    startDate
    status
    subscriptionId
    subscriptionPlan
    updatedAt
    userId
  }
}
''';

  Future<UserSubscription> createUserSubscription({
    @required String userId,
    @required SubscriptionPlan subscriptionPlan,
    @required SubscriptionType planType,
    @required Status status,
    @required String subscriptionId,
    TemporalDateTime expiryDate,
    TemporalDateTime startDate,
  }) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: CREATE_SUBSCRIPTION_BY_USER_OPERATION_NAME,
          mutationDocument: createSubscriptionByUserMutationDocument,
          variables: {
            'userId': userId,
            'subscriptionPlan': enumToString(subscriptionPlan),
            'planType': enumToString(planType),
            'status': enumToString(status),
            'subscriptionId': subscriptionId,
            'expiryDate': expiryDate,
            'startDate': startDate,
          });
      var body = jsonDecode(response.body);
      if (body["data"]['createUserSubscription'] == null) return null;
      UserSubscription subscription =
          UserSubscription.fromJson(body["data"]["createUserSubscription"]);
      return subscription;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return null;
    }
  }

  Future<bool> updateUserSubscription({
    @required String userId,
    @required SubscriptionPlan subscriptionPlan,
    @required Status status,
    @required String subscriptionId,
    TemporalDateTime expiryDate,
  }) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_SUBSCRIPTION_BY_USER_OPERATION_NAME,
          mutationDocument: updateSubscriptionByUserMutationDocument,
          variables: {
            'userId': userId,
            'subscriptionPlan': enumToString(subscriptionPlan),
            'status': enumToString(status),
            'subscriptionId': subscriptionId,
            'expiryDate': expiryDate,
          });
      var body = jsonDecode(response.body);
      if (body["data"]['updateUserSubscription'] == null) return false;
      return true;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return false;
    }
  }
}
