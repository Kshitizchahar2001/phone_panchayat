// ignore_for_file: file_names, unused_import, constant_identifier_names, non_constant_identifier_names, prefer_conditional_assignment, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:online_panchayat_flutter/models/CommunityPost.dart';
import 'package:online_panchayat_flutter/models/DesignatedUser.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';

class SearchDesignatedUsersByPlaceAndStatus {
  static const String SEARCH_DESIGNATED_USER_OPERATION_NAME =
      'SearchDesignatedUsersByPlaceAndStatus';
  final String searchDesignatedUserQueryDocument = '''
 query SearchDesignatedUsersByPlaceAndStatus(\$limit: Int , \$nextToken: String , \$identifier_1_id: String , \$status: DesignatedUserStatus ) {
  searchDesignatedUsersByPlaceAndStatus(limit: \$limit, nextToken: \$nextToken, identifier_1_id: \$identifier_1_id, sortDirection: DESC, statusUpdatedAt: {beginsWith: {status: \$status}}) {
    nextToken
    items {
      version
      updatedAt
      type
      status
      identifier_1_id
      identifier_2
      identifier_1
      id
      designation
      createdAt
      user {
        name
        image
        designation
        isDesignatedUser
        isUserVerified
        id
      }
    }
  }
}


  ''';

  Future<FeedQueryData> searchDesignatedUsersByPlaceAndStatus({
    @required String identifier_1_id,
    int limit,
    @required String nextToken,
    @required DesignatedUserStatus designatedUserStatus,
  }) async {
    FeedQueryData feedQueryData = SearchDesignatedUserQueryData();
    http.Response response;
    Map<String, dynamic> variables;

    if (nextToken == lastNextTokenEqualToNull) {
      feedQueryData.nextToken = nextToken;
      return feedQueryData;
    }
    variables = {
      'identifier_1_id': identifier_1_id,
      'limit': limit,
      'nextToken': nextToken,
      'status': designatedUserStatus.toString().split(".").last,
    };

    try {
      response = await RunQuery.runQuery(
          operationName: SEARCH_DESIGNATED_USER_OPERATION_NAME,
          mutationDocument: searchDesignatedUserQueryDocument,
          variables: variables);

      var body = jsonDecode(response.body);

      nextToken =
          body['data']['searchDesignatedUsersByPlaceAndStatus']["nextToken"];

      if (nextToken == null) {
        nextToken = lastNextTokenEqualToNull;
      }

      feedQueryData.setNextToken = nextToken;

      List listOfDesignatedUser =
          body['data']['searchDesignatedUsersByPlaceAndStatus']["items"];
      // print("items returned from query : ${listOfDesignatedUser.length}");
      feedQueryData.setList = listOfDesignatedUser.map((element) {
        DesignatedUser designatedUser;
        try {
          designatedUser = DesignatedUser.fromJson(element);
          feedQueryData.postVersion[element['id']] = element['version'];
        } catch (e) {
          print(e.toString() + "EXCEPTION");
        }
        return designatedUser;
      }).toList();
    } catch (e, s) {
      print("EXCEPTION HERE $e");
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return feedQueryData;
  }
}
