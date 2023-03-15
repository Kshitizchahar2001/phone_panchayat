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

import 'package:online_panchayat_flutter/models/Professional.dart';

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the ProfessionalByWork type in your schema. */
@immutable
class ProfessionalByWork extends Model {
  static const classType = const _ProfessionalByWorkModelType();
  final String id;
  final String workSpecialityId;
  final String geoHash;
  final Professional professional;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const ProfessionalByWork._internal(
      {@required this.id,
      @required this.workSpecialityId,
      @required this.geoHash,
      this.professional});

  factory ProfessionalByWork(
      {String id,
      @required String workSpecialityId,
      @required String geoHash,
      Professional professional}) {
    return ProfessionalByWork._internal(
        id: id == null ? UUID.getUUID() : id,
        workSpecialityId: workSpecialityId,
        geoHash: geoHash,
        professional: professional);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfessionalByWork &&
        id == other.id &&
        workSpecialityId == other.workSpecialityId &&
        geoHash == other.geoHash &&
        professional == other.professional;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ProfessionalByWork {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("workSpecialityId=" + "$workSpecialityId" + ", ");
    buffer.write("geoHash=" + "$geoHash" + ", ");
    buffer.write("professional=" +
        (professional != null ? professional.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  ProfessionalByWork copyWith(
      {String id,
      String workSpecialityId,
      String geoHash,
      Professional professional}) {
    return ProfessionalByWork(
        id: id ?? this.id,
        workSpecialityId: workSpecialityId ?? this.workSpecialityId,
        geoHash: geoHash ?? this.geoHash,
        professional: professional ?? this.professional);
  }

  ProfessionalByWork.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        workSpecialityId = json['workSpecialityId'],
        geoHash = json['geoHash'],
        professional = json['professional'] != null
            ? Professional.fromJson(
                new Map<String, dynamic>.from(json['professional']))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'workSpecialityId': workSpecialityId,
        'geoHash': geoHash,
        'professional': professional?.toJson()
      };

  static final QueryField ID = QueryField(fieldName: "professionalByWork.id");
  static final QueryField WORKSPECIALITYID =
      QueryField(fieldName: "workSpecialityId");
  static final QueryField GEOHASH = QueryField(fieldName: "geoHash");
  static final QueryField PROFESSIONAL = QueryField(
      fieldName: "professional",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Professional).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ProfessionalByWork";
    modelSchemaDefinition.pluralName = "ProfessionalByWorks";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ]),
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ProfessionalByWork.WORKSPECIALITYID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ProfessionalByWork.GEOHASH,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: ProfessionalByWork.PROFESSIONAL,
        isRequired: false,
        targetName: "id",
        ofModelName: (Professional).toString()));
  });
}

class _ProfessionalByWorkModelType extends ModelType<ProfessionalByWork> {
  const _ProfessionalByWorkModelType();

  @override
  ProfessionalByWork fromJson(Map<String, dynamic> jsonData) {
    return ProfessionalByWork.fromJson(jsonData);
  }
}
