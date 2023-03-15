// ignore_for_file: file_names, constant_identifier_names

import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/runQuery.dart';

class CreateComment {
  final createCommentDocument =
      '''mutation CreateComment( \$postId: ID!, \$userId: ID!,\$content: String!,\$status:Status!, \$imageURL:String ) {
  createComment(
    input: {postId: \$postId, userId: \$userId, content: \$content, status: \$status, imageURL: \$imageURL}
  ) {
    createdAt
    status
    updatedAt
    version
    imageURL
  }
}
''';

  static const String CREATE_COMMENT_OPERATION_NAME = 'CreateComment';

  Future<void> createComment({
    @required String postId,
    @required String userId,
    @required Status status,
    @required String content,
    String imageURL,
  }) async {
    await RunQuery.runQuery(
        operationName: CREATE_COMMENT_OPERATION_NAME,
        mutationDocument: createCommentDocument,
        variables: {
          'postId': postId,
          'userId': userId,
          'content': content,
          'status': status.toString().split('.').last,
          'imageURL': imageURL,
        });
  }
}
