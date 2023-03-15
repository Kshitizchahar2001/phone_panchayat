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

import 'package:online_panchayat_flutter/models/AreaType.dart';
import 'package:online_panchayat_flutter/models/LocalIssueStatus.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the LocalIssueWithTag type in your schema. */
@immutable
class LocalIssueWithTag extends Model {
  static const classType = const _LocalIssueWithTagModelType();
  final String id;
  final PostWithTags post;
  final String tagId;
  final LocalIssueStatus status;
  final String identifier_1;
  final String identifier_2;
  final Places place1;
  final Places place2;
  final TemporalDateTime updatedAt;
  final AreaType areaType;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const LocalIssueWithTag._internal(
      {@required this.id,
      this.post,
      @required this.tagId,
      @required this.status,
      @required this.identifier_1,
      @required this.identifier_2,
      this.place1,
      this.place2,
      this.updatedAt,
      @required this.areaType});

  factory LocalIssueWithTag(
      {String id,
      PostWithTags post,
      @required String tagId,
      @required LocalIssueStatus status,
      @required String identifier_1,
      @required String identifier_2,
      Places place1,
      Places place2,
      TemporalDateTime updatedAt,
      @required AreaType areaType}) {
    return LocalIssueWithTag._internal(
        id: id == null ? UUID.getUUID() : id,
        post: post,
        tagId: tagId,
        status: status,
        identifier_1: identifier_1,
        identifier_2: identifier_2,
        place1: place1,
        place2: place2,
        updatedAt: updatedAt,
        areaType: areaType);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocalIssueWithTag &&
        id == other.id &&
        post == other.post &&
        tagId == other.tagId &&
        status == other.status &&
        identifier_1 == other.identifier_1 &&
        identifier_2 == other.identifier_2 &&
        place1 == other.place1 &&
        place2 == other.place2 &&
        updatedAt == other.updatedAt &&
        areaType == other.areaType;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("LocalIssueWithTag {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("post=" + (post != null ? post.toString() : "null") + ", ");
    buffer.write("tagId=" + "$tagId" + ", ");
    buffer.write(
        "status=" + (status != null ? enumToString(status) : "null") + ", ");
    buffer.write("identifier_1=" + "$identifier_1" + ", ");
    buffer.write("identifier_2=" + "$identifier_2" + ", ");
    buffer.write("updatedAt=" +
        (updatedAt != null ? updatedAt.format() : "null") +
        ", ");
    buffer.write(
        "areaType=" + (areaType != null ? enumToString(areaType) : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  LocalIssueWithTag copyWith(
      {String id,
      PostWithTags post,
      String tagId,
      LocalIssueStatus status,
      String identifier_1,
      String identifier_2,
      Places place1,
      Places place2,
      TemporalDateTime updatedAt,
      AreaType areaType}) {
    return LocalIssueWithTag(
        id: id ?? this.id,
        post: post ?? this.post,
        tagId: tagId ?? this.tagId,
        status: status ?? this.status,
        identifier_1: identifier_1 ?? this.identifier_1,
        identifier_2: identifier_2 ?? this.identifier_2,
        place1: place1 ?? this.place1,
        place2: place2 ?? this.place2,
        updatedAt: updatedAt ?? this.updatedAt,
        areaType: areaType ?? this.areaType);
  }

  LocalIssueWithTag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        post = json['post'] != null
            ? PostWithTags.fromJson(new Map<String, dynamic>.from(json['post']))
            : null,
        tagId = json['tagId'],
        status = enumFromString<LocalIssueStatus>(
            json['status'], LocalIssueStatus.values),
        identifier_1 = json['identifier_1'],
        identifier_2 = json['identifier_2'],
        place1 = json['place1'] != null
            ? Places.fromJson(new Map<String, dynamic>.from(json['place1']))
            : null,
        place2 = json['place2'] != null
            ? Places.fromJson(new Map<String, dynamic>.from(json['place2']))
            : null,
        updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null,
        areaType = enumFromString<AreaType>(json['areaType'], AreaType.values);

  Map<String, dynamic> toJson() => {
        'id': id,
        'post': post?.toJson(),
        'tagId': tagId,
        'status': enumToString(status),
        'identifier_1': identifier_1,
        'identifier_2': identifier_2,
        'place1': place1?.toJson(),
        'place2': place2?.toJson(),
        'updatedAt': updatedAt?.format(),
        'areaType': enumToString(areaType)
      };

  static final QueryField ID = QueryField(fieldName: "localIssueWithTag.id");
  static final QueryField POST = QueryField(
      fieldName: "post",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (PostWithTags).toString()));
  static final QueryField TAGID = QueryField(fieldName: "tagId");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField IDENTIFIER_1 = QueryField(fieldName: "identifier_1");
  static final QueryField IDENTIFIER_2 = QueryField(fieldName: "identifier_2");
  static final QueryField PLACE1 = QueryField(
      fieldName: "place1",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Places).toString()));
  static final QueryField PLACE2 = QueryField(
      fieldName: "place2",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Places).toString()));
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static final QueryField AREATYPE = QueryField(fieldName: "areaType");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LocalIssueWithTag";
    modelSchemaDefinition.pluralName = "LocalIssueWithTags";

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
        key: LocalIssueWithTag.POST,
        isRequired: false,
        targetName: "postId",
        ofModelName: (PostWithTags).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LocalIssueWithTag.TAGID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LocalIssueWithTag.STATUS,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LocalIssueWithTag.IDENTIFIER_1,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LocalIssueWithTag.IDENTIFIER_2,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: LocalIssueWithTag.PLACE1,
        isRequired: false,
        ofModelName: (Places).toString(),
        associatedKey: Places.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: LocalIssueWithTag.PLACE2,
        isRequired: false,
        ofModelName: (Places).toString(),
        associatedKey: Places.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LocalIssueWithTag.UPDATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LocalIssueWithTag.AREATYPE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));
  });
}

class _LocalIssueWithTagModelType extends ModelType<LocalIssueWithTag> {
  const _LocalIssueWithTagModelType();

  @override
  LocalIssueWithTag fromJson(Map<String, dynamic> jsonData) {
    return LocalIssueWithTag.fromJson(jsonData);
  }
}
