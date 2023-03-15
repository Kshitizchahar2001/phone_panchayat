// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    this.name,
    this.id,
    this.nameHi,
    this.image,
  });

  String name;
  String id;
  String nameHi;
  String image;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        name: json["name"],
        id: json["id"],
        nameHi: json["name_hi"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "name_hi": nameHi,
        "image": image,
      };
}
