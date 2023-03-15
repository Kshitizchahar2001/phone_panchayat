import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Location.dart';

class Point {
  Point({
    this.geoHash,
    @required this.location,
  });

  String geoHash;
  Location location;

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        geoHash: json["geoHash"],
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "geoHash": geoHash,
        "location": location.toJson(),
      };
}
