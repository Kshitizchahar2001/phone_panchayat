// ignore_for_file: file_names, constant_identifier_names, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String userPropertiesList = '''
    aadharNumber
    area
    canCreatePost
    createdAt
    dateOfBirth
    designation
    homeAdressName
    id
    gender
    image
    mobileNumber
    name
    pincode
    updatedAt
    version
    deviceToken
    homeAdressLocation {
      lat
      lon
    }
    aadhaarImageUrl
    isUserVerified
    gender
    community {
      id
      name
    }
    communityId
    referrerId
    totalPoints
    claimedPoints
    balancePoints
    raisedClaimRequest
    totalReferrals
    isDesignatedUser
    type
    identifier_1
    identifier_2
    identifier_1_pincode
    retentionPeriodComplete
    onHoldPoints
    tag
    state_id
    district_id
    place_1_id
    place_2_id
    state_place {
      id
      name_en
      name_hi
      tag {
        id
        name
      }
      type
    }
    district_place {
      id
      name_en
      name_hi
      type
    }
    place_1_place {
      id
      name_en
      name_hi
      type
    }
    place_2_place {
      id
      name_en
      name_hi
      type
    }
    additionalTehsils {
      items {
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
        }
      }
    }
    subscriptionPlan
    subscriptionPlanList
    isMatrimonialProfileComplete
    subscription{
      items{
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

class GetUserById {
  static const String GET_USER_BY_ID_OPERATION_NAME = 'GetUserById';
  final String getUserByIdQueryDocument = ''' query GetUserById(\$id: ID !) {
  getUser(id: \$id) {
    $userPropertiesList
  }
}

''';

  Future<bool> getUserById(
      {@required GlobalDataNotifier notifierService,
      @required FirebaseMessagingService messagingService,
      @required String usernameOfLoggedInUser}) async {
    http.Response response;
    var body;
    Map<String, dynamic> variables = {
      'id': usernameOfLoggedInUser,
    };
    try {
      response = await RunQuery.runQuery(
          operationName: GET_USER_BY_ID_OPERATION_NAME,
          mutationDocument: getUserByIdQueryDocument,
          variables: variables);
      body = jsonDecode(response.body);

      if (body['data']['getUser'] == null) {
        return false;
      }

      User localUser = User.fromJson(body['data']['getUser']);

      notifierService.setUserData(localUser);

      messagingService.setCurrentRegisteredUser = localUser;
      messagingService.setUserVersion = body['data']['getUser']['version'];
      CheckForPremiumUser.additionalTehsilSubscriptionFailure(localUser);
      // print('****************************************************remote token **${body['data']['getUser']['deviceToken']}');
      // print('****************************************************${messagingService.getUpToDateDeviceToken}');

      FirebaseCrashlytics.instance.setUserIdentifier(localUser.id);

      if (messagingService.getUpToDateDeviceToken == null)
        await messagingService.initialiseDeviceToken();

      if (messagingService.getUpToDateDeviceToken !=
          body['data']['getUser']['deviceToken']) {
        messagingService.runMutationForTokenUpdate();
      }
      print(body['data']['getUser']);
      print(body["data"]["getUser"]["subscription"]);
      return true;
    } catch (e, s) {
      FirebaseCrashlytics.instance.log(
        e.toString() +
            body.toString() +
            variables.toString() +
            response.body.toString(),
      );
      FirebaseCrashlytics.instance.recordError(
          e.toString() +
              body.toString() +
              variables.toString() +
              response.body.toString(),
          s);
      print(e.toString() + body.toString() + variables.toString());

      FirebaseCrashlytics.instance.recordError(
        e,
        s,
        information: [
          DiagnosticsNode.message("body : $body"),
          DiagnosticsNode.message("variables : $variables"),
        ],
      );

      print(e);
    }
    return false;
  }

  Future<GetUserQueryData> getUserData({@required String id}) async {
    http.Response response;
    var body;
    Map<String, dynamic> variables = {
      'id': id,
    };
    try {
      response = await RunQuery.runQuery(
          operationName: GET_USER_BY_ID_OPERATION_NAME,
          mutationDocument: getUserByIdQueryDocument,
          variables: variables);
      body = jsonDecode(response.body);
      if (body['data']['getUser'] == null) {
        return GetUserQueryData(success: false);
      }
      User user = User.fromJson(body['data']['getUser']);

      return GetUserQueryData(
        success: true,
        user: user,
        version: body['data']['getUser']['version'],
      );
    } catch (e, s) {
      print(response.body);

      FirebaseCrashlytics.instance.recordError(
          e.toString() +
              body.toString() +
              variables.toString() +
              response.body.toString(),
          s);
    }
    return GetUserQueryData(success: false);
  }
}

class GetUserQueryData {
  User user;
  int version;
  bool success;
  GetUserQueryData({
    @required this.success,
    this.user,
    this.version,
  });
}
