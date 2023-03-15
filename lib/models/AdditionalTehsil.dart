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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:online_panchayat_flutter/models/Places.dart';

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the AdditionalTehsils type in your schema. */
@immutable
class AdditionalTehsils extends Model {
  static const classType = const _AdditionalTehsilsModelType();
  final String id;
  final String userId;
  final String placeId;
  final Places place;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const AdditionalTehsils._internal(
      {@required this.id,
      @required this.userId,
      @required this.placeId,
      this.place});

  factory AdditionalTehsils(
      {String id,
      @required String userId,
      @required String placeId,
      Places place}) {
    return AdditionalTehsils._internal(
        id: id == null ? UUID.getUUID() : id,
        userId: userId,
        placeId: placeId,
        place: place);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdditionalTehsils &&
        id == other.id &&
        userId == other.userId &&
        placeId == other.placeId &&
        place == other.place;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("AdditionalTehsils {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + "$userId" + ", ");
    buffer.write("placeId=" + "$placeId");
    buffer.write("}");

    return buffer.toString();
  }

  AdditionalTehsils copyWith(
      {String id, String userId, String placeId, Places place}) {
    return AdditionalTehsils(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        placeId: placeId ?? this.placeId,
        place: place ?? this.place);
  }

  AdditionalTehsils.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        placeId = json['placeId'],
        place = json['place'] != null
            ? Places.fromJson(new Map<String, dynamic>.from(json['place']))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'placeId': placeId,
        'place': place?.toJson()
      };

  static final QueryField ID = QueryField(fieldName: "additionalTehsils.id");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static final QueryField PLACEID = QueryField(fieldName: "placeId");
  static final QueryField PLACE = QueryField(
      fieldName: "place",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Places).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "AdditionalTehsils";
    modelSchemaDefinition.pluralName = "AdditionalTehsils";

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
        key: AdditionalTehsils.USERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: AdditionalTehsils.PLACEID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: AdditionalTehsils.PLACE,
        isRequired: false,
        ofModelName: (Places).toString(),
        associatedKey: Places.ID));
  });
}

class _AdditionalTehsilsModelType extends ModelType<AdditionalTehsils> {
  const _AdditionalTehsilsModelType();

  @override
  AdditionalTehsils fromJson(Map<String, dynamic> jsonData) {
    return AdditionalTehsils.fromJson(jsonData);
  }
}
