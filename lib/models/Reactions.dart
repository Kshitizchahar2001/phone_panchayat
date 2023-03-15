// ignore_for_file: file_names, slash_for_doc_comments, unnecessary_const, prefer_if_null_operators, unnecessary_new, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, annotate_overrides, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

/** This is an auto generated class representing the Reactions type in your schema. */
@immutable
class Reactions extends Model {
  static const classType = const _ReactionsModelType();
  final String id;
  final String postId;
  final User user;
  final ReactionTypes reactionType;
  final Status status;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Reactions._internal(
      {@required this.id,
      @required this.postId,
      this.user,
      @required this.reactionType,
      @required this.status});

  factory Reactions(
      {String id,
      @required String postId,
      User user,
      @required ReactionTypes reactionType,
      @required Status status}) {
    return Reactions._internal(
        id: id == null ? UUID.getUUID() : id,
        postId: postId,
        user: user,
        reactionType: reactionType,
        status: status);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Reactions &&
        id == other.id &&
        postId == other.postId &&
        user == other.user &&
        reactionType == other.reactionType &&
        status == other.status;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Reactions {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("postId=" + "$postId" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("reactionType=" +
        (reactionType != null ? enumToString(reactionType) : "null") +
        ", ");
    buffer.write("status=" + (status != null ? enumToString(status) : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Reactions copyWith(
      {String id,
      String postId,
      User user,
      ReactionTypes reactionType,
      Status status}) {
    return Reactions(
        id: id ?? this.id,
        postId: postId ?? this.postId,
        user: user ?? this.user,
        reactionType: reactionType ?? this.reactionType,
        status: status ?? this.status);
  }

  Reactions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        postId = json['postId'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        reactionType = enumFromString<ReactionTypes>(
            json['reactionType'], ReactionTypes.values),
        status = enumFromString<Status>(json['status'], Status.values);

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'user': user?.toJson(),
        'reactionType': enumToString(reactionType),
        'status': enumToString(status)
      };

  static final QueryField ID = QueryField(fieldName: "reactions.id");
  static final QueryField POSTID = QueryField(fieldName: "postId");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField REACTIONTYPE = QueryField(fieldName: "reactionType");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Reactions";
    modelSchemaDefinition.pluralName = "Reactions";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PRIVATE, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Reactions.POSTID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Reactions.USER,
        isRequired: false,
        targetName: "userId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Reactions.REACTIONTYPE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Reactions.STATUS,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));
  });
}

class _ReactionsModelType extends ModelType<Reactions> {
  const _ReactionsModelType();

  @override
  Reactions fromJson(Map<String, dynamic> jsonData) {
    return Reactions.fromJson(jsonData);
  }
}
