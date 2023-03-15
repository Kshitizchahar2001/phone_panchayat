// To parse this JSON data, do
//
//     final postTag = postTagFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PostTag postTagFromJson(String str) => PostTag.fromJson(json.decode(str));

String postTagToJson(PostTag data) => json.encode(data.toJson());

class PostTag {
  PostTag({
    this.en,
    this.hi,
    this.pincode,
    this.imageUrl,
  });

  String en;
  String hi;
  String pincode;
  String imageUrl;

  factory PostTag.fromJson(Map<String, dynamic> json) => PostTag(
        en: json["en"],
        hi: json["hi"],
        pincode: json["pincode"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "hi": hi,
        "pincode": pincode,
        "imageURL": imageUrl,
      };
}
