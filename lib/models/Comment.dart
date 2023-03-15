// ignore_for_file: file_names, slash_for_doc_comments, unnecessary_const, prefer_if_null_operators, unnecessary_new, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, annotate_overrides, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Comment type in your schema. */
@immutable
class Comment extends Model {
  static const classType = const _CommentModelType();
  final String id;
  final String postId;
  final String content;
  final User user;
  final Status status;
  final TemporalDateTime createdAt;
  final String imageURL;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Comment._internal(
      {@required this.id,
      @required this.postId,
      @required this.content,
      this.user,
      @required this.status,
      this.createdAt,
      this.imageURL});

  factory Comment(
      {String id,
      @required String postId,
      @required String content,
      User user,
      @required Status status,
      TemporalDateTime createdAt,
      String imageURL}) {
    return Comment._internal(
        id: id == null ? UUID.getUUID() : id,
        postId: postId,
        content: content,
        user: user,
        status: status,
        createdAt: createdAt,
        imageURL: imageURL);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
        id == other.id &&
        postId == other.postId &&
        content == other.content &&
        user == other.user &&
        status == other.status &&
        createdAt == other.createdAt &&
        imageURL == other.imageURL;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Comment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("postId=" + "$postId" + ", ");
    buffer.write("content=" + "$content" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write(
        "status=" + (status != null ? enumToString(status) : "null") + ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.format() : "null") +
        ", ");
    buffer.write("imageURL=" + "$imageURL");
    buffer.write("}");

    return buffer.toString();
  }

  Comment copyWith(
      {String id,
      String postId,
      String content,
      User user,
      Status status,
      TemporalDateTime createdAt,
      String imageURL}) {
    return Comment(
        id: id ?? this.id,
        postId: postId ?? this.postId,
        content: content ?? this.content,
        user: user ?? this.user,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        imageURL: imageURL ?? this.imageURL);
  }

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        postId = json['postId'],
        content = json['content'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        status = enumFromString<Status>(json['status'], Status.values),
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        imageURL = json['imageURL'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'content': content,
        'user': user?.toJson(),
        'status': enumToString(status),
        'createdAt': createdAt?.format(),
        'imageURL': imageURL
      };

  static final QueryField ID = QueryField(fieldName: "comment.id");
  static final QueryField POSTID = QueryField(fieldName: "postId");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageURL");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comment";
    modelSchemaDefinition.pluralName = "Comments";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Comment.POSTID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Comment.CONTENT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Comment.USER,
        isRequired: false,
        targetName: "userId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Comment.STATUS,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Comment.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Comment.IMAGEURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _CommentModelType extends ModelType<Comment> {
  const _CommentModelType();

  @override
  Comment fromJson(Map<String, dynamic> jsonData) {
    return Comment.fromJson(jsonData);
  }
}
