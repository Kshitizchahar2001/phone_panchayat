// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromMap(jsonString);

// ignore_for_file: file_names, prefer_if_null_operators

import 'dart:convert';

NotificationModel notificationModelFromMap(String str) => NotificationModel.fromMap(json.decode(str));

String notificationModelToMap(NotificationModel data) => json.encode(data.toMap());

class NotificationModel {
    NotificationModel({
        this.eventType,
        this.userName,
        this.userImage,
        this.userId,
        this.postId,
        this.postContent,
        this.commentText,
        this.reactionType,
        this.readStatus,
    });

    String eventType;
    String userName;
    String userImage;
    String userId;
    String postId;
    String postContent;
    String commentText;
    String reactionType;
    int readStatus;

    factory NotificationModel.fromMap(Map<String, dynamic> json) => NotificationModel(
        eventType: json["eventType"] == null ? null : json["eventType"],
        userName: json["userName"] == null ? null : json["userName"],
        userImage: json["userImage"] == null ? null : json["userImage"],
        userId: json["userId"] == null ? null : json["userId"],
        postId: json["postId"] == null ? null : json["postId"],
        postContent: json["postContent"] == null ? null : json["postContent"],
        commentText: json["commentText"] == null ? null : json["commentText"],
        reactionType: json["reactionType"] == null ? null : json["reactionType"],
        readStatus: json["readStatus"] == null ? null : json["readStatus"],
    );

    Map<String, dynamic> toMap() => {
        "eventType": eventType == null ? null : eventType,
        "userName": userName == null ? null : userName,
        "userImage": userImage == null ? null : userImage,
        "userId": userId == null ? null : userId,
        "postId": postId == null ? null : postId,
        "postContent": postContent == null ? null : postContent,
        "commentText": commentText == null ? null : commentText,
        "reactionType": reactionType == null ? null : reactionType,
        "readStatus": readStatus == null ? null : readStatus,
    };
}
