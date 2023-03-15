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

import 'package:online_panchayat_flutter/enum/subscriptionStatus.dart';
import 'package:online_panchayat_flutter/enum/subscriptionType.dart';
import 'package:online_panchayat_flutter/enum/subscription_plan.dart';

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the UserSubscription type in your schema. */
@immutable
class UserSubscription extends Model {
  static const classType = const _UserSubscriptionModelType();
  final String id;
  final String userId;
  final SubscriptionPlan subscriptionPlan;
  final SubscriptionType planType;
  final String subscriptionId;
  final SubscriptionStatus paymentGatewayStatus;
  final Status status;
  final TemporalDateTime startDate;
  final TemporalDateTime expiryDate;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const UserSubscription._internal(
      {@required this.id,
      @required this.userId,
      @required this.subscriptionPlan,
      this.planType,
      this.subscriptionId,
      this.paymentGatewayStatus,
      @required this.status,
      this.startDate,
      this.expiryDate});

  factory UserSubscription(
      {String id,
      @required String userId,
      @required SubscriptionPlan subscriptionPlan,
      SubscriptionType planType,
      String subscriptionId,
      SubscriptionStatus paymentGatewayStatus,
      @required Status status,
      TemporalDateTime startDate,
      TemporalDateTime expiryDate}) {
    return UserSubscription._internal(
        id: id == null ? UUID.getUUID() : id,
        userId: userId,
        subscriptionPlan: subscriptionPlan,
        planType: planType,
        subscriptionId: subscriptionId,
        paymentGatewayStatus: paymentGatewayStatus,
        status: status,
        startDate: startDate,
        expiryDate: expiryDate);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSubscription &&
        id == other.id &&
        userId == other.userId &&
        subscriptionPlan == other.subscriptionPlan &&
        planType == other.planType &&
        subscriptionId == other.subscriptionId &&
        paymentGatewayStatus == other.paymentGatewayStatus &&
        status == other.status &&
        startDate == other.startDate &&
        expiryDate == other.expiryDate;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("UserSubscription {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + "$userId" + ", ");
    buffer.write("subscriptionPlan=" +
        (subscriptionPlan != null ? enumToString(subscriptionPlan) : "null") +
        ", ");
    buffer.write("planType=" +
        (planType != null ? enumToString(planType) : "null") +
        ", ");
    buffer.write("subscriptionId=" + "$subscriptionId" + ", ");
    buffer.write("paymentGatewayStatus=" +
        (paymentGatewayStatus != null
            ? enumToString(paymentGatewayStatus)
            : "null") +
        ", ");
    buffer.write(
        "status=" + (status != null ? enumToString(status) : "null") + ", ");
    buffer.write("startDate=" +
        (startDate != null ? startDate.format() : "null") +
        ", ");
    buffer.write(
        "expiryDate=" + (expiryDate != null ? expiryDate.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  UserSubscription copyWith(
      {String id,
      String userId,
      SubscriptionPlan subscriptionPlan,
      SubscriptionType planType,
      String subscriptionId,
      SubscriptionStatus paymentGatewayStatus,
      Status status,
      TemporalDateTime startDate,
      TemporalDateTime expiryDate}) {
    return UserSubscription(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
        planType: planType ?? this.planType,
        subscriptionId: subscriptionId ?? this.subscriptionId,
        paymentGatewayStatus: paymentGatewayStatus ?? this.paymentGatewayStatus,
        status: status ?? this.status,
        startDate: startDate ?? this.startDate,
        expiryDate: expiryDate ?? this.expiryDate);
  }

  UserSubscription.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        subscriptionPlan = enumFromString<SubscriptionPlan>(
            json['subscriptionPlan'], SubscriptionPlan.values),
        planType = enumFromString<SubscriptionType>(
            json['planType'], SubscriptionType.values),
        subscriptionId = json['subscriptionId'],
        paymentGatewayStatus = enumFromString<SubscriptionStatus>(
            json['paymentGatewayStatus'], SubscriptionStatus.values),
        status = enumFromString<Status>(json['status'], Status.values),
        startDate = json['startDate'] != null
            ? TemporalDateTime.fromString(json['startDate'])
            : null,
        expiryDate = json['expiryDate'] != null
            ? TemporalDateTime.fromString(json['expiryDate'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'subscriptionPlan': enumToString(subscriptionPlan),
        'planType': enumToString(planType),
        'subscriptionId': subscriptionId,
        'paymentGatewayStatus': enumToString(paymentGatewayStatus),
        'status': enumToString(status),
        'startDate': startDate?.format(),
        'expiryDate': expiryDate?.format()
      };

  static final QueryField ID = QueryField(fieldName: "userSubscription.id");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static final QueryField SUBSCRIPTIONPLAN =
      QueryField(fieldName: "subscriptionPlan");
  static final QueryField PLANTYPE = QueryField(fieldName: "planType");
  static final QueryField SUBSCRIPTIONID =
      QueryField(fieldName: "subscriptionId");
  static final QueryField PAYMENTGATEWAYSTATUS =
      QueryField(fieldName: "paymentGatewayStatus");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField STARTDATE = QueryField(fieldName: "startDate");
  static final QueryField EXPIRYDATE = QueryField(fieldName: "expiryDate");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserSubscription";
    modelSchemaDefinition.pluralName = "UserSubscriptions";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.READ,
        ModelOperation.CREATE,
        ModelOperation.UPDATE
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserSubscription.USERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserSubscription.SUBSCRIPTIONPLAN,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserSubscription.PLANTYPE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserSubscription.SUBSCRIPTIONID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserSubscription.PAYMENTGATEWAYSTATUS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserSubscription.STATUS,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserSubscription.STARTDATE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserSubscription.EXPIRYDATE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _UserSubscriptionModelType extends ModelType<UserSubscription> {
  const _UserSubscriptionModelType();

  @override
  UserSubscription fromJson(Map<String, dynamic> jsonData) {
    return UserSubscription.fromJson(jsonData);
  }
}
