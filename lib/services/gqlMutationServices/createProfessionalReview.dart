// ignore_for_file: file_names, constant_identifier_names, avoid_print, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/models/ProfessionalReviews.dart';
import 'package:online_panchayat_flutter/models/ReviewResult.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';

class CreateProfessionalReview {
  final createProfessionalReviewDocument =
      '''mutation createProfessionalReviews(\$userId: ID!, \$rating: Int!, \$status: Status!, \$professionalId: ID!, \$imageURL: String,  \$content: String) {
  createProfessionalReviews(input: {content: \$content,rating: \$rating, imageURL: \$imageURL, professionalId: \$professionalId, status: \$status, userId: \$userId}) {
    userId
  }
}
''';

  final updateProfessionalReviewDocument =
      '''mutation updateProfessionalReviews(\$content: String, \$imageURL: String, \$professionalId: ID!, \$rating: Int!, \$status: Status!, \$userId: ID!) {
  updateProfessionalReviews(input: {content: \$content, imageURL: \$imageURL, professionalId: \$professionalId, rating: \$rating, status: \$status, userId: \$userId}) {
    userId
  }
}''';

  static const String CREATE_PROFESSIONAL_REVIEW_OPERATION_NAME =
      'createProfessionalReviews';
  static const String UPDATE_PROFESSIONAL_REVIEW_OPERATION_NAME =
      'updateProfessionalReviews';

  Future<ReviewResult> createProfessionalReview(
      {@required ProfessionalReviews review, @required String userId}) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: CREATE_PROFESSIONAL_REVIEW_OPERATION_NAME,
          mutationDocument: createProfessionalReviewDocument,
          variables: {
            'userId': userId,
            'professionalId': review.professionalId,
            'imageURL': review.imageURL,
            'content': review.content,
            'rating': review.rating,
            'status': review.status.toString().split(".").last
          });
      var body = jsonDecode(response.body);
      print(body);
      if (body["data"]["createProfessionalReviews"] == null)
        throw Exception("Cannot create a new Review");

      return ReviewResult.ADDED;
    } catch (error) {
      /// If there is an error in updating
      try {
        response = await RunQuery.runQuery(
            operationName: UPDATE_PROFESSIONAL_REVIEW_OPERATION_NAME,
            mutationDocument: updateProfessionalReviewDocument,
            variables: {
              'userId': userId,
              'professionalId': review.professionalId,
              'imageURL': review.imageURL,
              'content': review.content,
              'rating': review.rating,
              'status': review.status.toString().split(".").last
            });
        var body = jsonDecode(response.body);
        print(body);
        if (body["data"]["updateProfessionalReviews"] == null)
          return ReviewResult.FAILED;
        return ReviewResult.UPDATED;
      } catch (error) {
        print("Error in updating comment" + error);
        return ReviewResult.FAILED;
      }
    }
  }
}
