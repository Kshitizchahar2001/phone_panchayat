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

import 'package:online_panchayat_flutter/enum/education.dart';
import 'package:online_panchayat_flutter/enum/gotre.dart';
import 'package:online_panchayat_flutter/enum/lookingFor.dart';
import 'package:online_panchayat_flutter/enum/maritalStatus.dart';
import 'package:online_panchayat_flutter/enum/profileFor.dart';
import 'package:online_panchayat_flutter/enum/rashi.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/models/Sibling.dart';

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the MatrimonialProfile type in your schema. */
@immutable
class MatrimonialProfile extends Model {
  static const classType = const _MatrimonialProfileModelType();
  final String id;
  final String name;
  final String mobileNumber;
  final Rashi rashi;
  final Gender gender;
  final TemporalDate dateOfBirth;
  final Education education;
  final String occupation;
  final MaritalStatus maritalStatus;
  final ProfileFor profileFor;
  final String caste;
  final Gotre gotre;
  final String height;
  final Sibling brothers;
  final Sibling sisters;
  final LookingFor lookingFor;
  final String state_id;
  final Places state_place;
  final String district_id;
  final Places district_place;
  final String profileImage;
  final bool isPaymentComplete;
  final List<String> images;
  final User user;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const MatrimonialProfile._internal(
      {@required this.id,
      this.name,
      this.mobileNumber,
      this.rashi,
      this.gender,
      this.dateOfBirth,
      this.education,
      this.occupation,
      this.maritalStatus,
      this.profileFor,
      this.caste,
      this.gotre,
      this.height,
      this.brothers,
      this.sisters,
      this.lookingFor,
      this.state_id,
      this.state_place,
      this.district_id,
      this.district_place,
      this.profileImage,
      this.isPaymentComplete,
      this.images,
      this.user});

