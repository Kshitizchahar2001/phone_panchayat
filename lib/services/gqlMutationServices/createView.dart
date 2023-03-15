// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';

class CreateView {
  final createViewDocument = '''
 mutation CreateView(\$postId: ID!, \$userId: ID!) {
  createView(input: {postId: \$postId, userId: \$userId}) {
    postId
  }
}''';
  static const String CREATE_VIEW_OPERATION_NAME = 'CreateView';

  createView({
    @required String postId,
    @required String userId,
  }) async {
    await RunQuery.runQuery(
        operationName: CREATE_VIEW_OPERATION_NAME,
        mutationDocument: createViewDocument,
        variables: {
          'postId': postId,
          'userId': userId,
        });
  }
}
