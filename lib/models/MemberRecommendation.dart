// ignore_for_file: file_names, unnecessary_const, prefer_if_null_operators, unnecessary_new, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, annotate_overrides, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

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

import 'DesignatedUserType.dart';
import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

// ignore: slash_for_doc_comments
/** This is an auto generated class representing the MemberRecommendation type in your schema. */
@immutable
class MemberRecommendation extends Model {
  static const classType = const _MemberRecommendationModelType();
  final String id;
  final User user;
  final String electedMemberName;
  final String electedMemberPhoneNumber;
  final DesignatedUserDesignation designation;
  final String district;
  final DesignatedUserType type;
  final String identifier_1;
  final String identifier_2;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const MemberRecommendation._internal(
      {@required this.id,
      this.user,
      @required this.electedMemberName,
      @required this.electedMemberPhoneNumber,
      @required this.designation,
      @required this.district,
      @required this.type,
      @required this.identifier_1,
      @required this.identifier_2});

  factory MemberRecommendation(
      {String id,
      User user,
      @required String electedMemberName,
      @required String electedMemberPhoneNumber,
      @required DesignatedUserDesignation designation,
      @required String district,
      @required DesignatedUserType type,
      @required String identifier_1,
      @required String identifier_2}) {
    return MemberRecommendation._internal(
        id: id == null ? UUID.getUUID() : id,
        user: user,
        electedMemberName: electedMemberName,
        electedMemberPhoneNumber: electedMemberPhoneNumber,
        designation: designation,
        district: district,
        type: type,
        identifier_1: identifier_1,
        identifier_2: identifier_2);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MemberRecommendation &&
        id == other.id &&
        user == other.user &&
        electedMemberName == other.electedMemberName &&
        electedMemberPhoneNumber == other.electedMemberPhoneNumber &&
        designation == other.designation &&
        district == other.district &&
        type == other.type &&
        identifier_1 == other.identifier_1 &&
        identifier_2 == other.identifier_2;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MemberRecommendation {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("electedMemberName=" + "$electedMemberName" + ", ");
    buffer.write(
        "electedMemberPhoneNumber=" + "$electedMemberPhoneNumber" + ", ");
    buffer.write("designation=" +
        (designation != null ? enumToString(designation) : "null") +
        ", ");
    buffer.write("district=" + "$district" + ", ");
    buffer.write("type=" + (type != null ? enumToString(type) : "null") + ", ");
    buffer.write("identifier_1=" + "$identifier_1" + ", ");
    buffer.write("identifier_2=" + "$identifier_2");
    buffer.write("}");

    return buffer.toString();
  }

  MemberRecommendation copyWith(
      {String id,
      User user,
      String electedMemberName,
      String electedMemberPhoneNumber,
      DesignatedUserDesignation designation,
      String district,
      DesignatedUserType type,
      String identifier_1,
      String identifier_2}) {
    return MemberRecommendation(
        id: id ?? this.id,
        user: user ?? this.user,
        electedMemberName: electedMemberName ?? this.electedMemberName,
        electedMemberPhoneNumber:
            electedMemberPhoneNumber ?? this.electedMemberPhoneNumber,
        designation: designation ?? this.designation,
        district: district ?? this.district,
        type: type ?? this.type,
        identifier_1: identifier_1 ?? this.identifier_1,
        identifier_2: identifier_2 ?? this.identifier_2);
  }

  MemberRecommendation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        electedMemberName = json['electedMemberName'],
        electedMemberPhoneNumber = json['electedMemberPhoneNumber'],
        designation = enumFromString<DesignatedUserDesignation>(
            json['designation'], DesignatedUserDesignation.values),
        district = json['district'],
        type = enumFromString<DesignatedUserType>(
            json['type'], DesignatedUserType.values),
        identifier_1 = json['identifier_1'],
        identifier_2 = json['identifier_2'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'electedMemberName': electedMemberName,
        'electedMemberPhoneNumber': electedMemberPhoneNumber,
        'designation': enumToString(designation),
        'district': district,
        'type': enumToString(type),
        'identifier_1': identifier_1,
        'identifier_2': identifier_2
      };

  static final QueryField ID = QueryField(fieldName: "memberRecommendation.id");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField ELECTEDMEMBERNAME =
      QueryField(fieldName: "electedMemberName");
  static final QueryField ELECTEDMEMBERPHONENUMBER =
      QueryField(fieldName: "electedMemberPhoneNumber");
  static final QueryField DESIGNATION = QueryField(fieldName: "designation");
  static final QueryField DISTRICT = QueryField(fieldName: "district");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField IDENTIFIER_1 = QueryField(fieldName: "identifier_1");
  static final QueryField IDENTIFIER_2 = QueryField(fieldName: "identifier_2");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MemberRecommendation";
    modelSchemaDefinition.pluralName = "MemberRecommendations";

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
        key: MemberRecommendation.USER,
        isRequired: false,
        targetName: "userId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MemberRecommendation.ELECTEDMEMBERNAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MemberRecommendation.ELECTEDMEMBERPHONENUMBER,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MemberRecommendation.DESIGNATION,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MemberRecommendation.DISTRICT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MemberRecommendation.TYPE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MemberRecommendation.IDENTIFIER_1,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MemberRecommendation.IDENTIFIER_2,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _MemberRecommendationModelType extends ModelType<MemberRecommendation> {
  const _MemberRecommendationModelType();

  @override
  MemberRecommendation fromJson(Map<String, dynamic> jsonData) {
    return MemberRecommendation.fromJson(jsonData);
  }
}
