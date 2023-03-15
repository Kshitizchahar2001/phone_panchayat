// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/ProfessionalReviews.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetProfessionalReviews {
  static const String GET_PROFESSIONAL_REVIEWS_BY_WORK_QUERY_DOCUMENT_NAME =
      "getReviewsByCreatedTime";

  final String getProfessionalReviewsByWorkQueryDocument = '''
  query getReviewsByCreatedTime(\$professionalId: ID = "") {
  getReviewsByCreatedTime(professionalId: \$professionalId) {
    items {
      content
      rating
      createdAt
      imageURL
      professionalId
      status
      userId
      user {
        id
        name
        image
      }
    }
  }
}

  ''';

  Future<List<ProfessionalReviews>> getProfessionalReviews(
      {@required professionalId}) async {
    http.Response response;
    try {
      Map<String, dynamic> variables = {
        'professionalId': professionalId,
      };

      response = await RunQuery.runQuery(
          operationName: GET_PROFESSIONAL_REVIEWS_BY_WORK_QUERY_DOCUMENT_NAME,
          mutationDocument: getProfessionalReviewsByWorkQueryDocument,
          variables: variables);
      var body = jsonDecode(response.body);
      print(body);
      if (body["data"] == null) return null;
      List reviews = body["data"]["getReviewsByCreatedTime"]["items"];
      List<ProfessionalReviews> allReviews = [];
      if (reviews != null && reviews.isNotEmpty) {
        for (var review in reviews) {
          ProfessionalReviews professionalReview =
              ProfessionalReviews.fromJson(review);
          allReviews.add(professionalReview);
        }
      }
      return allReviews;
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
      print("Error in getting Professional");
    }
    return <ProfessionalReviews>[];
  }
}
