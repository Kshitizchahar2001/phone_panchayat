// ignore_for_file: file_names

import 'dart:convert';

Sibling siblingFromJson(String str) => Sibling.fromJson(json.decode(str));

String siblingToJson(Sibling data) => json.encode(data.toJson());

class Sibling {
  Sibling({
    this.total,
    this.married,
  });

  int total;
  int married;

  factory Sibling.fromJson(Map<String, dynamic> json) => Sibling(
        total: json["total"].toInt(),
        married: json["married"].toInt(),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "married": married,
      };
}
