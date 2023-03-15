// ignore_for_file: must_be_immutable, can_be_null_after_null_aware, prefer_const_literals_to_create_immutables

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

import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/ProfessionalReviews.dart';

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Professional type in your schema. */
@immutable
class Professional extends Model {
  static const classType = const _ProfessionalModelType();
  final String id;
  final String mobileNumber;
  final String whatsappNumber;
  final String shopName;
  final String shopDescription;
  final String geoHash;
  final String occupationName;
  final String occupationId;
  final List<String> workSpeciality;
  final List<String> workSpecialityId;
  final String workExperience;
  final List<String> workImages;
  int totalReviews;
  int totalStars;
  final List<ProfessionalReviews> reviews;
  final Location shopLocation;
  final String shopAddressLine;
  final User user;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  Professional._internal(
      {@required this.id,
      this.mobileNumber,
      this.whatsappNumber,
      this.shopName,
      this.shopDescription,
      @required this.geoHash,
      this.occupationName,
      @required this.occupationId,
      this.workSpeciality,
      @required this.workSpecialityId,
      this.workExperience,
      this.workImages,
      this.totalReviews = 0,
      this.totalStars = 0,
      this.reviews,
      @required this.shopLocation,
      this.shopAddressLine,
      this.user});

  factory Professional(
      {String id,
      String mobileNumber,
      String whatsappNumber,
      String shopName,
      String shopDescription,
      @required String geoHash,
      String occupationName,
      @required String occupationId,
      List<String> workSpeciality,
      @required List<String> workSpecialityId,
      String workExperience,
      List<String> workImages,
      int totalReviews,
      int totalStars,
      List<ProfessionalReviews> reviews,
      @required Location shopLocation,
      String shopAddressLine,
      User user}) {
    return Professional._internal(
        id: id == null ? UUID.getUUID() : id,
        mobileNumber: mobileNumber,
        whatsappNumber: whatsappNumber,
        shopName: shopName,
        shopDescription: shopDescription,
        geoHash: geoHash,
        occupationName: occupationName,
        occupationId: occupationId,
        workSpeciality: workSpeciality != null
            ? List<String>.unmodifiable(workSpeciality)
            : workSpeciality,
        workSpecialityId: workSpecialityId != null
            ? List<String>.unmodifiable(workSpecialityId)
            : workSpecialityId,
        workExperience: workExperience,
        workImages: workImages != null
            ? List<String>.unmodifiable(workImages)
            : workImages,
        totalReviews: totalReviews,
        totalStars: totalStars,
        reviews: reviews != null
            ? List<ProfessionalReviews>.unmodifiable(reviews)
            : reviews,
        shopLocation: shopLocation,
        shopAddressLine: shopAddressLine,
        user: user);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Professional &&
        id == other.id &&
        mobileNumber == other.mobileNumber &&
        whatsappNumber == other.whatsappNumber &&
        shopName == other.shopName &&
        shopDescription == other.shopDescription &&
        geoHash == other.geoHash &&
        occupationName == other.occupationName &&
        occupationId == other.occupationId &&
        DeepCollectionEquality().equals(workSpeciality, other.workSpeciality) &&
        DeepCollectionEquality()
            .equals(workSpecialityId, other.workSpecialityId) &&
        workExperience == other.workExperience &&
        DeepCollectionEquality().equals(workImages, other.workImages) &&
        totalReviews == other.totalReviews &&
        totalStars == other.totalStars &&
        DeepCollectionEquality().equals(reviews, other.reviews) &&
        shopLocation == other.shopLocation &&
        shopAddressLine == other.shopAddressLine &&
        user == other.user;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Professional {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("mobileNumber=" + "$mobileNumber" + ", ");
    buffer.write("whatsappNumber=" + "$whatsappNumber" + ", ");
    buffer.write("shopName=" + "$shopName" + ", ");
    buffer.write("shopDescription=" + "$shopDescription" + ", ");
    buffer.write("geoHash=" + "$geoHash" + ", ");
    buffer.write("occupationName=" + "$occupationName" + ", ");
    buffer.write("occupationId=" + "$occupationId" + ", ");
    buffer.write("workSpeciality=" +
        (workSpeciality != null ? workSpeciality.toString() : "null") +
        ", ");
    buffer.write("workSpecialityId=" +
        (workSpecialityId != null ? workSpecialityId.toString() : "null") +
        ", ");
    buffer.write("workExperience=" + "$workExperience" + ", ");
    buffer.write("workImages=" +
        (workImages != null ? workImages.toString() : "null") +
        ", ");
    buffer.write("totalReviews=" +
        (totalReviews != null ? totalReviews.toString() : "null") +
        ", ");
    buffer.write("totalStars=" +
        (totalStars != null ? totalStars.toString() : "null") +
        ", ");
    buffer.write("shopLocation=" +
        (shopLocation != null ? shopLocation.toString() : "null") +
        ", ");
    buffer.write("shopAddressLine=" + "$shopAddressLine" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Professional copyWith(
      {String id,
      String mobileNumber,
      String whatsappNumber,
      String shopName,
      String shopDescription,
      String geoHash,
      String occupationName,
      String occupationId,
      List<String> workSpeciality,
      List<String> workSpecialityId,
      String workExperience,
      List<String> workImages,
      int totalReviews,
      int totalStars,
      List<ProfessionalReviews> reviews,
      Location shopLocation,
      String shopAddressLine,
      User user}) {
    return Professional(
        id: id ?? this.id,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        whatsappNumber: whatsappNumber ?? this.whatsappNumber,
        shopName: shopName ?? this.shopName,
        shopDescription: shopDescription ?? this.shopDescription,
        geoHash: geoHash ?? this.geoHash,
        occupationName: occupationName ?? this.occupationName,
        occupationId: occupationId ?? this.occupationId,
        workSpeciality: workSpeciality ?? this.workSpeciality,
        workSpecialityId: workSpecialityId ?? this.workSpecialityId,
        workExperience: workExperience ?? this.workExperience,
        workImages: workImages ?? this.workImages,
        totalReviews: totalReviews ?? this.totalReviews,
        totalStars: totalStars ?? this.totalStars,
        reviews: reviews ?? this.reviews,
        shopLocation: shopLocation ?? this.shopLocation,
        shopAddressLine: shopAddressLine ?? this.shopAddressLine,
        user: user ?? this.user);
  }

  Professional.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        mobileNumber = json['mobileNumber'],
        whatsappNumber = json['whatsappNumber'],
        shopName = json['shopName'],
        shopDescription = json['shopDescription'],
        geoHash = json['geoHash'],
        occupationName = json['occupationName'],
        occupationId = json['occupationId'],
        workSpeciality = json['workSpeciality']?.cast<String>(),
        workSpecialityId = json['workSpecialityId']?.cast<String>(),
        workExperience = json['workExperience'],
        workImages = json['workImages']?.cast<String>(),
        totalReviews = (json['totalReviews'] as num)?.toInt(),
        totalStars = (json['totalStars'] as num)?.toInt(),
        reviews = json['reviews'] is List
            ? (json['reviews'] as List)
                .map((e) => ProfessionalReviews.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        shopLocation = json['shopLocation'] != null
            ? Location.fromJson(json['shopLocation'])
            : null,
        shopAddressLine = json['shopAddressLine'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'mobileNumber': mobileNumber,
        'whatsappNumber': whatsappNumber,
        'shopName': shopName,
        'shopDescription': shopDescription,
        'geoHash': geoHash,
        'occupationName': occupationName,
        'occupationId': occupationId,
        'workSpeciality': workSpeciality,
        'workSpecialityId': workSpecialityId,
        'workExperience': workExperience,
        'workImages': workImages,
        'totalReviews': totalReviews,
        'totalStars': totalStars,
        'reviews':
            reviews?.map((ProfessionalReviews e) => e?.toJson()).toList(),
        'shopLocation': shopLocation,
        'shopAddressLine': shopAddressLine,
        'user': user?.toJson()
      };

  static final QueryField ID = QueryField(fieldName: "professional.id");
  static final QueryField MOBILENUMBER = QueryField(fieldName: "mobileNumber");
  static final QueryField WHATSAPPNUMBER =
      QueryField(fieldName: "whatsappNumber");
  static final QueryField SHOPNAME = QueryField(fieldName: "shopName");
  static final QueryField SHOPDESCRIPTION =
      QueryField(fieldName: "shopDescription");
  static final QueryField GEOHASH = QueryField(fieldName: "geoHash");
  static final QueryField OCCUPATIONNAME =
      QueryField(fieldName: "occupationName");
  static final QueryField OCCUPATIONID = QueryField(fieldName: "occupationId");
  static final QueryField WORKSPECIALITY =
      QueryField(fieldName: "workSpeciality");
  static final QueryField WORKSPECIALITYID =
      QueryField(fieldName: "workSpecialityId");
  static final QueryField WORKEXPERIENCE =
      QueryField(fieldName: "workExperience");
  static final QueryField WORKIMAGES = QueryField(fieldName: "workImages");
  static final QueryField TOTALREVIEWS = QueryField(fieldName: "totalReviews");
  static final QueryField TOTALSTARS = QueryField(fieldName: "totalStars");
  static final QueryField REVIEWS = QueryField(
      fieldName: "reviews",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (ProfessionalReviews).toString()));
  static final QueryField SHOPLOCATION = QueryField(fieldName: "shopLocation");
  static final QueryField SHOPADDRESSLINE =
      QueryField(fieldName: "shopAddressLine");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Professional";
    modelSchemaDefinition.pluralName = "Professionals";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.MOBILENUMBER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.WHATSAPPNUMBER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.SHOPNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.SHOPDESCRIPTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.GEOHASH,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.OCCUPATIONNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.OCCUPATIONID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.WORKSPECIALITY,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.WORKSPECIALITYID,
        isRequired: true,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.WORKEXPERIENCE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.WORKIMAGES,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.TOTALREVIEWS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.TOTALSTARS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Professional.REVIEWS,
        isRequired: false,
        ofModelName: (ProfessionalReviews).toString(),
        associatedKey: ProfessionalReviews.PROFESSIONALID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.SHOPLOCATION,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Professional.SHOPADDRESSLINE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Professional.USER,
        isRequired: false,
        targetName: "id",
        ofModelName: (User).toString()));
  });
}

class _ProfessionalModelType extends ModelType<Professional> {
  const _ProfessionalModelType();

  @override
  Professional fromJson(Map<String, dynamic> jsonData) {
    return Professional.fromJson(jsonData);
  }
}
