// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceService.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;


class CreateNewUser {
  static const String CREATE_USER_OPERATION_NAME = 'CreateNewUser';

  final createUserMutationDocument =
      ''' mutation CreateNewUser(\$designation: String , \$aadharNumber: String , \$area: String! , \$dateOfBirth: AWSDate, \$homeAdressLocation: LocationInput!, \$homeAdressName: String, \$id: ID, \$image: String, \$mobileNumber: String , \$name: String , \$pincode: String!, \$gender: Gender,\$deviceToken: String, \$referrerId: ID, \$tag: ID, \$state_id: ID, \$district_id: ID) {
  createUser(
    input: {name: \$name, image: \$image, homeAdressLocation: \$homeAdressLocation, designation: \$designation, mobileNumber: \$mobileNumber, aadharNumber: \$aadharNumber, homeAdressName: \$homeAdressName, dateOfBirth: \$dateOfBirth, area: \$area, pincode: \$pincode, id: \$id, canCreatePost: false, gender:\$gender, deviceToken:\$deviceToken, referrerId:\$referrerId , tag: \$tag, state_id: \$state_id, district_id: \$district_id}
  ) {
    version
    name
    mobileNumber
    id
    createdAt
  }
}
''';

  Future<http.Response> createNewUser({
    @required Location homeAdressLocation,
    @required String mobileNumber,
    @required String area,
    @required String pincode,
    @required String deviceToken,
    @required String tag,
    @required String state_id,
    String district_id,
    String referrerId,
  }) async {
    http.Response response;
    Map<String, dynamic> variables = {
      'homeAdressLocation': homeAdressLocation.toJson(),
      'mobileNumber': mobileNumber,
      'area': area,
      'pincode': pincode,
      'id': mobileNumber,
      'deviceToken': deviceToken,
      'tag': tag,
      'state_id': state_id,
    };

    if (referrerId != null) {
      variables.addEntries({"referrerId": referrerId}.entries);
    }

    if (district_id != null) {
      variables.addEntries({
        "district_id": district_id,
      }.entries);
    }

    response = await RunQuery.runQuery(
            operationName: CREATE_USER_OPERATION_NAME,
            mutationDocument: createUserMutationDocument,
            variables: variables)
        .whenComplete(() async {
      StoreGlobalData.refereeId = null;
      // StoreGlobalData.deepLink = null;
      await SharedPreferenceService.removeRefereeId();
    });
    return response;
  }
}
