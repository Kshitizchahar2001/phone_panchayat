// ignore_for_file: prefer_const_literals_to_create_immutables

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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Tag type in your schema. */
@immutable
class Tag extends Model {
  static const classType = const _TagModelType();
  final String id;
  final String name;
  final List<String> keywords;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Tag._internal({@required this.id, @required this.name, this.keywords});

  factory Tag({String id, @required String name, List<String> keywords}) {
    return Tag._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        keywords:
            keywords != null ? List<String>.unmodifiable(keywords) : keywords);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Tag &&
        id == other.id &&
        name == other.name &&
        DeepCollectionEquality().equals(keywords, other.keywords);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Tag {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer
        .write("keywords=" + (keywords != null ? keywords.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Tag copyWith({String id, String name, List<String> keywords}) {
    return Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        keywords: keywords ?? this.keywords);
  }

  Tag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        keywords = json['keywords']?.cast<String>();

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'keywords': keywords};

  static final QueryField ID = QueryField(fieldName: "tag.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField KEYWORDS = QueryField(fieldName: "keywords");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Tag";
    modelSchemaDefinition.pluralName = "Tags";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ]),
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.READ,
        ModelOperation.CREATE,
        ModelOperation.UPDATE
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Tag.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Tag.KEYWORDS,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));
  });
}

class _TagModelType extends ModelType<Tag> {
  const _TagModelType();

  @override
  Tag fromJson(Map<String, dynamic> jsonData) {
    return Tag.fromJson(jsonData);
  }
}
