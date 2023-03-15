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

import 'package:online_panchayat_flutter/enum/subscription_plan.dart';
import 'package:online_panchayat_flutter/models/AdditionalTehsil.dart';
import 'package:online_panchayat_flutter/models/CasteCommunity.dart';
import 'package:online_panchayat_flutter/models/DesignatedUserType.dart';
import 'package:online_panchayat_flutter/models/GroupUserRelation.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/models/Post.dart';
import 'package:online_panchayat_flutter/models/UserSubscription.dart';

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String name;
  final String image;
  final Gender gender;
  final String deviceToken;
  final Location homeAdressLocation;
  final bool canCreatePost;
  final String designation;
  final String mobileNumber;
  final String aadharNumber;
  final String homeAdressName;
  final TemporalDate dateOfBirth;
  final List<FollowRelationships> following;
  final List<FollowRelationships> follwers;
  final String area;
  final List<Post> posts;
  final String pincode;
  final String aadhaarImageUrl;
  final bool isUserVerified;
  final List<GroupUserRelation> groups;
  final CasteCommunity community;
  final String referrerId;
  final int totalPoints;
  final int claimedPoints;
  final int onHoldPoints;
  final int balancePoints;
  final bool raisedClaimRequest;
  final bool isDesignatedUser;
  final int totalReferrals;
  final DesignatedUserType type;
  final String identifier_1;
  final String identifier_2;
  final String identifier_1_id;
  final String identifier_2_id;
  final String identifier_1_pincode;
  final bool retentionPeriodComplete;
  final String tag;
  final String state_id;
  final Places state_place;
  final String district_id;
  final Places district_place;
  final String place_1_id;
  final Places place_1_place;
  final String place_2_id;
  final Places place_2_place;
  final List<AdditionalTehsils> additionalTehsils;
  final SubscriptionPlan subscriptionPlan;
  final List<SubscriptionPlan> subscriptionPlanList;
  final bool isMatrimonialProfileComplete;
  final MatrimonialProfile matrimonialProfile;
  final List<UserSubscription> subscription;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const User._internal(
      {@required this.id,
      this.name,
      this.image,
      this.gender,
      this.deviceToken,
      @required this.homeAdressLocation,
      this.canCreatePost,
      this.designation,
      this.mobileNumber,
      this.aadharNumber,
      this.homeAdressName,
      this.dateOfBirth,
      this.following,
      this.follwers,
      @required this.area,
      this.posts,
      @required this.pincode,
      this.aadhaarImageUrl,
      this.isUserVerified,
      this.groups,
      this.community,
      this.referrerId,
      this.totalPoints,
      this.claimedPoints,
      this.onHoldPoints,
      this.balancePoints,
      this.raisedClaimRequest,
      this.isDesignatedUser,
      this.totalReferrals,
      this.type,
      this.identifier_1,
      this.identifier_2,
      this.identifier_1_id,
      this.identifier_2_id,
      this.identifier_1_pincode,
      this.retentionPeriodComplete,
      this.tag,
      this.state_id,
      this.state_place,
      this.district_id,
      this.district_place,
      this.place_1_id,
      this.place_1_place,
      this.place_2_id,
      this.place_2_place,
      this.additionalTehsils,
      this.subscriptionPlan,
      this.subscriptionPlanList,
      this.isMatrimonialProfileComplete,
      this.matrimonialProfile,
      this.subscription});

  factory User(
      {String id,
      String name,
      String image,
      Gender gender,
      String deviceToken,
      @required Location homeAdressLocation,
      bool canCreatePost,
      String designation,
      String mobileNumber,
      String aadharNumber,
      String homeAdressName,
      TemporalDate dateOfBirth,
      List<FollowRelationships> following,
      List<FollowRelationships> follwers,
      @required String area,
      List<Post> posts,
      @required String pincode,
      String aadhaarImageUrl,
      bool isUserVerified,
      List<GroupUserRelation> groups,
      CasteCommunity community,
      String referrerId,
      int totalPoints,
      int claimedPoints,
      int onHoldPoints,
      int balancePoints,
      bool raisedClaimRequest,
      bool isDesignatedUser,
      int totalReferrals,
      DesignatedUserType type,
      String identifier_1,
      String identifier_2,
      String identifier_1_id,
      String identifier_2_id,
      String identifier_1_pincode,
      bool retentionPeriodComplete,
      String tag,
      String state_id,
      Places state_place,
      String district_id,
      Places district_place,
      String place_1_id,
      Places place_1_place,
      String place_2_id,
      Places place_2_place,
      List<AdditionalTehsils> additionalTehsils,
      SubscriptionPlan subscriptionPlan,
      List<SubscriptionPlan> subscriptionPlanList,
      bool isMatrimonialProfileComplete,
      MatrimonialProfile matrimonialProfile,
      List<UserSubscription> subscription}) {
    return User._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        image: image,
        gender: gender,
        deviceToken: deviceToken,
        homeAdressLocation: homeAdressLocation,
        canCreatePost: canCreatePost,
        designation: designation,
        mobileNumber: mobileNumber,
        aadharNumber: aadharNumber,
        homeAdressName: homeAdressName,
        dateOfBirth: dateOfBirth,
        following: following != null
            ? List<FollowRelationships>.unmodifiable(following)
            : following,
        follwers: follwers != null
            ? List<FollowRelationships>.unmodifiable(follwers)
            : follwers,
        area: area,
        posts: posts != null ? List<Post>.unmodifiable(posts) : posts,
        pincode: pincode,
        aadhaarImageUrl: aadhaarImageUrl,
        isUserVerified: isUserVerified,
        groups: groups != null
            ? List<GroupUserRelation>.unmodifiable(groups)
            : groups,
        community: community,
        referrerId: referrerId,
        totalPoints: totalPoints,
        claimedPoints: claimedPoints,
        onHoldPoints: onHoldPoints,
        balancePoints: balancePoints,
        raisedClaimRequest: raisedClaimRequest,
        isDesignatedUser: isDesignatedUser,
        totalReferrals: totalReferrals,
        type: type,
        identifier_1: identifier_1,
        identifier_2: identifier_2,
        identifier_1_id: identifier_1_id,
        identifier_2_id: identifier_2_id,
        identifier_1_pincode: identifier_1_pincode,
        retentionPeriodComplete: retentionPeriodComplete,
        tag: tag,
        state_id: state_id,
        state_place: state_place,
        district_id: district_id,
        district_place: district_place,
        place_1_id: place_1_id,
        place_1_place: place_1_place,
        place_2_id: place_2_id,
        place_2_place: place_2_place,
        additionalTehsils: additionalTehsils != null
            ? List<AdditionalTehsils>.unmodifiable(additionalTehsils)
            : additionalTehsils,
        subscriptionPlan: subscriptionPlan,
        subscriptionPlanList: subscriptionPlanList != null
            ? List<SubscriptionPlan>.unmodifiable(subscriptionPlanList)
            : subscriptionPlanList,
        isMatrimonialProfileComplete: isMatrimonialProfileComplete,
        matrimonialProfile: matrimonialProfile,
        subscription: subscription != null
            ? List<UserSubscription>.unmodifiable(subscription)
            : subscription);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        name == other.name &&
        image == other.image &&
        gender == other.gender &&
        deviceToken == other.deviceToken &&
        homeAdressLocation == other.homeAdressLocation &&
        canCreatePost == other.canCreatePost &&
        designation == other.designation &&
        mobileNumber == other.mobileNumber &&
        aadharNumber == other.aadharNumber &&
        homeAdressName == other.homeAdressName &&
        dateOfBirth == other.dateOfBirth &&
        DeepCollectionEquality().equals(following, other.following) &&
        DeepCollectionEquality().equals(follwers, other.follwers) &&
        area == other.area &&
        DeepCollectionEquality().equals(posts, other.posts) &&
        pincode == other.pincode &&
        aadhaarImageUrl == other.aadhaarImageUrl &&
        isUserVerified == other.isUserVerified &&
        DeepCollectionEquality().equals(groups, other.groups) &&
        community == other.community &&
        referrerId == other.referrerId &&
        totalPoints == other.totalPoints &&
        claimedPoints == other.claimedPoints &&
        onHoldPoints == other.onHoldPoints &&
        balancePoints == other.balancePoints &&
        raisedClaimRequest == other.raisedClaimRequest &&
        isDesignatedUser == other.isDesignatedUser &&
        totalReferrals == other.totalReferrals &&
        type == other.type &&
        identifier_1 == other.identifier_1 &&
        identifier_2 == other.identifier_2 &&
        identifier_1_id == other.identifier_1_id &&
        identifier_2_id == other.identifier_2_id &&
        identifier_1_pincode == other.identifier_1_pincode &&
        retentionPeriodComplete == other.retentionPeriodComplete &&
        tag == other.tag &&
        state_id == other.state_id &&
        state_place == other.state_place &&
        district_id == other.district_id &&
        district_place == other.district_place &&
        place_1_id == other.place_1_id &&
        place_1_place == other.place_1_place &&
        place_2_id == other.place_2_id &&
        place_2_place == other.place_2_place &&
        DeepCollectionEquality()
            .equals(additionalTehsils, other.additionalTehsils) &&
        subscriptionPlan == other.subscriptionPlan &&
        DeepCollectionEquality()
            .equals(subscriptionPlanList, other.subscriptionPlanList) &&
        isMatrimonialProfileComplete == other.isMatrimonialProfileComplete &&
        matrimonialProfile == other.matrimonialProfile &&
        DeepCollectionEquality().equals(subscription, other.subscription);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("image=" + "$image" + ", ");
    buffer.write(
        "gender=" + (gender != null ? enumToString(gender) : "null") + ", ");
    buffer.write("deviceToken=" + "$deviceToken" + ", ");
    buffer.write("homeAdressLocation=" +
        (homeAdressLocation != null ? homeAdressLocation.toString() : "null") +
        ", ");
    buffer.write("canCreatePost=" +
        (canCreatePost != null ? canCreatePost.toString() : "null") +
        ", ");
    buffer.write("designation=" + "$designation" + ", ");
    buffer.write("mobileNumber=" + "$mobileNumber" + ", ");
    buffer.write("aadharNumber=" + "$aadharNumber" + ", ");
    buffer.write("homeAdressName=" + "$homeAdressName" + ", ");
    buffer.write("dateOfBirth=" +
        (dateOfBirth != null ? dateOfBirth.format() : "null") +
        ", ");
    buffer.write("area=" + "$area" + ", ");
    buffer.write("pincode=" + "$pincode" + ", ");
    buffer.write("aadhaarImageUrl=" + "$aadhaarImageUrl" + ", ");
    buffer.write("isUserVerified=" +
        (isUserVerified != null ? isUserVerified.toString() : "null") +
        ", ");
    buffer.write("community=" +
        (community != null ? community.toString() : "null") +
        ", ");
    buffer.write("referrerId=" + "$referrerId" + ", ");
    buffer.write("totalPoints=" +
        (totalPoints != null ? totalPoints.toString() : "null") +
        ", ");
    buffer.write("claimedPoints=" +
        (claimedPoints != null ? claimedPoints.toString() : "null") +
        ", ");
    buffer.write("onHoldPoints=" +
        (onHoldPoints != null ? onHoldPoints.toString() : "null") +
        ", ");
    buffer.write("balancePoints=" +
        (balancePoints != null ? balancePoints.toString() : "null") +
        ", ");
    buffer.write("raisedClaimRequest=" +
        (raisedClaimRequest != null ? raisedClaimRequest.toString() : "null") +
        ", ");
    buffer.write("isDesignatedUser=" +
        (isDesignatedUser != null ? isDesignatedUser.toString() : "null") +
        ", ");
    buffer.write("totalReferrals=" +
        (totalReferrals != null ? totalReferrals.toString() : "null") +
        ", ");
    buffer.write("type=" + (type != null ? enumToString(type) : "null") + ", ");
    buffer.write("identifier_1=" + "$identifier_1" + ", ");
    buffer.write("identifier_2=" + "$identifier_2" + ", ");
    buffer.write("identifier_1_id=" + "$identifier_1_id" + ", ");
    buffer.write("identifier_2_id=" + "$identifier_2_id" + ", ");
    buffer.write("identifier_1_pincode=" + "$identifier_1_pincode" + ", ");
    buffer.write("retentionPeriodComplete=" +
        (retentionPeriodComplete != null
            ? retentionPeriodComplete.toString()
            : "null") +
        ", ");
    buffer.write("tag=" + "$tag" + ", ");
    buffer.write("state_id=" + "$state_id" + ", ");
    buffer.write("district_id=" + "$district_id" + ", ");
    buffer.write("place_1_id=" + "$place_1_id" + ", ");
    buffer.write("place_2_id=" + "$place_2_id" + ", ");
    buffer.write("subscriptionPlan=" +
        (subscriptionPlan != null ? enumToString(subscriptionPlan) : "null") +
        ", ");
    buffer.write("subscriptionPlanList=" +
        subscriptionPlanList?.map((e) => enumToString(e)).toString() +
        ", ");
    buffer.write("isMatrimonialProfileComplete=" +
        (isMatrimonialProfileComplete != null
            ? isMatrimonialProfileComplete.toString()
            : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  User copyWith(
      {String id,
      String name,
      String image,
      Gender gender,
      String deviceToken,
      Location homeAdressLocation,
      bool canCreatePost,
      String designation,
      String mobileNumber,
      String aadharNumber,
      String homeAdressName,
      TemporalDate dateOfBirth,
      List<FollowRelationships> following,
      List<FollowRelationships> follwers,
      String area,
      List<Post> posts,
      String pincode,
      String aadhaarImageUrl,
      bool isUserVerified,
      List<GroupUserRelation> groups,
      CasteCommunity community,
      String referrerId,
      int totalPoints,
      int claimedPoints,
      int onHoldPoints,
      int balancePoints,
      bool raisedClaimRequest,
      bool isDesignatedUser,
      int totalReferrals,
      DesignatedUserType type,
      String identifier_1,
      String identifier_2,
      String identifier_1_id,
      String identifier_2_id,
      String identifier_1_pincode,
      bool retentionPeriodComplete,
      String tag,
      String state_id,
      Places state_place,
      String district_id,
      Places district_place,
      String place_1_id,
      Places place_1_place,
      String place_2_id,
      Places place_2_place,
      List<AdditionalTehsils> additionalTehsils,
      SubscriptionPlan subscriptionPlan,
      List<SubscriptionPlan> subscriptionPlanList,
      bool isMatrimonialProfileComplete,
      MatrimonialProfile matrimonialProfile,
      List<UserSubscription> subscription}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        gender: gender ?? this.gender,
        deviceToken: deviceToken ?? this.deviceToken,
        homeAdressLocation: homeAdressLocation ?? this.homeAdressLocation,
        canCreatePost: canCreatePost ?? this.canCreatePost,
        designation: designation ?? this.designation,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        aadharNumber: aadharNumber ?? this.aadharNumber,
        homeAdressName: homeAdressName ?? this.homeAdressName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        following: following ?? this.following,
        follwers: follwers ?? this.follwers,
        area: area ?? this.area,
        posts: posts ?? this.posts,
        pincode: pincode ?? this.pincode,
        aadhaarImageUrl: aadhaarImageUrl ?? this.aadhaarImageUrl,
        isUserVerified: isUserVerified ?? this.isUserVerified,
        groups: groups ?? this.groups,
        community: community ?? this.community,
        referrerId: referrerId ?? this.referrerId,
        totalPoints: totalPoints ?? this.totalPoints,
        claimedPoints: claimedPoints ?? this.claimedPoints,
        onHoldPoints: onHoldPoints ?? this.onHoldPoints,
        balancePoints: balancePoints ?? this.balancePoints,
        raisedClaimRequest: raisedClaimRequest ?? this.raisedClaimRequest,
        isDesignatedUser: isDesignatedUser ?? this.isDesignatedUser,
        totalReferrals: totalReferrals ?? this.totalReferrals,
        type: type ?? this.type,
        identifier_1: identifier_1 ?? this.identifier_1,
        identifier_2: identifier_2 ?? this.identifier_2,
        identifier_1_id: identifier_1_id ?? this.identifier_1_id,
        identifier_2_id: identifier_2_id ?? this.identifier_2_id,
        identifier_1_pincode: identifier_1_pincode ?? this.identifier_1_pincode,
        retentionPeriodComplete:
            retentionPeriodComplete ?? this.retentionPeriodComplete,
        tag: tag ?? this.tag,
        state_id: state_id ?? this.state_id,
        state_place: state_place ?? this.state_place,
        district_id: district_id ?? this.district_id,
        district_place: district_place ?? this.district_place,
        place_1_id: place_1_id ?? this.place_1_id,
        place_1_place: place_1_place ?? this.place_1_place,
        place_2_id: place_2_id ?? this.place_2_id,
        place_2_place: place_2_place ?? this.place_2_place,
        additionalTehsils: additionalTehsils ?? this.additionalTehsils,
        subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
        subscriptionPlanList: subscriptionPlanList ?? this.subscriptionPlanList,
        isMatrimonialProfileComplete:
            isMatrimonialProfileComplete ?? this.isMatrimonialProfileComplete,
        matrimonialProfile: matrimonialProfile ?? this.matrimonialProfile,
        subscription: subscription ?? this.subscription);
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        gender = enumFromString<Gender>(json['gender'], Gender.values),
        deviceToken = json['deviceToken'],
        homeAdressLocation = json['homeAdressLocation'] != null
            ? Location.fromJson(
                new Map<String, dynamic>.from(json['homeAdressLocation']))
            : null,
        canCreatePost = json['canCreatePost'],
        designation = json['designation'],
        mobileNumber = json['mobileNumber'],
        aadharNumber = json['aadharNumber'],
        homeAdressName = json['homeAdressName'],
        dateOfBirth = json['dateOfBirth'] != null
            ? TemporalDate.fromString(json['dateOfBirth'])
            : null,
        following = json['following'] is List
            ? (json['following'] as List)
                .map((e) => FollowRelationships.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        follwers = json['follwers'] is List
            ? (json['follwers'] as List)
                .map((e) => FollowRelationships.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        area = json['area'],
        posts = json['posts'] is List
            ? (json['posts'] as List)
                .map((e) => Post.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        pincode = json['pincode'],
        aadhaarImageUrl = json['aadhaarImageUrl'],
        isUserVerified = json['isUserVerified'],
        groups = json['groups'] is List
            ? (json['groups'] as List)
                .map((e) => GroupUserRelation.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        community = json['community'] != null
            ? CasteCommunity.fromJson(
                new Map<String, dynamic>.from(json['community']))
            : null,
        referrerId = json['referrerId'],
        totalPoints = (json['totalPoints'] as num)?.toInt(),
        claimedPoints = (json['claimedPoints'] as num)?.toInt(),
        onHoldPoints = (json['onHoldPoints'] as num)?.toInt(),
        balancePoints = (json['balancePoints'] as num)?.toInt(),
        raisedClaimRequest = json['raisedClaimRequest'],
        isDesignatedUser = json['isDesignatedUser'],
        totalReferrals = (json['totalReferrals'] as num)?.toInt(),
        type = enumFromString<DesignatedUserType>(
            json['type'], DesignatedUserType.values),
        identifier_1 = json['identifier_1'],
        identifier_2 = json['identifier_2'],
        identifier_1_id = json['identifier_1_id'],
        identifier_2_id = json['identifier_2_id'],
        identifier_1_pincode = json['identifier_1_pincode'],
        retentionPeriodComplete = json['retentionPeriodComplete'],
        tag = json['tag'],
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
        place_1_id = json['place_1_id'],
        place_1_place = json['place_1_place'] != null
            ? Places.fromJson(
                new Map<String, dynamic>.from(json['place_1_place']))
            : null,
        place_2_id = json['place_2_id'],
        place_2_place = json['place_2_place'] != null
            ? Places.fromJson(
                new Map<String, dynamic>.from(json['place_2_place']))
            : null,
        additionalTehsils = json['additionalTehsils'] != null
            ? (json['additionalTehsils']['items'] as List)
                .map((e) => AdditionalTehsils.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        subscriptionPlan = enumFromString<SubscriptionPlan>(
            json['subscriptionPlan'], SubscriptionPlan.values),
        subscriptionPlanList = json["subscriptionPlanList"] != null
            ? json['subscriptionPlanList'] is List
                ? (json['subscriptionPlanList'] as List)
                    .map((e) => enumFromString<SubscriptionPlan>(
                        e, SubscriptionPlan.values))
                    .toList()
                : null
            : null,
        isMatrimonialProfileComplete = json['isMatrimonialProfileComplete'],
        matrimonialProfile = json['matrimonialProfile'] != null
            ? MatrimonialProfile.fromJson(
                new Map<String, dynamic>.from(json['matrimonialProfile']))
            : null,
        subscription = json['subscription'] != null
            ? (json['subscription']["items"] is List)
                ? (json['subscription']["items"] as List)
                    .map((e) => UserSubscription.fromJson(
                        new Map<String, dynamic>.from(e)))
                    .toList()
                : null
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'gender': enumToString(gender),
        'deviceToken': deviceToken,
        'homeAdressLocation': homeAdressLocation?.toJson(),
        'canCreatePost': canCreatePost,
        'designation': designation,
        'mobileNumber': mobileNumber,
        'aadharNumber': aadharNumber,
        'homeAdressName': homeAdressName,
        'dateOfBirth': dateOfBirth?.format(),
        'following':
            following?.map((FollowRelationships e) => e?.toJson())?.toList(),
        'follwers':
            follwers?.map((FollowRelationships e) => e?.toJson())?.toList(),
        'area': area,
        'posts': posts?.map((Post e) => e?.toJson())?.toList(),
        'pincode': pincode,
        'aadhaarImageUrl': aadhaarImageUrl,
        'isUserVerified': isUserVerified,
        'groups': groups?.map((GroupUserRelation e) => e?.toJson())?.toList(),
        'community': community?.toJson(),
        'referrerId': referrerId,
        'totalPoints': totalPoints,
        'claimedPoints': claimedPoints,
        'onHoldPoints': onHoldPoints,
        'balancePoints': balancePoints,
        'raisedClaimRequest': raisedClaimRequest,
        'isDesignatedUser': isDesignatedUser,
        'totalReferrals': totalReferrals,
        'type': enumToString(type),
        'identifier_1': identifier_1,
        'identifier_2': identifier_2,
        'identifier_1_id': identifier_1_id,
        'identifier_2_id': identifier_2_id,
        'identifier_1_pincode': identifier_1_pincode,
        'retentionPeriodComplete': retentionPeriodComplete,
        'tag': tag,
        'state_id': state_id,
        'state_place': state_place?.toJson(),
        'district_id': district_id,
        'district_place': district_place?.toJson(),
        'place_1_id': place_1_id,
        'place_1_place': place_1_place?.toJson(),
        'place_2_id': place_2_id,
        'place_2_place': place_2_place?.toJson(),
        'additionalTehsils': additionalTehsils
            ?.map((AdditionalTehsils e) => e?.toJson())
            ?.toList(),
        'subscriptionPlan': enumToString(subscriptionPlan),
        'subscriptionPlanList':
            subscriptionPlanList?.map((e) => enumToString(e))?.toList(),
        'isMatrimonialProfileComplete': isMatrimonialProfileComplete,
        'matrimonialProfile': matrimonialProfile?.toJson(),
        'subscription':
            subscription?.map((UserSubscription e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField IMAGE = QueryField(fieldName: "image");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField DEVICETOKEN = QueryField(fieldName: "deviceToken");
  static final QueryField HOMEADRESSLOCATION =
      QueryField(fieldName: "homeAdressLocation");
  static final QueryField CANCREATEPOST =
      QueryField(fieldName: "canCreatePost");
  static final QueryField DESIGNATION = QueryField(fieldName: "designation");
  static final QueryField MOBILENUMBER = QueryField(fieldName: "mobileNumber");
  static final QueryField AADHARNUMBER = QueryField(fieldName: "aadharNumber");
  static final QueryField HOMEADRESSNAME =
      QueryField(fieldName: "homeAdressName");
  static final QueryField DATEOFBIRTH = QueryField(fieldName: "dateOfBirth");
  static final QueryField FOLLOWING = QueryField(
      fieldName: "following",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (FollowRelationships).toString()));
  static final QueryField FOLLWERS = QueryField(
      fieldName: "follwers",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (FollowRelationships).toString()));
  static final QueryField AREA = QueryField(fieldName: "area");
  static final QueryField POSTS = QueryField(
      fieldName: "posts",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Post).toString()));
  static final QueryField PINCODE = QueryField(fieldName: "pincode");
  static final QueryField AADHAARIMAGEURL =
      QueryField(fieldName: "aadhaarImageUrl");
  static final QueryField ISUSERVERIFIED =
      QueryField(fieldName: "isUserVerified");
  static final QueryField GROUPS = QueryField(
      fieldName: "groups",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (GroupUserRelation).toString()));
  static final QueryField COMMUNITY = QueryField(
      fieldName: "community",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (CasteCommunity).toString()));
  static final QueryField REFERRERID = QueryField(fieldName: "referrerId");
  static final QueryField TOTALPOINTS = QueryField(fieldName: "totalPoints");
  static final QueryField CLAIMEDPOINTS =
      QueryField(fieldName: "claimedPoints");
  static final QueryField ONHOLDPOINTS = QueryField(fieldName: "onHoldPoints");
  static final QueryField BALANCEPOINTS =
      QueryField(fieldName: "balancePoints");
  static final QueryField RAISEDCLAIMREQUEST =
      QueryField(fieldName: "raisedClaimRequest");
  static final QueryField ISDESIGNATEDUSER =
      QueryField(fieldName: "isDesignatedUser");
  static final QueryField TOTALREFERRALS =
      QueryField(fieldName: "totalReferrals");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField IDENTIFIER_1 = QueryField(fieldName: "identifier_1");
  static final QueryField IDENTIFIER_2 = QueryField(fieldName: "identifier_2");
  static final QueryField IDENTIFIER_1_ID =
      QueryField(fieldName: "identifier_1_id");
  static final QueryField IDENTIFIER_2_ID =
      QueryField(fieldName: "identifier_2_id");
  static final QueryField IDENTIFIER_1_PINCODE =
      QueryField(fieldName: "identifier_1_pincode");
  static final QueryField RETENTIONPERIODCOMPLETE =
      QueryField(fieldName: "retentionPeriodComplete");
  static final QueryField TAG = QueryField(fieldName: "tag");
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
  static final QueryField PLACE_1_ID = QueryField(fieldName: "place_1_id");
  static final QueryField PLACE_1_PLACE = QueryField(
      fieldName: "place_1_place",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Places).toString()));
  static final QueryField PLACE_2_ID = QueryField(fieldName: "place_2_id");
  static final QueryField PLACE_2_PLACE = QueryField(
      fieldName: "place_2_place",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Places).toString()));
  static final QueryField ADDITIONALTEHSILS = QueryField(
      fieldName: "additionalTehsils",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (AdditionalTehsils).toString()));
  static final QueryField SUBSCRIPTIONPLAN =
      QueryField(fieldName: "subscriptionPlan");
  static final QueryField SUBSCRIPTIONPLANLIST =
      QueryField(fieldName: "subscriptionPlanList");
  static final QueryField ISMATRIMONIALPROFILECOMPLETE =
      QueryField(fieldName: "isMatrimonialProfileComplete");
  static final QueryField MATRIMONIALPROFILE = QueryField(
      fieldName: "matrimonialProfile",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (MatrimonialProfile).toString()));
  static final QueryField SUBSCRIPTION = QueryField(
      fieldName: "subscription",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (UserSubscription).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";

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
        key: User.NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.IMAGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.GENDER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.DEVICETOKEN,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.HOMEADRESSLOCATION,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.CANCREATEPOST,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.DESIGNATION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.MOBILENUMBER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.AADHARNUMBER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.HOMEADRESSNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.DATEOFBIRTH,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.date)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: User.FOLLOWING,
        isRequired: false,
        ofModelName: (FollowRelationships).toString(),
        associatedKey: FollowRelationships.FOLLOWERID));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: User.FOLLWERS,
        isRequired: false,
        ofModelName: (FollowRelationships).toString(),
        associatedKey: FollowRelationships.FOLLOWEEID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.AREA,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: User.POSTS,
        isRequired: false,
        ofModelName: (Post).toString(),
        associatedKey: Post.USER));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.PINCODE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.AADHAARIMAGEURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.ISUSERVERIFIED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: User.GROUPS,
        isRequired: false,
        ofModelName: (GroupUserRelation).toString(),
        associatedKey: GroupUserRelation.USER));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: User.COMMUNITY,
        isRequired: false,
        targetName: "communityId",
        ofModelName: (CasteCommunity).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.REFERRERID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.TOTALPOINTS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.CLAIMEDPOINTS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.ONHOLDPOINTS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.BALANCEPOINTS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.RAISEDCLAIMREQUEST,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.ISDESIGNATEDUSER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.TOTALREFERRALS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.TYPE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.IDENTIFIER_1,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.IDENTIFIER_2,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.IDENTIFIER_1_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.IDENTIFIER_2_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.IDENTIFIER_1_PINCODE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.RETENTIONPERIODCOMPLETE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.TAG,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.STATE_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: User.STATE_PLACE,
        isRequired: false,
        ofModelName: (Places).toString(),
        associatedKey: Places.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.DISTRICT_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: User.DISTRICT_PLACE,
        isRequired: false,
        ofModelName: (Places).toString(),
        associatedKey: Places.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.PLACE_1_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: User.PLACE_1_PLACE,
        isRequired: false,
        ofModelName: (Places).toString(),
        associatedKey: Places.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.PLACE_2_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: User.PLACE_2_PLACE,
        isRequired: false,
        ofModelName: (Places).toString(),
        associatedKey: Places.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: User.ADDITIONALTEHSILS,
        isRequired: false,
        ofModelName: (AdditionalTehsils).toString(),
        associatedKey: AdditionalTehsils.USERID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.SUBSCRIPTIONPLAN,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.SUBSCRIPTIONPLANLIST,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.enumeration))));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.ISMATRIMONIALPROFILECOMPLETE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: User.MATRIMONIALPROFILE,
        isRequired: false,
        ofModelName: (MatrimonialProfile).toString(),
        associatedKey: MatrimonialProfile.USER));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: User.SUBSCRIPTION,
        isRequired: false,
        ofModelName: (UserSubscription).toString(),
        associatedKey: UserSubscription.USERID));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();

  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}
