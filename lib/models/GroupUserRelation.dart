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

import 'Group.dart';
import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the GroupUserRelation type in your schema. */
@immutable
class GroupUserRelation extends Model {
  static const classType = const _GroupUserRelationModelType();
  final String id;
  final User user;
  final Group group;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const GroupUserRelation._internal({@required this.id, this.user, this.group});

  factory GroupUserRelation({String id, User user, Group group}) {
    return GroupUserRelation._internal(
        id: id == null ? UUID.getUUID() : id, user: user, group: group);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupUserRelation &&
        id == other.id &&
        user == other.user &&
        group == other.group;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("GroupUserRelation {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("group=" + (group != null ? group.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  GroupUserRelation copyWith({String id, User user, Group group}) {
    return GroupUserRelation(
        id: id ?? this.id, user: user ?? this.user, group: group ?? this.group);
  }

  GroupUserRelation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        group = json['group'] != null
            ? Group.fromJson(new Map<String, dynamic>.from(json['group']))
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'user': user?.toJson(), 'group': group?.toJson()};

  static final QueryField ID = QueryField(fieldName: "groupUserRelation.id");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField GROUP = QueryField(
      fieldName: "group",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Group).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "GroupUserRelation";
    modelSchemaDefinition.pluralName = "GroupUserRelations";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: GroupUserRelation.USER,
        isRequired: false,
        targetName: "userId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: GroupUserRelation.GROUP,
        isRequired: false,
        targetName: "groupId",
        ofModelName: (Group).toString()));
  });
}

class _GroupUserRelationModelType extends ModelType<GroupUserRelation> {
  const _GroupUserRelationModelType();

  @override
  GroupUserRelation fromJson(Map<String, dynamic> jsonData) {
    return GroupUserRelation.fromJson(jsonData);
  }
}
