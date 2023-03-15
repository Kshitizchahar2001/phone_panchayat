// To parse this JSON data, do
//
//     final guestUser = guestUserFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

class GuestUser {
  GuestUser({
    this.tag,
    this.area,
    this.districtId,
    this.stateId,
    this.stateNameHi,
    this.stateNameEn,
  });

  String tag;
  String area;
  String districtId;
  String stateId;
  String stateNameHi;
  String stateNameEn;

  factory GuestUser.fromRawJson(String str) =>
      GuestUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GuestUser.fromJson(Map<String, dynamic> json) => GuestUser(
        tag: json["tag"],
        area: json["area"],
        districtId: json["districtId"],
        stateId: json["stateId"],
        stateNameHi: json["stateNameHi"],
        stateNameEn: json["stateNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "area": area,
        "districtId": districtId,
        "stateId": stateId,
        "stateNameHi": stateNameHi,
        "stateNameEn": stateNameEn,
      };
}
