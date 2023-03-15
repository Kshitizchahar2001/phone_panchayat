// ignore_for_file: file_names, slash_for_doc_comments, unnecessary_const, prefer_if_null_operators, prefer_const_constructors, unnecessary_new, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, annotate_overrides, non_constant_identifier_names, prefer_const_literals_to_create_immutables

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

// ignore_for_file: public_member_api_docs

import 'Location.dart';
import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'PostCategory.dart';

/** This is an auto generated class representing the Post type in your schema. */
@immutable
class Post extends Model {
  static const classType = const _PostModelType();
  final String id;
  final User user;
  final String pincode;
  final String content;
  final PostType postType;
  final PostContentType postContentType;
  final PostCategory postCategory;
  final String panchayatSummiti;
  final String gramPanchayat;
  final String municipality;
  final int ward;
  final String imageURL;
  final String videoURL;
  final List<Comment> comments;
  final List<Reactions> reactions;
  final int noOfLikes;
  final TemporalDateTime updatedAt;
  final TemporalDateTime createdAt;
  final int noOfViews;
  final Location location;
  final bool shareDisabled;
  final bool reactionDisabled;
  final bool commentDisabled;
  final Status status;
  final String hashTag;
  final String shareURL;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Post._internal(
      {@required this.id,
      this.user,
      @required this.pincode,
      this.content,
      @required this.postType,
      this.postContentType,
      this.postCategory,
      this.panchayatSummiti,
      this.gramPanchayat,
      this.municipality,
      this.ward,
      this.imageURL,
      this.videoURL,
      this.comments,
      this.reactions,
      @required this.noOfLikes,
      this.updatedAt,
      this.createdAt,
      @required this.noOfViews,
      @required this.location,
      this.shareDisabled,
      this.reactionDisabled,
      this.commentDisabled,
      this.status,
      this.hashTag,
      this.shareURL});

