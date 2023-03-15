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
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the LiveNews type in your schema. */
@immutable
class LiveNews extends Model {
  static const classType = const _LiveNewsModelType();
  final String id;
  final String postId;
  final String placeId;
  final String name;
  final String imageUrl;
  final TemporalDateTime createdAt;
  final TemporalDateTime updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const LiveNews._internal(
      {@required this.id,
      @required this.postId,
      @required this.placeId,
      this.name,
      this.imageUrl,
      this.createdAt,
      this.updatedAt});

  factory LiveNews(
      {String id,
      @required String postId,
      @required String placeId,
      String name,
      String imageUrl,
      TemporalDateTime createdAt,
      TemporalDateTime updatedAt}) {
    return LiveNews._internal(
        id: id == null ? UUID.getUUID() : id,
        postId: postId,
        placeId: placeId,
        name: name,
        imageUrl: imageUrl,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LiveNews &&
        id == other.id &&
        postId == other.postId &&
        placeId == other.placeId &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("LiveNews {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("postId=" + "$postId" + ", ");
    buffer.write("placeId=" + "$placeId" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("imageUrl=" + "$imageUrl" + ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (updatedAt != null ? updatedAt.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  LiveNews copyWith(
      {String id,
      String postId,
      String placeId,
      String name,
      String imageUrl,
      TemporalDateTime createdAt,
      TemporalDateTime updatedAt}) {
    return LiveNews(
        id: id ?? this.id,
        postId: postId ?? this.postId,
        placeId: placeId ?? this.placeId,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  LiveNews.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        postId = json['postId'],
        placeId = json['placeId'],
        name = json['name'],
        imageUrl = json['imageUrl'],
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'placeId': placeId,
        'name': name,
        'imageUrl': imageUrl,
        'createdAt': createdAt?.format(),
        'updatedAt': updatedAt?.format()
      };

  static final QueryField ID = QueryField(fieldName: "liveNews.id");
  static final QueryField POSTID = QueryField(fieldName: "postId");
  static final QueryField PLACEID = QueryField(fieldName: "placeId");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageUrl");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LiveNews";
    modelSchemaDefinition.pluralName = "LiveNews";

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
        key: LiveNews.POSTID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LiveNews.PLACEID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LiveNews.NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LiveNews.IMAGEURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LiveNews.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LiveNews.UPDATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _LiveNewsModelType extends ModelType<LiveNews> {
  const _LiveNewsModelType();

  @override
  LiveNews fromJson(Map<String, dynamic> jsonData) {
    return LiveNews.fromJson(jsonData);
  }
}
