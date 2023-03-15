// ignore_for_file: file_names

import 'package:online_panchayat_flutter/services/firestoreServices/getBuses.dart';
import 'package:online_panchayat_flutter/services/firestoreServices/getJobs.dart';
import 'package:online_panchayat_flutter/services/firestoreServices/getTrains.dart';

class FirestoreService {
  GetTrains getTrains;
  GetBuses getBuses;
  GetJobs getJobs;

  FirestoreService() {
    getTrains = GetTrains();
    getBuses = GetBuses();
    getJobs = GetJobs();
  }
}