  factory Post(
      {String id,
      User user,
      @required String pincode,
      String content,
      @required PostType postType,
      PostContentType postContentType,
      PostCategory postCategory,
      String panchayatSummiti,
      String gramPanchayat,
      String municipality,
      int ward,
      String imageURL,
      String videoURL,
      List<Comment> comments,
      List<Reactions> reactions,
      @required int noOfLikes,
      TemporalDateTime updatedAt,
      TemporalDateTime createdAt,
      @required int noOfViews,
      @required Location location,
      bool shareDisabled,
      bool reactionDisabled,
      bool commentDisabled,
      Status status,
      String hashTag,
      String shareURL}) {
    return Post._internal(
        id: id == null ? UUID.getUUID() : id,
        user: user,
        pincode: pincode,
        content: content,
        postType: postType,
        postContentType: postContentType,
        postCategory: postCategory,
        panchayatSummiti: panchayatSummiti,
        gramPanchayat: gramPanchayat,
        municipality: municipality,
        ward: ward,
        imageURL: imageURL,
        videoURL: videoURL,
        comments: comments != null ? List.unmodifiable(comments) : comments,
        reactions: reactions != null ? List.unmodifiable(reactions) : reactions,
        noOfLikes: noOfLikes,
        updatedAt: updatedAt,
        createdAt: createdAt,
        noOfViews: noOfViews,
        location: location,
        shareDisabled: shareDisabled,
        reactionDisabled: reactionDisabled,
        commentDisabled: commentDisabled,
        status: status,
        hashTag: hashTag,
        shareURL: shareURL);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Post &&
        id == other.id &&
        user == other.user &&
        pincode == other.pincode &&
        content == other.content &&
        postType == other.postType &&
        postContentType == other.postContentType &&
        postCategory == other.postCategory &&
        panchayatSummiti == other.panchayatSummiti &&
        gramPanchayat == other.gramPanchayat &&
        municipality == other.municipality &&
        ward == other.ward &&
        imageURL == other.imageURL &&
        videoURL == other.videoURL &&
        DeepCollectionEquality().equals(comments, other.comments) &&
        DeepCollectionEquality().equals(reactions, other.reactions) &&
        noOfLikes == other.noOfLikes &&
        updatedAt == other.updatedAt &&
        createdAt == other.createdAt &&
        noOfViews == other.noOfViews &&
        location == other.location &&
        shareDisabled == other.shareDisabled &&
        reactionDisabled == other.reactionDisabled &&
        commentDisabled == other.commentDisabled &&
        status == other.status &&
        hashTag == other.hashTag &&
        shareURL == other.shareURL;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Post {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("pincode=" + "$pincode" + ", ");
    buffer.write("content=" + "$content" + ", ");
    buffer.write("postType=" +
        (postType != null ? enumToString(postType) : "null") +
        ", ");
    buffer.write("postContentType=" +
        (postContentType != null ? enumToString(postContentType) : "null") +
        ", ");
    buffer.write("postCategory=" +
        (postCategory != null ? enumToString(postCategory) : "null") +
        ", ");
    buffer.write("panchayatSummiti=" + "$panchayatSummiti" + ", ");
    buffer.write("gramPanchayat=" + "$gramPanchayat" + ", ");
    buffer.write("municipality=" + "$municipality" + ", ");
    buffer.write("ward=" + (ward != null ? ward.toString() : "null") + ", ");
    buffer.write("imageURL=" + "$imageURL" + ", ");
    buffer.write("videoURL=" + "$videoURL" + ", ");
    buffer.write("noOfLikes=" +
        (noOfLikes != null ? noOfLikes.toString() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (updatedAt != null ? updatedAt.format() : "null") +
        ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.format() : "null") +
        ", ");
    buffer.write("noOfViews=" +
        (noOfViews != null ? noOfViews.toString() : "null") +
        ", ");
    buffer.write(
        "location=" + (location != null ? location.toString() : "null") + ", ");
    buffer.write("shareDisabled=" +
        (shareDisabled != null ? shareDisabled.toString() : "null") +
        ", ");
    buffer.write("reactionDisabled=" +
        (reactionDisabled != null ? reactionDisabled.toString() : "null") +
        ", ");
    buffer.write("commentDisabled=" +
        (commentDisabled != null ? commentDisabled.toString() : "null") +
        ", ");
    buffer.write(
        "status=" + (status != null ? enumToString(status) : "null") + ", ");
    buffer.write("hashTag=" + "$hashTag" + ", ");
    buffer.write("shareURL=" + "$shareURL");
    buffer.write("}");

    return buffer.toString();
  }

  Post copyWith(
      {String id,
      User user,
      String pincode,
      String content,
      PostType postType,
      PostContentType postContentType,
      PostCategory postCategory,
      String panchayatSummiti,
      String gramPanchayat,
      String municipality,
      int ward,
      String imageURL,
      String videoURL,
      List<Comment> comments,
      List<Reactions> reactions,
      int noOfLikes,
      TemporalDateTime updatedAt,
      TemporalDateTime createdAt,
      int noOfViews,
      Location location,
      bool shareDisabled,
      bool reactionDisabled,
      bool commentDisabled,
      Status status,
      String hashTag,
      String shareURL}) {
    return Post(
        id: id ?? this.id,
        user: user ?? this.user,
        pincode: pincode ?? this.pincode,
        content: content ?? this.content,
        postType: postType ?? this.postType,
        postContentType: postContentType ?? this.postContentType,
        postCategory: postCategory ?? this.postCategory,
        panchayatSummiti: panchayatSummiti ?? this.panchayatSummiti,
        gramPanchayat: gramPanchayat ?? this.gramPanchayat,
        municipality: municipality ?? this.municipality,
        ward: ward ?? this.ward,
        imageURL: imageURL ?? this.imageURL,
        videoURL: videoURL ?? this.videoURL,
        comments: comments ?? this.comments,
        reactions: reactions ?? this.reactions,
        noOfLikes: noOfLikes ?? this.noOfLikes,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        noOfViews: noOfViews ?? this.noOfViews,
        location: location ?? this.location,
        shareDisabled: shareDisabled ?? this.shareDisabled,
        reactionDisabled: reactionDisabled ?? this.reactionDisabled,
        commentDisabled: commentDisabled ?? this.commentDisabled,
        status: status ?? this.status,
        hashTag: hashTag ?? this.hashTag,
        shareURL: shareURL ?? this.shareURL);
  }

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        pincode = json['pincode'],
        content = json['content'],
        postType = enumFromString<PostType>(json['postType'], PostType.values),
        postContentType = enumFromString<PostContentType>(
            json['postContentType'], PostContentType.values),
        postCategory = enumFromString<PostCategory>(
            json['postCategory'], PostCategory.values),
        panchayatSummiti = json['panchayatSummiti'],
        gramPanchayat = json['gramPanchayat'],
        municipality = json['municipality'],
        ward = json['ward'],
        imageURL = json['imageURL'],
        videoURL = json['videoURL'],
        comments = json['comments']['items'] is List
            ? (json['comments']['items'] as List)
                .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : <Comment>[],
        reactions = json['reactions'] is List
            ? (json['reactions'] as List)
                .map(
                    (e) => Reactions.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : <Reactions>[],
        noOfLikes = json['noOfLikes'],
        updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null,
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        noOfViews = json['noOfViews'],
        location = (json['location'] == null)
            ? null
            : Location.fromJson(json['location']),
        shareDisabled = json['shareDisabled'],
        reactionDisabled = json['reactionDisabled'],
        commentDisabled = json['commentDisabled'],
        status = enumFromString<Status>(json['status'], Status.values),
        hashTag = json['hashTag'],
        shareURL = json['shareURL'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'pincode': pincode,
        'content': content,
        'postType': enumToString(postType),
        'postContentType': enumToString(postContentType),
        'postCategory': enumToString(postCategory),
        'panchayatSummiti': panchayatSummiti,
        'gramPanchayat': gramPanchayat,
        'municipality': municipality,
        'ward': ward,
        'imageURL': imageURL,
        'videoURL': videoURL,
        'comments': comments?.map((e) => e?.toJson())?.toList(),
        'reactions': reactions?.map((e) => e?.toJson())?.toList(),
        'noOfLikes': noOfLikes,
        'updatedAt': updatedAt?.format(),
        'createdAt': createdAt?.format(),
        'noOfViews': noOfViews,
        'location': location,
        'shareDisabled': shareDisabled,
        'reactionDisabled': reactionDisabled,
        'commentDisabled': commentDisabled,
        'status': enumToString(status),
        'hashTag': hashTag,
        'shareURL': shareURL
      };

  static final QueryField ID = QueryField(fieldName: "post.id");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField PINCODE = QueryField(fieldName: "pincode");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField POSTTYPE = QueryField(fieldName: "postType");
  static final QueryField POSTCONTENTTYPE =
      QueryField(fieldName: "postContentType");
  static final QueryField POSTCATEGORY = QueryField(fieldName: "postCategory");
  static final QueryField PANCHAYATSUMMITI =
      QueryField(fieldName: "panchayatSummiti");
  static final QueryField GRAMPANCHAYAT =
      QueryField(fieldName: "gramPanchayat");
  static final QueryField MUNICIPALITY = QueryField(fieldName: "municipality");
  static final QueryField WARD = QueryField(fieldName: "ward");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageURL");
  static final QueryField VIDEOURL = QueryField(fieldName: "videoURL");
  static final QueryField COMMENTS = QueryField(
      fieldName: "comments",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Comment).toString()));
  static final QueryField REACTIONS = QueryField(
      fieldName: "reactions",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Reactions).toString()));
  static final QueryField NOOFLIKES = QueryField(fieldName: "noOfLikes");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField NOOFVIEWS = QueryField(fieldName: "noOfViews");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField SHAREDISABLED =
      QueryField(fieldName: "shareDisabled");
  static final QueryField REACTIONDISABLED =
      QueryField(fieldName: "reactionDisabled");
  static final QueryField COMMENTDISABLED =
      QueryField(fieldName: "commentDisabled");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField HASHTAG = QueryField(fieldName: "hashTag");
  static final QueryField SHAREURL = QueryField(fieldName: "shareURL");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Post";
    modelSchemaDefinition.pluralName = "Posts";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.READ,
        ModelOperation.CREATE,
        ModelOperation.UPDATE
      ]),
      AuthRule(
          authStrategy: AuthStrategy.PUBLIC,
          operations: [ModelOperation.READ, ModelOperation.CREATE])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Post.USER,
        isRequired: false,
        targetName: "userId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.PINCODE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.CONTENT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.POSTTYPE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.POSTCONTENTTYPE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.POSTCATEGORY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.PANCHAYATSUMMITI,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.GRAMPANCHAYAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.MUNICIPALITY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.WARD,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.IMAGEURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.VIDEOURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Post.COMMENTS,
        isRequired: false,
        ofModelName: (Comment).toString(),
        associatedKey: Comment.POSTID));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Post.REACTIONS,
        isRequired: false,
        ofModelName: (Reactions).toString(),
        associatedKey: Reactions.USER));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.NOOFLIKES,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.UPDATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.NOOFVIEWS,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.LOCATION,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.SHAREDISABLED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.REACTIONDISABLED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.COMMENTDISABLED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.STATUS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.HASHTAG,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.SHAREURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _PostModelType extends ModelType<Post> {
  const _PostModelType();

  @override
  Post fromJson(Map<String, dynamic> jsonData) {
    return Post.fromJson(jsonData);
  }
}