  factory MatrimonialProfile(
      {String id,
      String name,
      String mobileNumber,
      Rashi rashi,
      Gender gender,
      TemporalDate dateOfBirth,
      Education education,
      String occupation,
      MaritalStatus maritalStatus,
      ProfileFor profileFor,
      String caste,
      Gotre gotre,
      String height,
      Sibling brothers,
      Sibling sisters,
      LookingFor lookingFor,
      String state_id,
      Places state_place,
      String district_id,
      Places district_place,
      String profileImage,
      bool isPaymentComplete,
      List<String> images,
      User user}) {
    return MatrimonialProfile._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        mobileNumber: mobileNumber,
        rashi: rashi,
        gender: gender,
        dateOfBirth: dateOfBirth,
        education: education,
        occupation: occupation,
        maritalStatus: maritalStatus,
        profileFor: profileFor,
        caste: caste,
        gotre: gotre,
        height: height,
        brothers: brothers,
        sisters: sisters,
        lookingFor: lookingFor,
        state_id: state_id,
        state_place: state_place,
        district_id: district_id,
        district_place: district_place,
        profileImage: profileImage,
        isPaymentComplete: isPaymentComplete,
        images: images != null ? List<String>.unmodifiable(images) : images,
        user: user);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MatrimonialProfile &&
        id == other.id &&
        name == other.name &&
        mobileNumber == other.mobileNumber &&
        rashi == other.rashi &&
        gender == other.gender &&
        dateOfBirth == other.dateOfBirth &&
        education == other.education &&
        occupation == other.occupation &&
        maritalStatus == other.maritalStatus &&
        profileFor == other.profileFor &&
        caste == other.caste &&
        gotre == other.gotre &&
        height == other.height &&
        brothers == other.brothers &&
        sisters == other.sisters &&
        lookingFor == other.lookingFor &&
        state_id == other.state_id &&
        state_place == other.state_place &&
        district_id == other.district_id &&
        district_place == other.district_place &&
        profileImage == other.profileImage &&
        isPaymentComplete == other.isPaymentComplete &&
        DeepCollectionEquality().equals(images, other.images) &&
        user == other.user;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MatrimonialProfile {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("mobileNumber=" + "$mobileNumber" + ", ");
    buffer.write(
        "rashi=" + (rashi != null ? enumToString(rashi) : "null") + ", ");
    buffer.write(
        "gender=" + (gender != null ? enumToString(gender) : "null") + ", ");
    buffer.write("dateOfBirth=" +
        (dateOfBirth != null ? dateOfBirth.format() : "null") +
        ", ");
    buffer.write("education=" +
        (education != null ? enumToString(education) : "null") +
        ", ");
    buffer.write("occupation=" + "$occupation" + ", ");
    buffer.write("maritalStatus=" +
        (maritalStatus != null ? enumToString(maritalStatus) : "null") +
        ", ");
    buffer.write("profileFor=" +
        (profileFor != null ? enumToString(profileFor) : "null") +
        ", ");
    buffer.write("caste=" + "$caste" + ", ");
    buffer.write(
        "gotre=" + (gotre != null ? enumToString(gotre) : "null") + ", ");
    buffer.write("height=" + "$height" + ", ");
    buffer.write(
        "brothers=" + (brothers != null ? brothers.toString() : "null") + ", ");
    buffer.write(
        "sisters=" + (sisters != null ? sisters.toString() : "null") + ", ");
    buffer.write("lookingFor=" +
        (lookingFor != null ? enumToString(lookingFor) : "null") +
        ", ");
    buffer.write("state_id=" + "$state_id" + ", ");
    buffer.write("district_id=" + "$district_id" + ", ");
    buffer.write("profileImage=" + "$profileImage" + ", ");
    buffer.write("isPaymentComplete=" +
        (isPaymentComplete != null ? isPaymentComplete.toString() : "null") +
        ", ");
    buffer.write(
        "images=" + (images != null ? images.toString() : "null") + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  MatrimonialProfile copyWith(
      {String id,
      String name,
      String mobileNumber,
      Rashi rashi,
      Gender gender,
      TemporalDate dateOfBirth,
      Education education,
      String occupation,
      MaritalStatus maritalStatus,
      ProfileFor profileFor,
      String caste,
      Gotre gotre,
      String height,
      Sibling brothers,
      Sibling sisters,
      LookingFor lookingFor,
      String state_id,
      Places state_place,
      String district_id,
      Places district_place,
      String profileImage,
      bool isPaymentComplete,
      List<String> images,
      User user}) {
    return MatrimonialProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        rashi: rashi ?? this.rashi,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        education: education ?? this.education,
        occupation: occupation ?? this.occupation,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        profileFor: profileFor ?? this.profileFor,
        caste: caste ?? this.caste,
        gotre: gotre ?? this.gotre,
        height: height ?? this.height,
        brothers: brothers ?? this.brothers,
        sisters: sisters ?? this.sisters,
        lookingFor: lookingFor ?? this.lookingFor,
        state_id: state_id ?? this.state_id,
        state_place: state_place ?? this.state_place,
        district_id: district_id ?? this.district_id,
        district_place: district_place ?? this.district_place,
        profileImage: profileImage ?? this.profileImage,
        isPaymentComplete: isPaymentComplete ?? this.isPaymentComplete,
        images: images ?? this.images,
        user: user ?? this.user);
  }

  MatrimonialProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        mobileNumber = json['mobileNumber'],
        rashi = enumFromString<Rashi>(json['rashi'], Rashi.values),
        gender = enumFromString<Gender>(json['gender'], Gender.values),
        dateOfBirth = json['dateOfBirth'] != null
            ? TemporalDate.fromString(json['dateOfBirth'])
            : null,
        education =
            enumFromString<Education>(json['education'], Education.values),
        occupation = json['occupation'],
        maritalStatus = enumFromString<MaritalStatus>(
            json['maritalStatus'], MaritalStatus.values),
        profileFor =
            enumFromString<ProfileFor>(json['profileFor'], ProfileFor.values),
        caste = json['caste'],
        gotre = enumFromString<Gotre>(json['gotre'], Gotre.values),
        height = json['height'],
        brothers = json['brothers'] != null
            ? Sibling.fromJson(new Map<String, dynamic>.from(json['brothers']))
            : null,
        sisters = json['sisters'] != null
            ? Sibling.fromJson(new Map<String, dynamic>.from(json['sisters']))
            : null,
        lookingFor =
            enumFromString<LookingFor>(json['lookingFor'], LookingFor.values),
        state_id = json['state_id'],
        state_place = json['state_place'] != null
            ? Places.fromJson(
                new Map<String, dynamic>.from(json['state_place']))
            : null,
        district_id = json['district_id'],
        district_place = json['district_place'] != null
            ? Places.fromJson(
                new Map<String, dynamic>.from(json['district_place']))
            : null,
        profileImage = json['profileImage'],
        isPaymentComplete = json['isPaymentComplete'],
        images = json['images']?.cast<String>(),
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobileNumber': mobileNumber,
        'rashi': enumToString(rashi),
        'gender': enumToString(gender),
        'dateOfBirth': dateOfBirth?.format(),
        'education': enumToString(education),
        'occupation': occupation,
        'maritalStatus': enumToString(maritalStatus),
        'profileFor': enumToString(profileFor),
        'caste': caste,
        'gotre': enumToString(gotre),
        'height': height,
        'brothers': brothers?.toJson(),
        'sisters': sisters?.toJson(),
        'lookingFor': enumToString(lookingFor),
        'state_id': state_id,
        'state_place': state_place?.toJson(),
        'district_id': district_id,
        'district_place': district_place?.toJson(),
        'profileImage': profileImage,
        'isPaymentComplete': isPaymentComplete,
        'images': images,
        'user': user?.toJson()
      };

