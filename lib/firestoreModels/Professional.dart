// ignore_for_file: file_names, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:online_panchayat_flutter/models/Location.dart';

import 'point.dart';

class Professional {
  Professional({
    @required this.name,
    @required this.profession,
    @required this.contactNo,
    @required this.point,
    @required this.imageUrl,
    @required this.descripton,
    @required this.docId,
    @required this.totalStars,
    @required this.totalReviews,
  });

  String name;
  String profession;
  int contactNo;
  Point point;
  String imageUrl;
  String descripton;
  String docId;
  int totalStars;
  int totalReviews;

  factory Professional.fromJson(Map<String, dynamic> json) => Professional(
        name: json["name"],
        profession: json["profession"],
        contactNo: json["contact no"],
        imageUrl: json["imageUrl"],
        point: getCustomPointFromJson(json["point"]["geopoint"]),
        descripton: json["description"],
        docId: json["docId"],
        totalStars: json["totalStars"] ?? 0,
        totalReviews: json["totalReviews"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profession": profession,
        "contact no": contactNo,
        "imageUrl": imageUrl,
        "point": getCustomPointToJson(),
        "description": descripton,
        "docId": docId,
        "totalStars": totalStars,
        "totalReviews": totalReviews,
      };

  getCustomPointToJson() {
    final geo = Geoflutterfire();

    GeoFirePoint myLocation = geo.point(
      latitude: this.point.location.lat,
      longitude: this.point.location.lon,
    );

    return myLocation.data;
  }

  static getCustomPointFromJson(GeoPoint geoPoint) {
    return Point(
      location: Location(
        lat: geoPoint.latitude,
        lon: geoPoint.longitude,
      ),
    );
  }
}
