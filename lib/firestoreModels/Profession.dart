// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Profession {
  Profession({
    @required this.id,
    @required this.en,
    @required this.hi,
  });

  final String id;
  final String en;
  final String hi;

  factory Profession.fromJson(Map<String, dynamic> json) => Profession(
        id: json["id"],
        en: json["en"] ?? json["hi"] ?? json["id"],
        hi: json["hi"] ?? json["en"] ?? json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "en": en,
        "hi": hi,
      };
}
