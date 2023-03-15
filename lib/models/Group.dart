// ignore_for_file: file_names, slash_for_doc_comments, unnecessary_const, prefer_if_null_operators, prefer_const_constructors, unnecessary_new, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, annotate_overrides, non_constant_identifier_names

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

import 'GroupUserRelation.dart';
import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Group type in your schema. */
@immutable
class Group extends Model {
  static const classType = const _GroupModelType();
  final String id;
  final List<GroupUserRelation> users;
  final String name;
  final String description;
  final User owner;
  final String pincode;
  final String imageURL;
  final int memberCount;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Group._internal(
      {@required this.id,
      this.users,
      @required this.name,
      this.description,
      this.owner,
      @required this.pincode,
      this.imageURL,
      @required this.memberCount});

  factory Group(
      {String id,
      List<GroupUserRelation> users,
      @required String name,
      String description,
      User owner,
      @required String pincode,
      String imageURL,
      @required int memberCount}) {
    return Group._internal(
        id: id == null ? UUID.getUUID() : id,
        users: users != null ? List.unmodifiable(users) : users,
        name: name,
        description: description,
        owner: owner,
        pincode: pincode,
        imageURL: imageURL,
        memberCount: memberCount);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Group &&
        id == other.id &&
        DeepCollectionEquality().equals(users, other.users) &&
        name == other.name &&
        description == other.description &&
        owner == other.owner &&
        pincode == other.pincode &&
        imageURL == other.imageURL &&
        memberCount == other.memberCount;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Group {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("description=" + "$description" + ", ");
    buffer.write("owner=" + (owner != null ? owner.toString() : "null") + ", ");
    buffer.write("pincode=" + "$pincode" + ", ");
    buffer.write("imageURL=" + "$imageURL" + ", ");
    buffer.write("memberCount=" +
        (memberCount != null ? memberCount.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Group copyWith(
      {String id,
      List<GroupUserRelation> users,
      String name,
      String description,
      User owner,
      String pincode,
      String imageURL,
      int memberCount}) {
    return Group(
        id: id ?? this.id,
        users: users ?? this.users,
        name: name ?? this.name,
        description: description ?? this.description,
        owner: owner ?? this.owner,
        pincode: pincode ?? this.pincode,
        imageURL: imageURL ?? this.imageURL,
        memberCount: memberCount ?? this.memberCount);
  }

  Group.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        users = json['users'] is List
            ? (json['users'] as List)
                .map((e) => GroupUserRelation.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        name = json['name'],
        description = json['description'],
        owner = json['owner'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['owner']))
            : null,
        pincode = json['pincode'],
        imageURL = json['imageURL'],
        memberCount = json['memberCount'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'users': users?.map((e) => e?.toJson())?.toList(),
        'name': name,
        'description': description,
        'owner': owner?.toJson(),
        'pincode': pincode,
        'imageURL': imageURL,
        'memberCount': memberCount
      };

  static final QueryField ID = QueryField(fieldName: "group.id");
  static final QueryField USERS = QueryField(
      fieldName: "users",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (GroupUserRelation).toString()));
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField OWNER = QueryField(
      fieldName: "owner",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField PINCODE = QueryField(fieldName: "pincode");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageURL");
  static final QueryField MEMBERCOUNT = QueryField(fieldName: "memberCount");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Group";
    modelSchemaDefinition.pluralName = "Groups";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Group.USERS,
        isRequired: false,
        ofModelName: (GroupUserRelation).toString(),
        associatedKey: GroupUserRelation.GROUP));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Group.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Group.DESCRIPTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Group.OWNER,
        isRequired: false,
        targetName: "ownerId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Group.PINCODE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Group.IMAGEURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Group.MEMBERCOUNT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));
  });
}

class _GroupModelType extends ModelType<Group> {
  const _GroupModelType();

  @override
  Group fromJson(Map<String, dynamic> jsonData) {
    return Group.fromJson(jsonData);
  }
}
