// ignore_for_file: file_names

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_panchayat_flutter/firestoreModels/job.dart';
import 'package:online_panchayat_flutter/services/firestoreServices/storeFirestoreData.dart';

class GetJobs {
  Future<List<Job>> getJobs({String city = "gangapur"}) async {
    QuerySnapshot jobsDocumentList = await FirebaseFirestore.instance
        .collection("cities")
        .doc(city)
        .collection("jobs")
        .get();

    List jobs = jobsDocumentList.docs
        .map((document) => Job.fromMap(document.data()))
        .toList();
    if (jobs != null) {
      StoreFirestoreData.jobs = jobs;
      return jobs;
    }
    FirebaseCrashlytics.instance
        .log("Firestore jobs collection has no documents");

    StoreFirestoreData.jobs = <Job>[];
    return <Job>[];
  }
}
