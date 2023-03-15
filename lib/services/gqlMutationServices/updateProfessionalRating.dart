// ignore_for_file: file_names, constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:http/http.dart' as http;

class UpdateProfessionalRating {
  static const String UPDATE_PROFESSIONAL_RATING = 'updateProfessional';
  final updateProfessionalRatingDocument =
      '''mutation updateProfessional(\$id: ID!, \$totalReviews: Int, \$totalStars: Int) {
  updateProfessional(input: {id: \$id, totalReviews: \$totalReviews, totalStars: \$totalStars}) {
    id
  }
}
''';

  Future<bool> updateProfessionalRating(
      {@required String professionalId,
      @required int totalReviews,
      @required int totalStars}) async {
    try {
      http.Response response = await RunQuery.runQueryWithAPIKey(
          operationName: UPDATE_PROFESSIONAL_RATING,
          mutationDocument: updateProfessionalRatingDocument,
          variables: {
            'id': professionalId,
            'totalReviews': totalReviews,
            'totalStars': totalStars,
          });
      var body = jsonDecode(response.body);
      print(body);
      if (body['data']['updateProfessional'] == null) return false;
      return true;
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
      return false;
    }
  }
}
