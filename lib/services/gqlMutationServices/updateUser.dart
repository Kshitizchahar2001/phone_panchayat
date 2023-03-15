// ignore_for_file: file_names, constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print, non_constant_identifier_names

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/DesignatedUserType.dart';
import 'package:online_panchayat_flutter/models/Gender.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getUserById.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class UpdateUser {
  static const String UPDATE_USER_OPERATION_NAME = 'UpdateUser';

  final userProfileUpdateMutationDocument = '''
  mutation UpdateUser(\$name: String, \$image: String, \$gender: Gender, \$lat: Float!, \$lon: Float!, \$designation: String, \$id: ID!, \$expectedVersion: Int!,\$homeAdressName: String, \$dateOfBirth: AWSDate) {
  updateUser(input: {name: \$name, image: \$image, gender: \$gender, homeAdressLocation: {lat: \$lat, lon: \$lon}, designation: \$designation, id: \$id, expectedVersion: \$expectedVersion, homeAdressName: \$homeAdressName, dateOfBirth: \$dateOfBirth}) {
    $userPropertiesList
  }
}

  
  ''';

  final updateUserMutationDocument =
      '''mutation UpdateUser(\$aadharNumber: String,\$aadhaarImageUrl:String ,\$expectedVersion: Int!, \$id: ID! , \$area: String, \$canCreatePost: Boolean, \$dateOfBirth: AWSDate, \$designation: String, \$gender: Gender, \$homeAdressName: String, \$image: String, \$mobileNumber: String, \$name: String, \$pincode: String,\$communityId: ID, \$raisedClaimRequest: Boolean ,\$isUserVerified: Boolean, \$type: DesignatedUserType , \$identifier_1: String, \$identifier_2: String, \$isDesignatedUser: Boolean, \$identifier_1_pincode: String, \$retentionPeriodComplete: Boolean,\$state_id: ID,\$district_id: ID,\$place_1_id: ID,\$place_2_id:ID, \$tag: ID, \$subscriptionPlan: SubscriptionPlan, \$subscriptionPlanList: [SubscriptionPlan], \$isMatrimonialProfileComplete : Boolean) {
  updateUser(input: {id: \$id, expectedVersion: \$expectedVersion, aadharNumber: \$aadharNumber,aadhaarImageUrl:\$aadhaarImageUrl, area: \$area, canCreatePost: \$canCreatePost, dateOfBirth: \$dateOfBirth, designation: \$designation, gender: \$gender, homeAdressName: \$homeAdressName, image: \$image, mobileNumber: \$mobileNumber, name: \$name, pincode: \$pincode, communityId: \$communityId, raisedClaimRequest: \$raisedClaimRequest, isUserVerified: \$isUserVerified, type: \$type, identifier_1: \$identifier_1, identifier_2: \$identifier_2, isDesignatedUser: \$isDesignatedUser, identifier_1_pincode: \$identifier_1_pincode, retentionPeriodComplete: \$retentionPeriodComplete, state_id: \$state_id,district_id: \$district_id, place_1_id: \$place_1_id,place_2_id: \$place_2_id, tag: \$tag, subscriptionPlan: \$subscriptionPlan, subscriptionPlanList: \$subscriptionPlanList, isMatrimonialProfileComplete: \$isMatrimonialProfileComplete}) {
    $userPropertiesList
  }
}


''';

  Future<bool> updateUserAadhaar(
      {@required GlobalDataNotifier notifierService,
      @required FirebaseMessagingService messagingService,
      @required String id,
      @required String aadharNumber,
      String aadhaarImageUrl}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'aadharNumber': aadharNumber,
        'id': id,
        'expectedVersion': messagingService.userVersion,
      };

      if (aadhaarImageUrl != null)
        variables.addEntries({"aadhaarImageUrl": aadhaarImageUrl}.entries);

      response = await RunQuery.runQuery(
          operationName: UPDATE_USER_OPERATION_NAME,
          mutationDocument: updateUserMutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);
      if (body['data']['updateUser'] == null) {
        return false;
      }
      User localUser = User.fromJson(body['data']['updateUser']);
      notifierService.setUserData(localUser);
      messagingService.setUserVersion = body['data']['updateUser']['version'];
      return true;
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return false;
  }

  Future<bool> updateUserCommunity({
    @required GlobalDataNotifier notifierService,
    @required FirebaseMessagingService messagingService,
    @required String id,
    @required String communityId,
    // String aadhaarImageUrl
  }) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'communityId': communityId,
        'id': id,
        'expectedVersion': messagingService.userVersion,
      };

      response = await RunQuery.runQuery(
          operationName: UPDATE_USER_OPERATION_NAME,
          mutationDocument: updateUserMutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);
      print(body);
      if (body['data']['updateUser'] == null) {
        return false;
      }
      User localUser = User.fromJson(body['data']['updateUser']);
      notifierService.setUserData(localUser);
      messagingService.setUserVersion = body['data']['updateUser']['version'];
      return true;
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return false;
  }

  Future<void> updateUserProfile({
    @required GlobalDataNotifier notifierService,
    @required FirebaseMessagingService messagingService,
    @required String name,
    @required String image,
    @required Gender gender,
    @required String designation,
    // @required String area,
    // @required String pincode,
    @required Location homeAdressLocation,
    @required String id,
    TemporalDate dateOfBirth,
    String homeAdressName,
  }) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'name': name,
        'image': image,
        'gender': enumToString(gender),
        // 'homeAdressLocation': homeAdressLocation.toJson(),
        'lat': homeAdressLocation.lat,
        'lon': homeAdressLocation.lon,
        'designation': designation,
        // 'area': area,
        // 'pincode': pincode,
        'id': id,
        'expectedVersion': messagingService.userVersion,
      };

      if (homeAdressName != null)
        variables.addEntries({"homeAdressName": homeAdressName}.entries);
      if (dateOfBirth != null)
        variables.addEntries({"dateOfBirth": dateOfBirth.toString()}.entries);

      response = await RunQuery.runQuery(
          operationName: UPDATE_USER_OPERATION_NAME,
          mutationDocument: userProfileUpdateMutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);
      if (body['data']['updateUser'] == null) {
        return false;
      }
      print("body after updated user is $body");
      User localUser = User.fromJson(body['data']['updateUser']);
      notifierService.setUserData(localUser);
      messagingService.setUserVersion = body['data']['updateUser']['version'];
      return true;
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return false;
  }

  Future<bool> raiseClaimRequest({
    @required GlobalDataNotifier notifierService,
    @required FirebaseMessagingService messagingService,
    @required String userId,
  }) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'id': userId,
        'expectedVersion': messagingService.userVersion,
        'raisedClaimRequest': true,
      };

      response = await RunQuery.runQuery(
          operationName: UPDATE_USER_OPERATION_NAME,
          mutationDocument: updateUserMutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);
      if (body['data']['updateUser'] == null) {
        return false;
      }
      User localUser = User.fromJson(body['data']['updateUser']);
      notifierService.setUserData(localUser);
      messagingService.setUserVersion = body['data']['updateUser']['version'];
      return true;
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return false;
  }

  Future<void> verifyDesignatedUser({
    @required String id,
    @required int expectedVersion,
    @required bool isDesignatedUser,
  }) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'id': id,
        'expectedVersion': expectedVersion,
        'isDesignatedUser': isDesignatedUser,
      };

      response = await RunQuery.runQuery(
          operationName: UPDATE_USER_OPERATION_NAME,
          mutationDocument: updateUserMutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);
      if (body['data']['updateUser'] == null) {
        return false;
      }
      return true;
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return false;
  }

  Future<bool> updateUserIdentifiers({
    @required DesignatedUserType type,
    @required String state_id,
    @required String district_id,
    @required String place_1_id,
    @required String place_2_id,
  }) async {
    {
      Map<String, dynamic> variables = {
        'id': Services.globalDataNotifier.localUser.id,
        'expectedVersion': Services.firebaseMessagingService.userVersion,
        'type': type.toString().split(".").last,
        'state_id': state_id,
        'district_id': district_id,
        'place_1_id': place_1_id,
        'place_2_id': place_2_id,
      };

      return await updateUser(
        messagingService: Services.firebaseMessagingService,
        notifierService: Services.globalDataNotifier,
        variables: variables,
      );
    }
  }

  Future<bool> updateRetentionPeriodComplete(
      {@required bool retentionPeriodComplete}) async {
    Map<String, dynamic> variables = {
      'id': Services.globalDataNotifier.localUser.id,
      'expectedVersion': Services.firebaseMessagingService.userVersion,
      'retentionPeriodComplete': retentionPeriodComplete,
    };
    return await updateUser(
      messagingService: Services.firebaseMessagingService,
      notifierService: Services.globalDataNotifier,
      variables: variables,
    );
  }

  Future<bool> updateUser({
    @required Map<String, dynamic> variables,
    @required GlobalDataNotifier notifierService,
    @required FirebaseMessagingService messagingService,
  }) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_USER_OPERATION_NAME,
          mutationDocument: updateUserMutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);
      print(body);
      if (body['data']['updateUser'] == null) {
        return false;
      }
      User localUser = User.fromJson(body['data']['updateUser']);
      notifierService.setUserData(localUser);
      messagingService.setUserVersion = body['data']['updateUser']['version'];
      return true;
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return false;
  }
}
