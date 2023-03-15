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

import 'IdentifierType.dart';
import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Identifiers type in your schema. */
@immutable
class Identifiers extends Model {
  static const classType = const _IdentifiersModelType();
  final String id;
  final String name;
  final IdentifierType type;
  final String pincode;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Identifiers._internal(
      {@required this.id,
      this.name,
      @required this.type,
      @required this.pincode});

  factory Identifiers(
      {String id,
      String name,
      @required IdentifierType type,
      @required String pincode}) {
    return Identifiers._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        type: type,
        pincode: pincode);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Identifiers &&
        id == other.id &&
        name == other.name &&
        type == other.type &&
        pincode == other.pincode;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Identifiers {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("type=" + (type != null ? enumToString(type) : "null") + ", ");
    buffer.write("pincode=" + "$pincode");
    buffer.write("}");

    return buffer.toString();
  }

  Identifiers copyWith(
      {String id, String name, IdentifierType type, String pincode}) {
    return Identifiers(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        pincode: pincode ?? this.pincode);
  }

  Identifiers.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type =
            enumFromString<IdentifierType>(json['type'], IdentifierType.values),
        pincode = json['pincode'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'type': enumToString(type), 'pincode': pincode};

  static final QueryField ID = QueryField(fieldName: "identifiers.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField PINCODE = QueryField(fieldName: "pincode");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Identifiers";
    modelSchemaDefinition.pluralName = "Identifiers";

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
        key: Identifiers.NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Identifiers.TYPE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Identifiers.PINCODE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _IdentifiersModelType extends ModelType<Identifiers> {
  const _IdentifiersModelType();

  @override
  Identifiers fromJson(Map<String, dynamic> jsonData) {
    return Identifiers.fromJson(jsonData);
  }
}
