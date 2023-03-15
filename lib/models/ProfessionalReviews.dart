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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the ProfessionalReviews type in your schema. */
@immutable
class ProfessionalReviews extends Model {
  static const classType = const _ProfessionalReviewsModelType();
  final String id;
  final String professionalId;
  final String content;
  final int rating;
  final User user;
  final Status status;
  final TemporalDateTime createdAt;
  final String imageURL;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const ProfessionalReviews._internal(
      {@required this.id,
      @required this.professionalId,
      this.content,
      @required this.rating,
      this.user,
      @required this.status,
      this.createdAt,
      this.imageURL});

  factory ProfessionalReviews(
      {String id,
      @required String professionalId,
      String content,
      @required int rating,
      User user,
      @required Status status,
      TemporalDateTime createdAt,
      String imageURL}) {
    return ProfessionalReviews._internal(
        id: id == null ? UUID.getUUID() : id,
        professionalId: professionalId,
        content: content,
        rating: rating,
        user: user,
        status: status,
        createdAt: createdAt,
        imageURL: imageURL);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfessionalReviews &&
        id == other.id &&
        professionalId == other.professionalId &&
        content == other.content &&
        rating == other.rating &&
        user == other.user &&
        status == other.status &&
        createdAt == other.createdAt &&
        imageURL == other.imageURL;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ProfessionalReviews {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("professionalId=" + "$professionalId" + ", ");
    buffer.write("content=" + "$content" + ", ");
    buffer.write(
        "rating=" + (rating != null ? rating.toString() : "null") + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write(
        "status=" + (status != null ? enumToString(status) : "null") + ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.format() : "null") +
        ", ");
    buffer.write("imageURL=" + "$imageURL");
    buffer.write("}");

    return buffer.toString();
  }

  ProfessionalReviews copyWith(
      {String id,
      String professionalId,
      String content,
      int rating,
      User user,
      Status status,
      TemporalDateTime createdAt,
      String imageURL}) {
    return ProfessionalReviews(
        id: id ?? this.id,
        professionalId: professionalId ?? this.professionalId,
        content: content ?? this.content,
        rating: rating ?? this.rating,
        user: user ?? this.user,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        imageURL: imageURL ?? this.imageURL);
  }

  ProfessionalReviews.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        professionalId = json['professionalId'],
        content = json['content'],
        rating = (json['rating'] as num)?.toInt(),
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        status = enumFromString<Status>(json['status'], Status.values),
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        imageURL = json['imageURL'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'professionalId': professionalId,
        'content': content,
        'rating': rating,
        'user': user?.toJson(),
        'status': enumToString(status),
        'createdAt': createdAt?.format(),
        'imageURL': imageURL
      };

  static final QueryField ID = QueryField(fieldName: "professionalReviews.id");
  static final QueryField PROFESSIONALID =
      QueryField(fieldName: "professionalId");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField RATING = QueryField(fieldName: "rating");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageURL");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ProfessionalReviews";
    modelSchemaDefinition.pluralName = "ProfessionalReviews";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ProfessionalReviews.PROFESSIONALID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ProfessionalReviews.CONTENT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ProfessionalReviews.RATING,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: ProfessionalReviews.USER,
        isRequired: false,
        targetName: "userId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ProfessionalReviews.STATUS,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ProfessionalReviews.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ProfessionalReviews.IMAGEURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _ProfessionalReviewsModelType extends ModelType<ProfessionalReviews> {
  const _ProfessionalReviewsModelType();

  @override
  ProfessionalReviews fromJson(Map<String, dynamic> jsonData) {
    return ProfessionalReviews.fromJson(jsonData);
  }
}
