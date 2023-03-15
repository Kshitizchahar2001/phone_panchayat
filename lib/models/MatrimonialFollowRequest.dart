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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:online_panchayat_flutter/enum/matrimonialRequestStatus.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the MatrimonialFollowRequest type in your schema. */
@immutable
class MatrimonialFollowRequest extends Model {
  static const classType = const _MatrimonialFollowRequestModelType();
  final String id;
  final String requesterId;
  final String responderId;
  final MatrimonialProfile requesterProfile;
  final MatrimonialProfile responderProfile;
  final MatrimonialRequestStatus status;
  final TemporalDateTime updatedAt;
  final TemporalDateTime createdAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const MatrimonialFollowRequest._internal(
      {@required this.id,
      @required this.requesterId,
      @required this.responderId,
      this.requesterProfile,
      this.responderProfile,
      this.status,
      this.updatedAt,
      this.createdAt});

  factory MatrimonialFollowRequest(
      {String id,
      @required String requesterId,
      @required String responderId,
      MatrimonialProfile requesterProfile,
      MatrimonialProfile responderProfile,
      MatrimonialRequestStatus status,
      TemporalDateTime updatedAt,
      TemporalDateTime createdAt}) {
    return MatrimonialFollowRequest._internal(
        id: id == null ? UUID.getUUID() : id,
        requesterId: requesterId,
        responderId: responderId,
        requesterProfile: requesterProfile,
        responderProfile: responderProfile,
        status: status,
        updatedAt: updatedAt,
        createdAt: createdAt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MatrimonialFollowRequest &&
        id == other.id &&
        requesterId == other.requesterId &&
        responderId == other.responderId &&
        requesterProfile == other.requesterProfile &&
        responderProfile == other.responderProfile &&
        status == other.status &&
        updatedAt == other.updatedAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MatrimonialFollowRequest {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("requesterId=" + "$requesterId" + ", ");
    buffer.write("responderId=" + "$responderId" + ", ");
    buffer.write(
        "status=" + (status != null ? enumToString(status) : "null") + ", ");
    buffer.write("updatedAt=" +
        (updatedAt != null ? updatedAt.format() : "null") +
        ", ");
    buffer.write(
        "createdAt=" + (createdAt != null ? createdAt.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  MatrimonialFollowRequest copyWith(
      {String id,
      String requesterId,
      String responderId,
      MatrimonialProfile requesterProfile,
      MatrimonialProfile responderProfile,
      MatrimonialRequestStatus status,
      TemporalDateTime updatedAt,
      TemporalDateTime createdAt}) {
    return MatrimonialFollowRequest(
        id: id ?? this.id,
        requesterId: requesterId ?? this.requesterId,
        responderId: responderId ?? this.responderId,
        requesterProfile: requesterProfile ?? this.requesterProfile,
        responderProfile: responderProfile ?? this.responderProfile,
        status: status ?? this.status,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt);
  }

  MatrimonialFollowRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        requesterId = json['requesterId'],
        responderId = json['responderId'],
        requesterProfile = json['requesterProfile'] != null
            ? MatrimonialProfile.fromJson(
                new Map<String, dynamic>.from(json['requesterProfile']))
            : null,
        responderProfile = json['responderProfile'] != null
            ? MatrimonialProfile.fromJson(
                new Map<String, dynamic>.from(json['responderProfile']))
            : null,
        status = enumFromString<MatrimonialRequestStatus>(
            json['status'], MatrimonialRequestStatus.values),
        updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null,
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'requesterId': requesterId,
        'responderId': responderId,
        'requesterProfile': requesterProfile?.toJson(),
        'responderProfile': responderProfile?.toJson(),
        'status': enumToString(status),
        'updatedAt': updatedAt?.format(),
        'createdAt': createdAt?.format()
      };

  static final QueryField ID =
      QueryField(fieldName: "matrimonialFollowRequest.id");
  static final QueryField REQUESTERID = QueryField(fieldName: "requesterId");
  static final QueryField RESPONDERID = QueryField(fieldName: "responderId");
  static final QueryField REQUESTERPROFILE = QueryField(
      fieldName: "requesterProfile",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (MatrimonialProfile).toString()));
  static final QueryField RESPONDERPROFILE = QueryField(
      fieldName: "responderProfile",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (MatrimonialProfile).toString()));
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MatrimonialFollowRequest";
    modelSchemaDefinition.pluralName = "MatrimonialFollowRequests";

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
        key: MatrimonialFollowRequest.REQUESTERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialFollowRequest.RESPONDERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: MatrimonialFollowRequest.REQUESTERPROFILE,
        isRequired: false,
        ofModelName: (MatrimonialProfile).toString(),
        associatedKey: MatrimonialProfile.USER));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: MatrimonialFollowRequest.RESPONDERPROFILE,
        isRequired: false,
        ofModelName: (MatrimonialProfile).toString(),
        associatedKey: MatrimonialProfile.USER));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialFollowRequest.STATUS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialFollowRequest.UPDATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialFollowRequest.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _MatrimonialFollowRequestModelType
    extends ModelType<MatrimonialFollowRequest> {
  const _MatrimonialFollowRequestModelType();

  @override
  MatrimonialFollowRequest fromJson(Map<String, dynamic> jsonData) {
    return MatrimonialFollowRequest.fromJson(jsonData);
  }
}
