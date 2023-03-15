// ignore_for_file: file_names

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/firestoreModels/train.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_panchayat_flutter/services/firestoreServices/storeFirestoreData.dart';

class GetTrains {
  Future<List<Train>> getTrains({String city = "gangapur"}) async {
    QuerySnapshot trainsDocumentList = await FirebaseFirestore.instance
        .collection("cities")
        .doc(city)
        .collection("trains")
        .get();

    List trains = trainsDocumentList.docs
        .map((document) => Train.fromMap(document.data()))
        .toList();
    if (trains != null) {
      StoreFirestoreData.trains = trains;
      return trains;
    }
    StoreFirestoreData.trains = <Train>[];
    FirebaseCrashlytics.instance.log("Trains collection is empty");

    return <Train>[];
  }
}
