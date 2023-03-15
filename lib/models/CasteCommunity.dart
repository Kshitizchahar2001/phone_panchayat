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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the CasteCommunity type in your schema. */
@immutable
class CasteCommunity extends Model {
  static const classType = const _CasteCommunityModelType();
  final String id;
  final List<User> users;
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

  const CasteCommunity._internal(
      {@required this.id,
      this.users,
      @required this.name,
      this.description,
      this.owner,
      @required this.pincode,
      this.imageURL,
      @required this.memberCount});

  factory CasteCommunity(
      {String id,
      List<User> users,
      @required String name,
      String description,
      User owner,
      @required String pincode,
      String imageURL,
      @required int memberCount}) {
    return CasteCommunity._internal(
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
    return other is CasteCommunity &&
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

    buffer.write("CasteCommunity {");
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

  CasteCommunity copyWith(
      {String id,
      List<User> users,
      String name,
      String description,
      User owner,
      String pincode,
      String imageURL,
      int memberCount}) {
    return CasteCommunity(
        id: id ?? this.id,
        users: users ?? this.users,
        name: name ?? this.name,
        description: description ?? this.description,
        owner: owner ?? this.owner,
        pincode: pincode ?? this.pincode,
        imageURL: imageURL ?? this.imageURL,
        memberCount: memberCount ?? this.memberCount);
  }

  CasteCommunity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        users = json['users'] is List
            ? (json['users'] as List)
                .map((e) => User.fromJson(new Map<String, dynamic>.from(e)))
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

  static final QueryField ID = QueryField(fieldName: "casteCommunity.id");
  static final QueryField USERS = QueryField(
      fieldName: "users",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
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
    modelSchemaDefinition.name = "CasteCommunity";
    modelSchemaDefinition.pluralName = "CasteCommunities";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: CasteCommunity.USERS,
        isRequired: false,
        ofModelName: (User).toString(),
        associatedKey: User.COMMUNITY));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CasteCommunity.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CasteCommunity.DESCRIPTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: CasteCommunity.OWNER,
        isRequired: false,
        targetName: "ownerId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CasteCommunity.PINCODE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CasteCommunity.IMAGEURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CasteCommunity.MEMBERCOUNT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));
  });
}

class _CasteCommunityModelType extends ModelType<CasteCommunity> {
  const _CasteCommunityModelType();

  @override
  CasteCommunity fromJson(Map<String, dynamic> jsonData) {
    return CasteCommunity.fromJson(jsonData);
  }
}
