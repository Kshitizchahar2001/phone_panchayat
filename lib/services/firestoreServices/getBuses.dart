// ignore_for_file: file_names

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/firestoreModels/bus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_panchayat_flutter/services/firestoreServices/storeFirestoreData.dart';

class GetBuses {
  Future<List<Bus>> getBuses({String city = "gangapur"}) async {
    QuerySnapshot busesDocumentList = await FirebaseFirestore.instance
        .collection("cities")
        .doc(city)
        .collection("buses")
        .get();

    List buses = busesDocumentList.docs
        .map((document) => Bus.fromMap(document.data()))
        .toList();
    if (buses != null) {
      StoreFirestoreData.buses = buses;
      return buses;
    }
    StoreFirestoreData.buses = <Bus>[];
    FirebaseCrashlytics.instance.log("Buses collection is empty");

    return <Bus>[];
  }
}
