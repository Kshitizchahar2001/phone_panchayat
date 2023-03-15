// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:online_panchayat_flutter/firestoreModels/point.dart';
import 'package:online_panchayat_flutter/models/Location.dart';

class GetCustomPoint {
  static getCustomPointToJson(double latitude, double longitude) {
    final geo = Geoflutterfire();

    GeoFirePoint myLocation = geo.point(
      latitude: latitude,
      longitude: longitude,
    );

    return myLocation.data;
  }

  static Point getCustomPointFromJson(GeoPoint geoPoint) {
    return Point(
      location: Location(
        lat: geoPoint?.latitude,
        lon: geoPoint?.longitude,
      ),
    );
  }
}
