// ignore_for_file: file_names, constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/enum/maritalStatus.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_panchayat_flutter/services/services.dart';

class GetMatchesByGender {
  static const String GET_MATCHES_BY_GENDER_DOCUMENT_NAME =
      "getMatchesByGenderAndMaritalStatus";

  final String getMatchesByGenderQueryDocument = '''
  query getMatchesByGenderAndMaritalStatus(\$gender: Gender!, \$nextToken: String, \$limit: Int = 100,\$eq: String) {
  getMatchesByGenderAndMaritalStatus(gender: \$gender, nextToken: \$nextToken, limit: \$limit, maritalStatus: {eq: \$eq}) {
    items {
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
      state_place {
        id
        name_en
        name_hi
      }
    }
    nextToken
  }
}
  ''';

  Future<Map<String, dynamic>> getMatchesByGenderAndMaritalStatus(
      {@required Gender gender,
      MaritalStatus maritalStatus,
      String nextToken}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'gender': gender.toString().split(".").last,
      };

      if (maritalStatus != null)
        variables.addAll({'eq': maritalStatus.toString().split(".").last});

      if (nextToken != null) variables.addAll({'nextToken': nextToken});

      response = await RunQuery.runQuery(
          operationName: GET_MATCHES_BY_GENDER_DOCUMENT_NAME,
          mutationDocument: getMatchesByGenderQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      print(body);
      if (body["data"] == null) return null;
      List matches =
          body["data"]["getMatchesByGenderAndMaritalStatus"]["items"];

      List<MatrimonialProfile> allMatches = [];
      if (matches != null && matches.isNotEmpty) {
        for (int i = 0; i < matches.length; i++) {
          MatrimonialProfile match = MatrimonialProfile.fromJson(matches[i]);
          if (match.id == Services.globalDataNotifier.localUser.id) continue;
          allMatches.add(match);
        }

        return {
          "matches": allMatches,
          "nextToken": body["data"]["getMatchesByGenderAndMaritalStatus"]
              ["nextToken"]
        };
      }

      return null;
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      print("Error in getting MatchesByGender");
      return null;
    }
  }
}
