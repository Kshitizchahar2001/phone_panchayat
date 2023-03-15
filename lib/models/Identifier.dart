// To parse this JSON data, do
//
//     final identifier = identifierFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:online_panchayat_flutter/enum/identifierType.dart';

Identifier identifierFromJson(String str) =>
    Identifier.fromJson(json.decode(str));

String identifierToJson(Identifier data) => json.encode(data.toJson());

class Identifier {
  Identifier({
    this.name,
    this.pincode,
    this.identifierType,
    this.id,
  });

  String name;
  String pincode;
  IdentifierType identifierType;
  String id;

  factory Identifier.fromJson(Map<String, dynamic> json) => Identifier(
        name: json["name"],
        pincode: json["pincode"],
        identifierType:
            enumFromString<IdentifierType>(json['type'], IdentifierType.values),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "pincode": pincode,
        "type": identifierType,
        "id": id,
      };
}
