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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the View type in your schema. */
@immutable
class View extends Model {
  static const classType = const _ViewModelType();
  final String id;
  final String userId;
  final String postId;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const View._internal(
      {@required this.id, @required this.userId, @required this.postId});

  factory View({String id, @required String userId, @required String postId}) {
    return View._internal(
        id: id == null ? UUID.getUUID() : id, userId: userId, postId: postId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is View &&
        id == other.id &&
        userId == other.userId &&
        postId == other.postId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("View {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + "$userId" + ", ");
    buffer.write("postId=" + "$postId");
    buffer.write("}");

    return buffer.toString();
  }

  View copyWith({String id, String userId, String postId}) {
    return View(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        postId: postId ?? this.postId);
  }

  View.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        postId = json['postId'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'userId': userId, 'postId': postId};

  static final QueryField ID = QueryField(fieldName: "view.id");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static final QueryField POSTID = QueryField(fieldName: "postId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "View";
    modelSchemaDefinition.pluralName = "Views";

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
        key: View.USERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: View.POSTID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _ViewModelType extends ModelType<View> {
  const _ViewModelType();

  @override
  View fromJson(Map<String, dynamic> jsonData) {
    return View.fromJson(jsonData);
  }
}
