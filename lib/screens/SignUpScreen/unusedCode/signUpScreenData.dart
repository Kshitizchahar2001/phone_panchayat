// ignore_for_file: file_names
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/material.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:online_panchayat_flutter/constants/constants.dart';
// import 'package:online_panchayat_flutter/firestoreModels/Panchayat.dart';
// import 'package:online_panchayat_flutter/models/Location.dart';
// import 'package:online_panchayat_flutter/services/StoreGlobalData.dart';
// import 'package:online_panchayat_flutter/services/analyticsService.dart';
// import 'package:online_panchayat_flutter/services/radiusData.dart';
// import 'package:online_panchayat_flutter/services/services.dart';

// class SignUpScreenData extends ChangeNotifier with RadiusData {
//   bool loading = true;
//   List<Panchayat> panchayatList = <Panchayat>[];
//   StreamSubscription streamSubscription;
//   Location myLocation;
//   static final _firestore = FirebaseFirestore.instance;
//   static final _geo = Geoflutterfire();
//   int selectedIndex;
//   bool defaultPanchayatSelected = true;

//   SignUpScreenData() {
//     selectedIndex = 0;
//     radius = 200;
//   }

//   void onIndexChange(int newIndex) {
//     defaultPanchayatSelected = false;
//     selectedIndex = newIndex;
//     notifyListeners();
//   }

//   Future<void> completeSignUp() async {
//     Panchayat panchayat;
//     String deviceToken;
//     String referrerId = getReferrerId();
//     deviceToken = Services.firebaseMessagingService.getUpToDateDeviceToken;

//     panchayat = panchayatList[selectedIndex];

//     await Services.gqlMutationService.createNewUser
//         .createNewUser(
//       homeAdressLocation: Services.locationNotifier.location,
//       mobileNumber: Services.authenticationService.getCurrentUser().username,
//       area: panchayat.panchayatName,
//       pincode: panchayat.pincode,
//       deviceToken: deviceToken,
//       referrerId: referrerId,
//     )
//         .then((value) {
//       if (referrerId != null) {
//         try {
//           AnalyticsService.firebaseAnalytics
//               .logEvent(name: "user_creation_with_referral_id", parameters: {
//             "referrer_id": referrerId,
//             "user_id": Services.authenticationService.getCurrentUser().username,
//           });
//         } catch (e) {}
//         InteractWithSharePreference.setFirstUseTime();
//       }

//       Services.authStatusNotifier.rebuildRoot();
//     });
//   }

//   String getReferrerId() {
//     if (StoreGlobalData.refereeId != null) {
//       return "+" + StoreGlobalData.refereeId;
//     }
//     return null;
//   }

//   Future<bool> askForCurrentLocation() async {
//     if (Services.locationNotifier.location == null)
//       await Services.locationNotifier.getPosition();

//     //
//     if (Services.locationNotifier.location == null) {
//       await Services.locationNotifier.useTemporarilyHardcodedLocation();
//     } else {
//       AnalyticsService.firebaseAnalytics
//           .logEvent(name: "location_enabled_for_signup");
//     }
//     return true;
//   }

//   @override
//   performQuery() => getPanchayatList();

//   void getPanchayatList() async {
//     myLocation = Services.locationNotifier.location;
//     loading = true;
//     panchayatList.clear();
//     notifyListeners();
//     var panchayatStream = getNearbyPanchayatStream(
//       myLocation: myLocation,
//       radius: radius,
//     );
//     streamSubscription = panchayatStream.listen(onStreamDataReceive);
//   }

//   onStreamDataReceive(panchayatSnapshotList) {
//     streamSubscription?.cancel();
//     panchayatList.clear();
//     for (var panchayatSnapshot in panchayatSnapshotList) {
//       var panchayatJson = panchayatSnapshot.data();

//       var panchayat = Panchayat.fromJson(panchayatJson);
//       panchayatList.add(panchayat);
//     }

//     panchayatList.sort((a, b) {
//       return (Geolocator.distanceBetween(myLocation.lat, myLocation.lon,
//                   a.point.location.lat, a.point.location.lon) >
//               Geolocator.distanceBetween(myLocation.lat, myLocation.lon,
//                   b.point.location.lat, b.point.location.lon))
//           ? 1
//           : -1;
//     });
//     loading = false;
//     if (panchayatList.length == 0) {
//       try {
//         int indexOfCurrentRadius = kilometerRange.indexOf(radius.toInt());
//         int newIndex = indexOfCurrentRadius + 1;
//         if (newIndex >= kilometerRange.length) {
//           addTemporarilyHardcodedPanchayat();
//           notifyListeners();
//           completeSignUp();
//           return;
//         }
//         radius = kilometerRange[newIndex].toDouble();
//         performQuery();
//         return;
//       } catch (e, s) {
//         FirebaseCrashlytics.instance.recordError(e, s);
//         notifyListeners();
//         return;
//       }
//     }
//     notifyListeners();
//   }

//   addTemporarilyHardcodedPanchayat() {
//     panchayatList.add(temporarilyHardcodedPanchayat);
//   }

//   Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getNearbyPanchayatStream(
//       {double radius, Location myLocation}) {
//     String field = "point";
//     final center =
//         _geo.point(latitude: myLocation.lat, longitude: myLocation.lon);
//     final collectionReference = _firestore.collection('panchayat');
//     final stream = _geo.collection(collectionRef: collectionReference).within(
//           center: center,
//           radius: radius,
//           field: field,
//           strictMode: true,
//         );

//     return stream;
//   }
// }
