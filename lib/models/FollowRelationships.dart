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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the FollowRelationships type in your schema. */
@immutable
class FollowRelationships extends Model {
  static const classType = const _FollowRelationshipsModelType();
  final String id;
  final String followeeId;
  final String followerId;
  final TemporalDateTime timestamp;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const FollowRelationships._internal(
      {@required this.id,
      @required this.followeeId,
      @required this.followerId,
      @required this.timestamp});

  factory FollowRelationships(
      {String id,
      @required String followeeId,
      @required String followerId,
      @required TemporalDateTime timestamp}) {
    return FollowRelationships._internal(
        id: id == null ? UUID.getUUID() : id,
        followeeId: followeeId,
        followerId: followerId,
        timestamp: timestamp);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FollowRelationships &&
        id == other.id &&
        followeeId == other.followeeId &&
        followerId == other.followerId &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("FollowRelationships {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("followeeId=" + "$followeeId" + ", ");
    buffer.write("followerId=" + "$followerId" + ", ");
    buffer.write(
        "timestamp=" + (timestamp != null ? timestamp.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  FollowRelationships copyWith(
      {String id,
      String followeeId,
      String followerId,
      TemporalDateTime timestamp}) {
    return FollowRelationships(
        id: id ?? this.id,
        followeeId: followeeId ?? this.followeeId,
        followerId: followerId ?? this.followerId,
        timestamp: timestamp ?? this.timestamp);
  }

  FollowRelationships.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        followeeId = json['followeeId'],
        followerId = json['followerId'],
        timestamp = json['timestamp'] != null
            ? TemporalDateTime.fromString(json['timestamp'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'followeeId': followeeId,
        'followerId': followerId,
        'timestamp': timestamp?.format()
      };

  static final QueryField ID = QueryField(fieldName: "followRelationships.id");
  static final QueryField FOLLOWEEID = QueryField(fieldName: "followeeId");
  static final QueryField FOLLOWERID = QueryField(fieldName: "followerId");
  static final QueryField TIMESTAMP = QueryField(fieldName: "timestamp");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "FollowRelationships";
    modelSchemaDefinition.pluralName = "FollowRelationships";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PRIVATE, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: FollowRelationships.FOLLOWEEID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: FollowRelationships.FOLLOWERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: FollowRelationships.TIMESTAMP,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _FollowRelationshipsModelType extends ModelType<FollowRelationships> {
  const _FollowRelationshipsModelType();

  @override
  FollowRelationships fromJson(Map<String, dynamic> jsonData) {
    return FollowRelationships.fromJson(jsonData);
  }
}
