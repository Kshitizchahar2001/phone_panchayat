// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';

class CreateAndUpdateProfessional {
  final createProfessionalDocument =
      '''mutation createProfessional(\$workExperience: String, \$shopAddressLine: String, \$workSpecialityId: [String]!,\$workImages: [String], \$workSpeciality1: [String], \$whatsappNumber: String, \$totalStars: Int = 0, \$totalReviews: Int = 0, \$shopName: String, \$occupationName: String, \$occupationId: String!, \$mobileNumber: String, \$id: ID!, \$geoHash: String!, \$shopLocation: LocationInput!, \$shopDescription: String) {
  createProfessional(input: {geoHash: \$geoHash,workExperience: \$workExperience,shopAddressLine: \$shopAddressLine, workImages: \$workImages, id: \$id, mobileNumber: \$mobileNumber, occupationId: \$occupationId, occupationName: \$occupationName, shopName: \$shopName, totalReviews: \$totalReviews, totalStars: \$totalStars, whatsappNumber: \$whatsappNumber, workSpeciality: \$workSpeciality1, workSpecialityId: \$workSpecialityId, shopLocation: \$shopLocation, shopDescription: \$shopDescription}){
    id
  }
}
''';

  final updateProfessionalProfileDocument = '''
mutation updateProfessional(\$shopLocation: LocationInput, \$geoHash: String, \$id: ID!,  \$occupationId: String, \$occupationName: String, \$shopAddressLine: String, \$shopDescription: String, \$shopName: String,  \$whatsappNumber: String, \$workExperience: String, \$workImages: [String], \$workSpeciality: [String], \$workSpecialityId: [String]) {
  updateProfessional(input: {id: \$id, geoHash: \$geoHash, occupationId: \$occupationId, occupationName: \$occupationName, shopAddressLine: \$shopAddressLine, shopDescription: \$shopDescription, shopLocation: \$shopLocation, shopName: \$shopName,  whatsappNumber: \$whatsappNumber, workImages: \$workImages, workSpeciality: \$workSpeciality, workSpecialityId: \$workSpecialityId, workExperience: \$workExperience}) {
    id
  }
}
''';

  static const String CREATE_PROFESSIONAL_OPERATION_NAME = 'createProfessional';
  static const String UPDATE_PROFESSIONAL_PROFILE_OPERATION_NAME =
      'updateProfessional';

  Future<bool> createProfessionalInDatabase(
      {@required Professional professional}) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: CREATE_PROFESSIONAL_OPERATION_NAME,
          mutationDocument: createProfessionalDocument,
          variables: {
            'id': professional.id,
            'geoHash': professional.geoHash,
            'whatsappNumber': professional.whatsappNumber,
            'mobileNumber': professional.mobileNumber,
            'occupationName': professional.occupationName,
            'occupationId': professional.occupationId,
            'workSpecialityId': professional.workSpecialityId,
            'workSpeciality1': professional.workSpeciality,
            'shopLocation': professional.shopLocation.toJson(),
            'shopDescription': professional.shopDescription,
            'shopName': professional.shopName,
            'workExperience': professional.workExperience,
            'workImages': professional.workImages,
            'shopAddressLine': professional.shopAddressLine,
            'totalStars': professional.totalStars,
            'totalReviews': professional.totalReviews,
          });
      var body = jsonDecode(response.body);
      if (body["data"]['createProfessional'] == null) return false;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateProfessional({@required Professional professional}) async {
    http.Response response;
    print(professional.workSpecialityId);
    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_PROFESSIONAL_PROFILE_OPERATION_NAME,
          mutationDocument: updateProfessionalProfileDocument,
          variables: {
            'id': professional.id,
            'geoHash': professional.geoHash,
            'mobileNumber': professional.mobileNumber,
            'whatsappNumber': professional.whatsappNumber,
            'totalStars': professional.totalStars,
            'totalReviews': professional.totalReviews,
            'occupationName': professional.occupationName,
            'occupationId': professional.occupationId,
            'workSpecialityId': professional.workSpecialityId,
            'workSpeciality': professional.workSpeciality,
            'shopLocation': professional.shopLocation.toJson(),
            'shopDescription': professional.shopDescription,
            'shopName': professional.shopName,
            'workExperience': professional.workExperience,
            'workImages': professional.workImages,
            'shopAddressLine': professional.shopAddressLine
          });
      var body = jsonDecode(response.body);
      print(body);
      if (body["data"]['updateProfessional'] == null) return false;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
