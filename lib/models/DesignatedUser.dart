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

import 'package:online_panchayat_flutter/enum/designatedUserDesignation.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';

import 'DesignatedUserType.dart';
import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the DesignatedUser type in your schema. */
@immutable
class DesignatedUser extends Model {
  static const classType = const _DesignatedUserModelType();
  final String id;
  final User user;
  final String pincode;
  final DesignatedUserType type;
  final DesignatedUserStatus status;
  final DesignatedUserDesignation designation;
  final String identifier_1;
  final String identifier_2;
  final TemporalDateTime updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const DesignatedUser._internal(
      {@required this.id,
      this.user,
      @required this.pincode,
      @required this.type,
      @required this.status,
      @required this.designation,
      @required this.identifier_1,
      @required this.identifier_2,
      this.updatedAt});

  factory DesignatedUser(
      {String id,
      User user,
      @required String pincode,
      @required DesignatedUserType type,
      @required DesignatedUserStatus status,
      @required DesignatedUserDesignation designation,
      @required String identifier_1,
      @required String identifier_2,
      TemporalDateTime updatedAt}) {
    return DesignatedUser._internal(
        id: id == null ? UUID.getUUID() : id,
        user: user,
        pincode: pincode,
        type: type,
        status: status,
        designation: designation,
        identifier_1: identifier_1,
        identifier_2: identifier_2,
        updatedAt: updatedAt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DesignatedUser &&
        id == other.id &&
        user == other.user &&
        pincode == other.pincode &&
        type == other.type &&
        status == other.status &&
        designation == other.designation &&
        identifier_1 == other.identifier_1 &&
        identifier_2 == other.identifier_2 &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("DesignatedUser {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("pincode=" + "$pincode" + ", ");
    buffer.write("type=" + (type != null ? enumToString(type) : "null") + ", ");
    buffer.write(
        "status=" + (status != null ? enumToString(status) : "null") + ", ");
    buffer.write("designation=" +
        (designation != null ? enumToString(designation) : "null") +
        ", ");
    buffer.write("identifier_1=" + "$identifier_1" + ", ");
    buffer.write("identifier_2=" + "$identifier_2" + ", ");
    buffer.write(
        "updatedAt=" + (updatedAt != null ? updatedAt.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  DesignatedUser copyWith(
      {String id,
      User user,
      String pincode,
      DesignatedUserType type,
      DesignatedUserStatus status,
      DesignatedUserDesignation designation,
      String identifier_1,
      String identifier_2,
      TemporalDateTime updatedAt}) {
    return DesignatedUser(
        id: id ?? this.id,
        user: user ?? this.user,
        pincode: pincode ?? this.pincode,
        type: type ?? this.type,
        status: status ?? this.status,
        designation: designation ?? this.designation,
        identifier_1: identifier_1 ?? this.identifier_1,
        identifier_2: identifier_2 ?? this.identifier_2,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  DesignatedUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        pincode = json['pincode'],
        type = enumFromString<DesignatedUserType>(
            json['type'], DesignatedUserType.values),
        status = enumFromString<DesignatedUserStatus>(
            json['status'], DesignatedUserStatus.values),
        designation = enumFromString<DesignatedUserDesignation>(
            json['designation'], DesignatedUserDesignation.values),
        identifier_1 = json['identifier_1'],
        identifier_2 = json['identifier_2'],
        updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'pincode': pincode,
        'type': enumToString(type),
        'status': enumToString(status),
        'designation': enumToString(designation),
        'identifier_1': identifier_1,
        'identifier_2': identifier_2,
        'updatedAt': updatedAt?.format()
      };

  static final QueryField ID = QueryField(fieldName: "designatedUser.id");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField PINCODE = QueryField(fieldName: "pincode");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField DESIGNATION = QueryField(fieldName: "designation");
  static final QueryField IDENTIFIER_1 = QueryField(fieldName: "identifier_1");
  static final QueryField IDENTIFIER_2 = QueryField(fieldName: "identifier_2");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "DesignatedUser";
    modelSchemaDefinition.pluralName = "DesignatedUsers";

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
        key: DesignatedUser.USER,
        isRequired: false,
        targetName: "id",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: DesignatedUser.PINCODE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: DesignatedUser.TYPE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: DesignatedUser.STATUS,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: DesignatedUser.DESIGNATION,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: DesignatedUser.IDENTIFIER_1,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: DesignatedUser.IDENTIFIER_2,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: DesignatedUser.UPDATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _DesignatedUserModelType extends ModelType<DesignatedUser> {
  const _DesignatedUserModelType();

  @override
  DesignatedUser fromJson(Map<String, dynamic> jsonData) {
    return DesignatedUser.fromJson(jsonData);
  }
}
