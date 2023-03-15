// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:online_panchayat_flutter/models/Location.dart';

class NearbyProfessionals {
  static final _firestore = FirebaseFirestore.instance;
  static final _geo = Geoflutterfire();

  static Stream<List<DocumentSnapshot<Map<String, dynamic>>>>
      getNearbyProfessionals(
          {String profession, double radius, Location myLocation}) {
    String field = "point";
    // 'locationWithGeoHash.geoHash'
    print('Searching for $profession');
    final center =
        _geo.point(latitude: myLocation.lat, longitude: myLocation.lon);
    final collectionReference = _firestore
        .collection('professionals')
        .doc(profession)
        .collection(profession);
    // .where('profession', isEqualTo: profession);
    final stream = _geo.collection(collectionRef: collectionReference).within(
          center: center,
          radius: radius,
          field: field,
          strictMode: true,
        );

    return stream;
  }
}
