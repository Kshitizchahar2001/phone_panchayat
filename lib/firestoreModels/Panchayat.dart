// ignore_for_file: file_names, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:online_panchayat_flutter/models/Location.dart';

import 'point.dart';

class Panchayat {
  Panchayat({
    this.panchayatName,
    this.pincode,
    this.point,
    this.imageURL,
  });

  String panchayatName;
  String pincode;
  Point point;
  String imageURL;

  factory Panchayat.fromJson(Map<String, dynamic> json) => Panchayat(
        panchayatName: json["panchayatName"],
        pincode: json["pincode"],
        point: getCustomPointFromJson(json["point"]["geopoint"]),
        imageURL: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "panchayatName": panchayatName,
        "pincode": pincode,
        "point": getCustomPointToJson(),
        "imageURL": imageURL,
      };

  getCustomPointToJson() {
    final geo = Geoflutterfire();

    try {
      GeoFirePoint myLocation = geo.point(
        latitude: this.point.location.lat,
        longitude: this.point.location.lon,
      );

      return myLocation.data;
    } catch (e) {
      return null;
    }
  }

  static getCustomPointFromJson(GeoPoint geoPoint) {
    try {
      return Point(
        location: Location(
          lat: geoPoint.latitude,
          lon: geoPoint.longitude,
        ),
      );
    } catch (e) {
      return null;
    }
  }
}
