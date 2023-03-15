// ignore_for_file: file_names, constant_identifier_names, unused_local_variable

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/models/AreaType.dart';
import 'package:online_panchayat_flutter/models/LocalIssueStatus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';

class CreateLocalIssueWithTag {
  final createLocalIssueQueryDocument = '''
mutation CreateLocalIssueWithTag(\$areaType: AreaType! , \$postId: ID!, \$identifier_1: ID!, \$identifier_2: ID!, \$status: LocalIssueStatus! , \$tagId: String!) {
  createLocalIssueWithTag(input: {areaType: \$areaType, postId: \$postId, identifier_1: \$identifier_1, identifier_2: \$identifier_2, status: \$status, tagId: \$tagId}) {
    id
  }
}


''';

  static const String CREATE_LOCAL_ISSUE_OPERATION_NAME =
      'CreateLocalIssueWithTag';

  Future<bool> createLocalIssueWithTag({
    @required String postId,
    @required LocalIssueStatus localIssueStatus,
    @required String identifier_1,
    @required String identifier_2,
    @required AreaType areaType,
    @required String tagId,
  }) async {
    http.Response response;
    try {
      response = await RunQuery.runQuery(
          operationName: CREATE_LOCAL_ISSUE_OPERATION_NAME,
          mutationDocument: createLocalIssueQueryDocument,
          variables: {
            'postId': postId,
            'status': localIssueStatus.toString().split('.').last,
            'identifier_1': identifier_1,
            'identifier_2': identifier_2,
            'areaType': areaType.toString().split(".").last,
            'tagId': tagId,
          });

      return true;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return false;
    }
  }
}
