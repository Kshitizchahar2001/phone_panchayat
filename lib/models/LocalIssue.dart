// ignore_for_file: file_names
// /*
// * Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// *
// * Licensed under the Apache License, Version 2.0 (the "License").
// * You may not use this file except in compliance with the License.
// * A copy of the License is located at
// *
// *  http://aws.amazon.com/apache2.0
// *
// * or in the "license" file accompanying this file. This file is distributed
// * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// * express or implied. See the License for the specific language governing
// * permissions and limitations under the License.
// */

// // ignore_for_file: public_member_api_docs

// import 'LocalIssueStatus.dart';
// import 'ModelProvider.dart';
// import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
// import 'package:flutter/foundation.dart';

// /** This is an auto generated class representing the LocalIssue type in your schema. */
// @immutable
// class LocalIssue extends Model {
//   static const classType = const _LocalIssueModelType();
//   final String id;
//   final Post post;
//   final String pincode;
//   final LocalIssueStatus status;
//   final String identifier_1;
//   final String identifier_2;
//   final TemporalDateTime updatedAt;

//   @override
//   getInstanceType() => classType;

//   @override
//   String getId() {
//     return id;
//   }

//   const LocalIssue._internal(
//       {@required this.id,
//       this.post,
//       @required this.pincode,
//       @required this.status,
//       @required this.identifier_1,
//       @required this.identifier_2,
//       this.updatedAt});

//   factory LocalIssue(
//       {String id,
//       Post post,
//       @required String pincode,
//       @required LocalIssueStatus status,
//       @required String identifier_1,
//       @required String identifier_2,
//       TemporalDateTime updatedAt}) {
//     return LocalIssue._internal(
//         id: id == null ? UUID.getUUID() : id,
//         post: post,
//         pincode: pincode,
//         status: status,
//         identifier_1: identifier_1,
//         identifier_2: identifier_2,
//         updatedAt: updatedAt);
//   }

//   bool equals(Object other) {
//     return this == other;
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     return other is LocalIssue &&
//         id == other.id &&
//         post == other.post &&
//         pincode == other.pincode &&
//         status == other.status &&
//         identifier_1 == other.identifier_1 &&
//         identifier_2 == other.identifier_2 &&
//         updatedAt == other.updatedAt;
//   }

//   @override
//   int get hashCode => toString().hashCode;

//   @override
//   String toString() {
//     var buffer = new StringBuffer();

//     buffer.write("LocalIssue {");
//     buffer.write("id=" + "$id" + ", ");
//     buffer.write("post=" + (post != null ? post.toString() : "null") + ", ");
//     buffer.write("pincode=" + "$pincode" + ", ");
//     buffer.write(
//         "status=" + (status != null ? enumToString(status) : "null") + ", ");
//     buffer.write("identifier_1=" + "$identifier_1" + ", ");
//     buffer.write("identifier_2=" + "$identifier_2" + ", ");
//     buffer.write(
//         "updatedAt=" + (updatedAt != null ? updatedAt.format() : "null"));
//     buffer.write("}");

//     return buffer.toString();
//   }

//   LocalIssue copyWith(
//       {String id,
//       Post post,
//       String pincode,
//       LocalIssueStatus status,
//       String identifier_1,
//       String identifier_2,
//       TemporalDateTime updatedAt}) {
//     return LocalIssue(
//         id: id ?? this.id,
//         post: post ?? this.post,
//         pincode: pincode ?? this.pincode,
//         status: status ?? this.status,
//         identifier_1: identifier_1 ?? this.identifier_1,
//         identifier_2: identifier_2 ?? this.identifier_2,
//         updatedAt: updatedAt ?? this.updatedAt);
//   }

//   LocalIssue.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         post = json['post'] != null
//             ? Post.fromJson(new Map<String, dynamic>.from(json['post']))
//             : null,
//         pincode = json['pincode'],
//         status = enumFromString<LocalIssueStatus>(
//             json['status'], LocalIssueStatus.values),
//         identifier_1 = json['identifier_1'],
//         identifier_2 = json['identifier_2'],
//         updatedAt = json['updatedAt'] != null
//             ? TemporalDateTime.fromString(json['updatedAt'])
//             : null;

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'post': post?.toJson(),
//         'pincode': pincode,
//         'status': enumToString(status),
//         'identifier_1': identifier_1,
//         'identifier_2': identifier_2,
//         'updatedAt': updatedAt?.format()
//       };

//   static final QueryField ID = QueryField(fieldName: "localIssue.id");
//   static final QueryField POST = QueryField(
//       fieldName: "post",
//       fieldType: ModelFieldType(ModelFieldTypeEnum.model,
//           ofModelName: (Post).toString()));
//   static final QueryField PINCODE = QueryField(fieldName: "pincode");
//   static final QueryField STATUS = QueryField(fieldName: "status");
//   static final QueryField IDENTIFIER_1 = QueryField(fieldName: "identifier_1");
//   static final QueryField IDENTIFIER_2 = QueryField(fieldName: "identifier_2");
//   static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
//   static var schema =
//       Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
//     modelSchemaDefinition.name = "LocalIssue";
//     modelSchemaDefinition.pluralName = "LocalIssues";

//     modelSchemaDefinition.authRules = [
//       AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
//         ModelOperation.CREATE,
//         ModelOperation.UPDATE,
//         ModelOperation.DELETE,
//         ModelOperation.READ
//       ])
//     ];

//     modelSchemaDefinition.addField(ModelFieldDefinition.id());

//     modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
//         key: LocalIssue.POST,
//         isRequired: false,
//         targetName: "postId",
//         ofModelName: (Post).toString()));

//     modelSchemaDefinition.addField(ModelFieldDefinition.field(
//         key: LocalIssue.PINCODE,
//         isRequired: true,
//         ofType: ModelFieldType(ModelFieldTypeEnum.string)));

//     modelSchemaDefinition.addField(ModelFieldDefinition.field(
//         key: LocalIssue.STATUS,
//         isRequired: true,
//         ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

//     modelSchemaDefinition.addField(ModelFieldDefinition.field(
//         key: LocalIssue.IDENTIFIER_1,
//         isRequired: true,
//         ofType: ModelFieldType(ModelFieldTypeEnum.string)));

//     modelSchemaDefinition.addField(ModelFieldDefinition.field(
//         key: LocalIssue.IDENTIFIER_2,
//         isRequired: true,
//         ofType: ModelFieldType(ModelFieldTypeEnum.string)));

//     modelSchemaDefinition.addField(ModelFieldDefinition.field(
//         key: LocalIssue.UPDATEDAT,
//         isRequired: false,
//         ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
//   });
// }

// class _LocalIssueModelType extends ModelType<LocalIssue> {
//   const _LocalIssueModelType();

//   @override
//   LocalIssue fromJson(Map<String, dynamic> jsonData) {
//     return LocalIssue.fromJson(jsonData);
//   }
// }
