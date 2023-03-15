// ignore_for_file: file_names, curly_braces_in_flow_control_structures, avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online_panchayat_flutter/firestoreModels/Profession.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/firestoreModels/Professional.dart';
import 'package:online_panchayat_flutter/screens/RegisterProfessionalScreen/registerProfessional.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:online_panchayat_flutter/services/radiusData.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';

import 'nearbyProfessionals.dart';

class IndividualProfessionalListScreenData extends ChangeNotifier
    with RadiusData {
  final Profession profession;
  List<Professional> professionals = <Professional>[];
  Location myLocation;
  bool loading = true;
  static LocationNotifier locationNotifier;
  static GlobalDataNotifier globalDataNotifier;
  // NumberFormat numberFormat = NumberFormat('#######0.##');
  String userId;

  IndividualProfessionalListScreenData({
    this.profession,
  }) {
    if (profession == null) return;
    myLocation = globalDataNotifier.localUser.homeAdressLocation;
    if (locationNotifier.currentLocation == null)
      askForCurrentLocation();
    else
      myLocation = locationNotifier.currentLocation;
    getProfessionalsList();
  }
  StreamSubscription<List<DocumentSnapshot<Map<String, dynamic>>>>
      streamSubscription;

  askForCurrentLocation() async {
    if (locationNotifier.currentLocation == null)
      await locationNotifier.getPosition();
    if (locationNotifier.currentLocation != null) {
      myLocation = locationNotifier.currentLocation;
      getProfessionalsList();
    }
  }

  @override
  performQuery() => getProfessionalsList();

  getProfessionalsList() async {
    loading = true;
    professionals.clear();
    notifyListeners();
    var professionalsStream = NearbyProfessionals.getNearbyProfessionals(
      myLocation: myLocation,
      profession: profession.id,
      radius: radius,
    );
    streamSubscription = professionalsStream.listen(onStreamDataReceive);
  }

  onStreamDataReceive(
      List<DocumentSnapshot<Map<String, dynamic>>> professionalSnapshotList) {
    streamSubscription?.cancel();
    professionals.clear();
    for (var professionalSnapshot in professionalSnapshotList) {
      var professionalJson = professionalSnapshot.data();
      professionalJson["docId"] = professionalSnapshot.id;

      var professional = Professional.fromJson(professionalJson);
      professionals.add(professional);
    }

    professionals.sort((a, b) {
      return (Geolocator.distanceBetween(myLocation.lat, myLocation.lon,
                  a.point.location.lat, a.point.location.lon) >
              Geolocator.distanceBetween(myLocation.lat, myLocation.lon,
                  b.point.location.lat, b.point.location.lon))
          ? 1
          : -1;
    });
    loading = false;
    notifyListeners();
  }

  removeProfessional(Professional professional) async {
    await RegisterProfessional.removeProfessional(professional);
    professionals.remove(professional);
    notifyListeners();
  }

  Future<void> updateProfessional(Professional professional) async {
    var doc = await FirebaseFirestore.instance
        .collection('professionals')
        .doc(professional.profession)
        .collection(professional.profession)
        .doc(professional.docId)
        .get();

    professionals[professionals.indexOf(professional)] =
        Professional.fromJson(doc.data());

    print(doc.data());

    notifyListeners();
  }
}
