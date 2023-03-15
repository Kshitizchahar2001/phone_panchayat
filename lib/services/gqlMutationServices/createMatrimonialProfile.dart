// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_profile_data.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/services/services.dart';

class CreateMatrimonialProfile {
  static const String CREATE_MATRIMONIAL_PROFILE_OPERATION_NAME =
      'createMatrimonialProfile';

  static const String UPDATE_MATRIMONIAL_PROFILE_OPERATION_NAME =
      'updateMatrimonialProfile';

  static const String UPDATE_MATRIMONIAL_IMAGES_OPERATION_NAME =
      'updateMatrimonialProfile';

  static const String UPDATE_MATRIMONIAL_PROFILE_IMAGE_OPERATION_NAME =
      'updateMatrimonialProfile';

  final createMatrimonailProfileMutationDocument =
      '''mutation createMatrimonialProfile(\$caste: String, \$dateOfBirth: AWSDate, \$gender: Gender, \$gotre: Gotre, \$id: ID!, \$lookingFor: LookingFor, \$name: String,\$images: [String], \$maritalStatus: MaritalStatus, \$education: Education, \$profileImage:String) {
  createMatrimonialProfile(input: {id: \$id, gotre: \$gotre, gender: \$gender, dateOfBirth: \$dateOfBirth, caste: \$caste, lookingFor: \$lookingFor, name: \$name,images: \$images, education: \$education, maritalStatus: \$maritalStatus, profileImage: \$profileImage}) {
    caste
    dateOfBirth
    gender
    gotre
    id
    lookingFor
    name
    education
    maritalStatus
    profileImage
  }
}
''';

  final updateMatrimonailProfileMutationDocument =
      '''mutation updateMatrimonialProfile(\$caste: String, \$district_id: ID, \$education: Education, \$gotre: Gotre, \$height: String,  \$id: ID!, \$maritalStatus: MaritalStatus, \$name: String, \$occupation: String, \$state_id: ID,  \$profileFor: ProfileFor, \$total: Int!, \$married: Int!, \$rashi: Rashi,   \$mobileNumber: String,    \$married1: Int!, \$total1: Int!) {
  updateMatrimonialProfile(input: {caste: \$caste, district_id: \$district_id, education: \$education, gotre: \$gotre, height: \$height, id: \$id, maritalStatus: \$maritalStatus, mobileNumber: \$mobileNumber, name: \$name, occupation: \$occupation, profileFor: \$profileFor, rashi: \$rashi, sisters: {married: \$married, total: \$total}, state_id: \$state_id, brothers: {married: \$married1, total: \$total1}}) {
    brothers {
      married
      total
    }
    caste
    createdAt
    dateOfBirth
    district_id
    district_place {
      name_hi
      name_en
      id
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
    user {
      id
    }
  }
}
''';

  final updateMatrimonailImagesMutationDocument =
      '''mutation updateMatrimonialProfile( \$id: ID!, \$images: [String]) {
  updateMatrimonialProfile(input: { id: \$id, images: \$images}) {
    id
    images
  }
}
''';

  final updateMatrimonailProfileImageMutationDocument =
      '''mutation updateMatrimonialProfile( \$id: ID!, \$profileImage: String) {
  updateMatrimonialProfile(input: { id: \$id, profileImage: \$profileImage}) {
    id
    profileImage
  }
}
''';

  Future<bool> createMatrimonialProfile(
      {@required CreateMatrimonialProfileData matrimonialProfile}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'id': Services.globalDataNotifier.localUser.id,
        'gender': enumToString(matrimonialProfile.gender.value),
        'gotre': enumToString(matrimonialProfile.gotre),
        'caste': matrimonialProfile.caste,
        'name': matrimonialProfile.name,
        'profileImage': matrimonialProfile.image,
        'lookingFor': enumToString(matrimonialProfile.lookingFor),
        'maritalStatus': enumToString(matrimonialProfile.maritalStatus),
        'education': enumToString(matrimonialProfile.education)
      };

      if (matrimonialProfile.dateOfBirth != null) {
        variables.addEntries({
          "dateOfBirth": TemporalDate(matrimonialProfile.dateOfBirth).toString()
        }.entries);
      }
      response = await RunQuery.runQuery(
          operationName: CREATE_MATRIMONIAL_PROFILE_OPERATION_NAME,
          mutationDocument: createMatrimonailProfileMutationDocument,
          variables: variables);

      var body = jsonDecode(response.body);

      if (body["data"]['createMatrimonialProfile'] == null) return false;

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateMatrimonialProfile(
      {@required UpdateMatrimonialProfileData profile}) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_MATRIMONIAL_PROFILE_OPERATION_NAME,
          mutationDocument: updateMatrimonailProfileMutationDocument,
          variables: {
            'id': profile.id,
            'caste': profile.caste,
            'mobileNumber': profile.mobileNumber,
            'district_id': profile.district_id,
            'education': enumToString(profile.education),
            'state_id': profile.state_id,
            'married': profile.sisters.married,
            'total': profile.sisters.total,
            'married1': profile.brothers.married,
            'total1': profile.brothers.total,
            'gotre': enumToString(profile.gotre),
            'height': profile.height,
            'maritalStatus': enumToString(profile.maritalStatus),
            'name': profile.name,
            'profileFor': enumToString(profile.profileFor),
            'rashi': enumToString(profile.rashi),
            'occupation': profile.occupation
          });
      var body = jsonDecode(response.body);
      if (body["data"]['updateMatrimonialProfile'] == null) return false;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateMatrimonialImages(
      {@required String id, @required List<String> imageList}) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_MATRIMONIAL_IMAGES_OPERATION_NAME,
          mutationDocument: updateMatrimonailImagesMutationDocument,
          variables: {
            'id': id,
            'images': imageList,
          });
      var body = jsonDecode(response.body);
      if (body["data"]['updateMatrimonialProfile'] == null) return false;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateMatrimonialProfileImage(
      {@required String id, @required String image}) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: UPDATE_MATRIMONIAL_PROFILE_IMAGE_OPERATION_NAME,
          mutationDocument: updateMatrimonailProfileImageMutationDocument,
          variables: {
            'id': id,
            'profileImage': image,
          });
      var body = jsonDecode(response.body);
      if (body["data"]['updateMatrimonialProfile'] == null) return false;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
