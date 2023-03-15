// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';

import 'package:online_panchayat_flutter/services/gqlQueryServices/getProfessionalList.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:online_panchayat_flutter/services/radiusData.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';

import 'package:flutter_geo_hash/geohash.dart';

class ProfessionalListData extends ChangeNotifier with RadiusData {
  final Map service;
  List<Professional> professionals = <Professional>[];
  Location myLocation;
  bool loading = true;
  bool locationPermissonDenied = false;
  static LocationNotifier locationNotifier;
  static GlobalDataNotifier globalDataNotifier;
  String userId;

  ProfessionalListData({this.service}) {
    if (service == null) return;
    myLocation = Services.globalDataNotifier.localUser.homeAdressLocation;
    if (Services.locationNotifier.currentLocation == null)
      askForCurrentLocation();
    else {
      myLocation = Services.locationNotifier.currentLocation;
      getProfessionalsList();
    }
  }

  askForCurrentLocation() async {
    if (Services.locationNotifier.currentLocation == null)
      await Services.locationNotifier.getPosition();

    /// If user disables location permisson then we set a new variable
    /// locationPermsissonDenied to true
    if (Services.locationNotifier.currentLocation == null) {
      locationPermissonDenied = true;
      loading = false;
      notifyListeners();
    }

    if (Services.locationNotifier.currentLocation != null) {
      myLocation = Services.locationNotifier.currentLocation;
      getProfessionalsList();
    }
  }

  @override
  performQuery() => getProfessionalsList();

  getProfessionalsList() async {
    locationPermissonDenied = false;
    loading = true;
    professionals.clear();
    notifyListeners();

    /// Getting geoHash for a current given location and radius
    List<List<String>> geoHashBounds = getGeoHashBoundFromLatLong(
        lat: myLocation.lat, lon: myLocation.lon, radius: radius * 1000);

    await Future.wait(geoHashBounds.map((bound) {
      print("Getting data for geoHashBound : $bound ");
      return getProfessionalsFilteredByDistance(
              workSpecialityId: service["id"], geoHashBound: bound)
          .catchError((Object obj, StackTrace st) {
        FirebaseCrashlytics.instance.recordError(
          "error in getProfessionalsFilteredByDistance function while getting professionals by work speicality and geoHashBound" +
              obj.toString(),
          st,
        );
      });
    }).toList());
    loading = false;
    notifyListeners();
  }

  Future<void> getProfessionalsFilteredByDistance(
      {@required String workSpecialityId,
      @required List<String> geoHashBound}) async {
    List<Professional> professionalsInRadius = await GetProfessionals()
        .getProfessionalsByWork(
            workSpecialityId: workSpecialityId, geoHashBound: geoHashBound);
    List<Professional> filteredProfessionals = [];
    for (Professional professional in professionalsInRadius) {
      double distanceInKms = Geolocator.distanceBetween(
              myLocation.lat,
              myLocation.lon,
              professional.shopLocation.lat,
              professional.shopLocation.lon) /
          1000;
      if (distanceInKms <= radius) filteredProfessionals.add(professional);
    }
    professionals.addAll(filteredProfessionals);
  }

  /// Getting geo hashes from given lat long and radius
  List<List<String>> getGeoHashBoundFromLatLong(
      {double lat, double lon, double radius}) {
    MyGeoHash fluttergeo = MyGeoHash();
    List<List<String>> bounds =
        fluttergeo.geohashQueryBounds(GeoPoint(lat, lon), radius);
    return bounds;
  }
}
