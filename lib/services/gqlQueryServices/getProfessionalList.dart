// ignore_for_file: file_names, constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_panchayat_flutter/services/services.dart';

class GetProfessionals {
  static const String GET_PROFESSIONALS_BY_WORK_QUERY_DOCUMENT_NAME =
      "listProfessionalByWorks";
  static const String GET_PROFESSIONAL_BY_ID_QUERY_DOCUMENT_NAME =
      "getProfessional";

  final String getProfessionalsByWorkQueryDocument = '''
  query listProfessionalByWorks(\$between: [String], \$workSpecialityId: ID!) {
  listProfessionalByWorks(geoHash: {between: \$between}, workSpecialityId: \$workSpecialityId) {
    items {    
      professional {
        id
        mobileNumber
        occupationName
        occupationId
        shopDescription
        shopLocation {
          lat
          lon
        }
        shopName
        totalReviews
        totalStars
        whatsappNumber
        workExperience
        workImages
        shopAddressLine
        workSpeciality
        workSpecialityId
        user {
          image
          name
          homeAdressName
        }
        reviews {
          items {
            imageURL
            userId
            user {
              image
              name
              area
            }
          }
        }
      }
    }
  }
}
  ''';

  final String getProfessionalByIdQueryDocument = '''
    query getProfessional(\$id: ID!) { getProfessional(id: \$id) {
        geoHash
        id
        mobileNumber
        occupationId
        occupationName
        shopDescription
        shopName
        shopAddressLine
        shopLocation {
          lat
          lon
        }
        totalReviews
        totalStars
        whatsappNumber
        workExperience
        workImages
        workSpeciality
        workSpecialityId
        user {
          image
          name
        }
      }
    }
''';

  Future<List<Professional>> getProfessionalsByWork(
      {@required String workSpecialityId,
      @required List<String> geoHashBound}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'workSpecialityId': workSpecialityId,
        'between': geoHashBound
      };

      response = await RunQuery.runQuery(
          operationName: GET_PROFESSIONALS_BY_WORK_QUERY_DOCUMENT_NAME,
          mutationDocument: getProfessionalsByWorkQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      if (body["data"] == null) return null;
      List professionals = body["data"]["listProfessionalByWorks"]["items"];
      List<Professional> allProfessionalsInArea = [];
      if (professionals != null && professionals.isNotEmpty) {
        for (int i = 0; i < professionals.length; i++) {
          Professional professional =
              Professional.fromJson(professionals[i]["professional"]);
          if (professional.id == Services.globalDataNotifier.localUser.id)
            continue;
          allProfessionalsInArea.add(professional);
        }
      }
      return allProfessionalsInArea;
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      print("Error in getting Professional");
    }
    return <Professional>[];
  }

  Future<Professional> getProfessionalById({@required String id}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {'id': id};

      response = await RunQuery.runQuery(
          operationName: GET_PROFESSIONAL_BY_ID_QUERY_DOCUMENT_NAME,
          mutationDocument: getProfessionalByIdQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      // print(body);
      Map<String, dynamic> professionalAsJson = body["data"]["getProfessional"];
      if (professionalAsJson != null) {
        Professional professional = Professional.fromJson(professionalAsJson);
        return professional;
      }
      return null;
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      print("Error in getting Professional By Id");
    }
    return null;
  }
}