  static final QueryField ID = QueryField(fieldName: "matrimonialProfile.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField MOBILENUMBER = QueryField(fieldName: "mobileNumber");
  static final QueryField RASHI = QueryField(fieldName: "rashi");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField DATEOFBIRTH = QueryField(fieldName: "dateOfBirth");
  static final QueryField EDUCATION = QueryField(fieldName: "education");
  static final QueryField OCCUPATION = QueryField(fieldName: "occupation");
  static final QueryField MARITALSTATUS =
      QueryField(fieldName: "maritalStatus");
  static final QueryField PROFILEFOR = QueryField(fieldName: "profileFor");
  static final QueryField CASTE = QueryField(fieldName: "caste");
  static final QueryField GOTRE = QueryField(fieldName: "gotre");
  static final QueryField HEIGHT = QueryField(fieldName: "height");
  static final QueryField BROTHERS = QueryField(fieldName: "brothers");
  static final QueryField SISTERS = QueryField(fieldName: "sisters");
  static final QueryField LOOKINGFOR = QueryField(fieldName: "lookingFor");
  static final QueryField STATE_ID = QueryField(fieldName: "state_id");
  static final QueryField STATE_PLACE = QueryField(
      fieldName: "state_place",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Places).toString()));
  static final QueryField DISTRICT_ID = QueryField(fieldName: "district_id");
  static final QueryField DISTRICT_PLACE = QueryField(
      fieldName: "district_place",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Places).toString()));
  static final QueryField PROFILEIMAGE = QueryField(fieldName: "profileImage");
  static final QueryField ISPAYMENTCOMPLETE =
      QueryField(fieldName: "isPaymentComplete");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MatrimonialProfile";
    modelSchemaDefinition.pluralName = "MatrimonialProfiles";

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
        key: MatrimonialProfile.NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.MOBILENUMBER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.RASHI,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.GENDER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.DATEOFBIRTH,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.date)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.EDUCATION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.OCCUPATION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.MARITALSTATUS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.PROFILEFOR,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.CASTE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.GOTRE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.HEIGHT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.BROTHERS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.SISTERS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.LOOKINGFOR,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.STATE_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: MatrimonialProfile.STATE_PLACE,
        isRequired: false,
        ofModelName: (Places).toString(),
        associatedKey: Places.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.DISTRICT_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: MatrimonialProfile.DISTRICT_PLACE,
        isRequired: false,
        ofModelName: (Places).toString(),
        associatedKey: Places.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.PROFILEIMAGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.ISPAYMENTCOMPLETE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MatrimonialProfile.IMAGES,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: MatrimonialProfile.USER,
        isRequired: false,
        targetName: "id",
        ofModelName: (User).toString()));
  });
}

class _MatrimonialProfileModelType extends ModelType<MatrimonialProfile> {
  const _MatrimonialProfileModelType();

  @override
  MatrimonialProfile fromJson(Map<String, dynamic> jsonData) {
    return MatrimonialProfile.fromJson(jsonData);
  }
}
