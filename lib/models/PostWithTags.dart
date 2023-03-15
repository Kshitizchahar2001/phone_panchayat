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

import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/PostCategory.dart';

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the PostWithTags type in your schema. */
@immutable
class PostWithTags extends Model {
  static const classType = const _PostWithTagsModelType();
  final String id;
  final User user;
  final String content;
  final PostContentType postContentType;
  final PostCategory postCategory;
  final String imageURL;
  final List<String> imageUrlsList;
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
  final String notificationShareURL;
  final int ttl;
  final List<String> tag;
  final String feedId;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const PostWithTags._internal(
      {@required this.id,
      this.user,
      this.content,
      this.postContentType,
      this.postCategory,
      this.imageURL,
      this.imageUrlsList,
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
      this.shareURL,
      this.notificationShareURL,
      this.ttl,
      this.tag,
      this.feedId});

  factory PostWithTags(
      {String id,
      User user,
      String content,
      PostContentType postContentType,
      PostCategory postCategory,
      String imageURL,
      List<String> imageUrlsList,
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
      String shareURL,
      String notificationShareURL,
      int ttl,
      List<String> tag,
      String feedId}) {
    return PostWithTags._internal(
        id: id == null ? UUID.getUUID() : id,
        user: user,
        content: content,
        postContentType: postContentType,
        postCategory: postCategory,
        imageURL: imageURL,
        imageUrlsList: imageUrlsList != null
            ? List<String>.unmodifiable(imageUrlsList)
            : imageUrlsList,
        videoURL: videoURL,
        comments:
            comments != null ? List<Comment>.unmodifiable(comments) : comments,
        reactions: reactions != null
            ? List<Reactions>.unmodifiable(reactions)
            : reactions,
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
        shareURL: shareURL,
        notificationShareURL: notificationShareURL,
        ttl: ttl,
        tag: tag != null ? List<String>.unmodifiable(tag) : tag,
        feedId: feedId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostWithTags &&
        id == other.id &&
        user == other.user &&
        content == other.content &&
        postContentType == other.postContentType &&
        postCategory == other.postCategory &&
        imageURL == other.imageURL &&
        DeepCollectionEquality().equals(imageUrlsList, other.imageUrlsList) &&
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
        shareURL == other.shareURL &&
        notificationShareURL == other.notificationShareURL &&
        ttl == other.ttl &&
        DeepCollectionEquality().equals(tag, other.tag) &&
        feedId == other.feedId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("PostWithTags {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("content=" + "$content" + ", ");
    buffer.write("postContentType=" +
        (postContentType != null ? enumToString(postContentType) : "null") +
        ", ");
    buffer.write("postCategory=" +
        (postCategory != null ? enumToString(postCategory) : "null") +
        ", ");
    buffer.write("imageURL=" + "$imageURL" + ", ");
    buffer.write("imageUrlsList=" +
        (imageUrlsList != null ? imageUrlsList.toString() : "null") +
        ", ");
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
    buffer.write("shareURL=" + "$shareURL" + ", ");
    buffer.write("notificationShareURL=" + "$notificationShareURL" + ", ");
    buffer.write("ttl=" + (ttl != null ? ttl.toString() : "null") + ", ");
    buffer.write("tag=" + (tag != null ? tag.toString() : "null") + ", ");
    buffer.write("feedId=" + "$feedId");
    buffer.write("}");

    return buffer.toString();
  }

  PostWithTags copyWith(
      {String id,
      User user,
      String content,
      PostContentType postContentType,
      PostCategory postCategory,
      String imageURL,
      List<String> imageUrlsList,
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
      String shareURL,
      String notificationShareURL,
      int ttl,
      List<String> tag,
      String feedId}) {
    return PostWithTags(
        id: id ?? this.id,
        user: user ?? this.user,
        content: content ?? this.content,
        postContentType: postContentType ?? this.postContentType,
        postCategory: postCategory ?? this.postCategory,
        imageURL: imageURL ?? this.imageURL,
        imageUrlsList: imageUrlsList ?? this.imageUrlsList,
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
        shareURL: shareURL ?? this.shareURL,
        notificationShareURL: notificationShareURL ?? this.notificationShareURL,
        ttl: ttl ?? this.ttl,
        tag: tag ?? this.tag,
        feedId: feedId ?? this.feedId);
  }

  PostWithTags.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        content = json['content'],
        postContentType = enumFromString<PostContentType>(
            json['postContentType'], PostContentType.values),
        postCategory = enumFromString<PostCategory>(
            json['postCategory'], PostCategory.values),
        imageURL = json['imageURL'],
        imageUrlsList = json['imageUrlsList']?.cast<String>(),
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
            : null,
        noOfLikes = (json['noOfLikes'] as num)?.toInt(),
        updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null,
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        noOfViews = (json['noOfViews'] as num)?.toInt(),
        location = (json['location'] == null)
            ? null
            : Location.fromJson(json['location']),
        shareDisabled = json['shareDisabled'],
        reactionDisabled = json['reactionDisabled'],
        commentDisabled = json['commentDisabled'],
        status = enumFromString<Status>(json['status'], Status.values),
        hashTag = json['hashTag'],
        shareURL = json['shareURL'],
        notificationShareURL = json['notificationShareURL'],
        ttl = (json['ttl'] as num)?.toInt(),
        tag = json['tag']?.cast<String>(),
        feedId = json['feedId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'content': content,
        'postContentType': enumToString(postContentType),
        'postCategory': enumToString(postCategory),
        'imageURL': imageURL,
        'imageUrlsList': imageUrlsList,
        'videoURL': videoURL,
        'comments': comments?.map((Comment e) => e?.toJson())?.toList(),
        'reactions': reactions?.map((Reactions e) => e?.toJson())?.toList(),
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
        'shareURL': shareURL,
        'notificationShareURL': notificationShareURL,
        'ttl': ttl,
        'tag': tag,
        'feedId': feedId
      };

  static final QueryField ID = QueryField(fieldName: "postWithTags.id");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField POSTCONTENTTYPE =
      QueryField(fieldName: "postContentType");
  static final QueryField POSTCATEGORY = QueryField(fieldName: "postCategory");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageURL");
  static final QueryField IMAGEURLSLIST =
      QueryField(fieldName: "imageUrlsList");
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
  static final QueryField NOTIFICATIONSHAREURL =
      QueryField(fieldName: "notificationShareURL");
  static final QueryField TTL = QueryField(fieldName: "ttl");
  static final QueryField TAG = QueryField(fieldName: "tag");
  static final QueryField FEEDID = QueryField(fieldName: "feedId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "PostWithTags";
    modelSchemaDefinition.pluralName = "PostWithTags";

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
        key: PostWithTags.USER,
        isRequired: false,
        targetName: "userId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.CONTENT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.POSTCONTENTTYPE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.POSTCATEGORY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.IMAGEURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.IMAGEURLSLIST,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.VIDEOURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: PostWithTags.COMMENTS,
        isRequired: false,
        ofModelName: (Comment).toString(),
        associatedKey: Comment.POSTID));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: PostWithTags.REACTIONS,
        isRequired: false,
        ofModelName: (Reactions).toString(),
        associatedKey: Reactions.USER));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.NOOFLIKES,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.UPDATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.NOOFVIEWS,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.LOCATION,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.SHAREDISABLED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.REACTIONDISABLED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.COMMENTDISABLED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.STATUS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.HASHTAG,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.SHAREURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.NOTIFICATIONSHAREURL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.TTL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.TAG,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PostWithTags.FEEDID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _PostWithTagsModelType extends ModelType<PostWithTags> {
  const _PostWithTagsModelType();

  @override
  PostWithTags fromJson(Map<String, dynamic> jsonData) {
    return PostWithTags.fromJson(jsonData);
  }
}
