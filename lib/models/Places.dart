// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

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

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Tag.dart';

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Places type in your schema. */
@immutable
class Places extends Model {
  static const classType = const _PlacesModelType();
  final String id;
  final String parentId;
  final PlaceType type;
  final String name_en;
  final String name_hi;
  final Tag tag;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Places._internal(
      {@required this.id,
      @required this.parentId,
      @required this.type,
      this.name_en,
      this.name_hi,
      this.tag});

  factory Places(
      {String id,
      @required String parentId,
      @required PlaceType type,
      String name_en,
      String name_hi,
      Tag tag}) {
    return Places._internal(
        id: id == null ? UUID.getUUID() : id,
        parentId: parentId,
        type: type,
        name_en: name_en,
        name_hi: name_hi,
        tag: tag);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Places &&
        id == other.id &&
        parentId == other.parentId &&
        type == other.type &&
        name_en == other.name_en &&
        name_hi == other.name_hi &&
        tag == other.tag;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Places {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("parentId=" + "$parentId" + ", ");
    buffer.write("type=" + (type != null ? enumToString(type) : "null") + ", ");
    buffer.write("name_en=" + "$name_en" + ", ");
    buffer.write("name_hi=" + "$name_hi" + ", ");
    buffer.write("tag=" + (tag != null ? tag.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Places copyWith(
      {String id,
      String parentId,
      PlaceType type,
      String name_en,
      String name_hi,
      Tag tag}) {
    return Places(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        type: type ?? this.type,
        name_en: name_en ?? this.name_en,
        name_hi: name_hi ?? this.name_hi,
        tag: tag ?? this.tag);
  }

  Places.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        parentId = json['parentId'],
        type = enumFromString<PlaceType>(json['type'], PlaceType.values),
        name_en = json['name_en'],
        name_hi = json['name_hi'],
        tag = json['tag'] != null
            ? Tag.fromJson(new Map<String, dynamic>.from(json['tag']))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'parentId': parentId,
        'type': enumToString(type),
        'name_en': name_en,
        'name_hi': name_hi,
        'tag': tag?.toJson()
      };

  static final QueryField ID = QueryField(fieldName: "places.id");
  static final QueryField PARENTID = QueryField(fieldName: "parentId");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField NAME_EN = QueryField(fieldName: "name_en");
  static final QueryField NAME_HI = QueryField(fieldName: "name_hi");
  static final QueryField TAG = QueryField(
      fieldName: "tag",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Tag).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Places";
    modelSchemaDefinition.pluralName = "Places";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.READ,
        ModelOperation.CREATE,
        ModelOperation.UPDATE
      ]),
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.READ,
        ModelOperation.CREATE,
        ModelOperation.UPDATE
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Places.PARENTID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Places.TYPE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Places.NAME_EN,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Places.NAME_HI,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Places.TAG,
        isRequired: false,
        targetName: "placesTagId",
        ofModelName: (Tag).toString()));
  });
}

class _PlacesModelType extends ModelType<Places> {
  const _PlacesModelType();

  @override
  Places fromJson(Map<String, dynamic> jsonData) {
    return Places.fromJson(jsonData);
  }
}
