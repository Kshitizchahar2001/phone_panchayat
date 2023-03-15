// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetMatrimonialProfile {
  static const String GET_MATRIMONIAL_PROFILE_DOCUMENT_NAME =
      "getMatrimonialProfile";

  final String getMatrimonialProfileQueryDocument = '''
  query getMatrimonialProfile(\$id: ID!) {
  getMatrimonialProfile(id: \$id) {
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
    }
  }
''';

  Future<MatrimonialProfile> getMatrimonialProfile(
      {@required String id}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'id': id,
      };

      response = await RunQuery.runQuery(
          operationName: GET_MATRIMONIAL_PROFILE_DOCUMENT_NAME,
          mutationDocument: getMatrimonialProfileQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      print(body);
      if (body["data"] == null) return null;
      var profile = body["data"]["getMatrimonialProfile"];

      if (profile == null) return null;

      MatrimonialProfile userProfile = MatrimonialProfile.fromJson(profile);

      return userProfile;

      ///
      ///Handle the response
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }
}
