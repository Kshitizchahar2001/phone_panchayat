// To parse this JSON data, do
//
//     final referredUserData = referredUserDataFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ReferredUserData referredUserDataFromJson(String str) =>
    ReferredUserData.fromJson(json.decode(str));

String referredUserDataToJson(ReferredUserData data) =>
    json.encode(data.toJson());

class ReferredUserData {
  ReferredUserData({
    this.number,
    this.name,
    this.imageUrl,
  });

  String number;
  String name;
  String imageUrl;

  factory ReferredUserData.fromJson(Map<String, dynamic> json) =>
      ReferredUserData(
        number: json["number"],
        name: json["name"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "imageURL": imageUrl,
      };
}
