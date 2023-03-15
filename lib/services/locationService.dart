// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print, avoid_returning_null_for_void, unnecessary_this

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';

import 'package:geolocator/geolocator.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/Location.dart';

const Map hardcodedPincodeReplacements = {
  '322001': '322201',
};

class LocationNotifier extends ChangeNotifier {
  Location currentLocation; //current location of user
  Location location; //home address location
  String pinCode;
  String area;
  String errorMessage;
  bool isLoading = false;
  var address;
  // = "Select Address";
  // LocationNotifier() {
  //   getPosition();
  // }

  Future<void> getPosition() async {
    Position position;
    isLoading = true;
    position = await _determinePosition().catchError((e, s) {
      errorMessage = e.toString();
      isLoading = false;
      print("Error caught is : $errorMessage");
      FirebaseCrashlytics.instance.recordError(e, s);
    });
    if (position == null) return null;

    location = Location(lat: position.latitude, lon: position.longitude);
    currentLocation = Location(lat: position.latitude, lon: position.longitude);

    await findAddressFromCoordinates(position.latitude, position.longitude)
        .then((value) => {
              pinCode =
                  alterPincodeWithHardcodedReplacements(value.first.postalCode),
              area = value.first.locality,
              print(" locality is $area"),
              address = value.first,
            })
        .catchError((e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> useTemporarilyHardcodedLocation() async {
    await setLocationAndAddress(temporarilyHardcodedlocation);
  }

  Future<void> setLocationAndAddress(Location _location) async {
    location = _location;
    // currentLocation = _location;
    isLoading = true;

    try {
      await findAddressFromCoordinates(location.lat, location.lon)
          .then((value) => {
                pinCode = alterPincodeWithHardcodedReplacements(
                    value.first.postalCode),
                area = value.first.locality,
                address = value.first,
              })
          .catchError((e, s) {
        FirebaseCrashlytics.instance.recordError(e, s);
      });
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError("Error while fetching address form location : " + e, s);
    }
    isLoading = false;
    notifyListeners();
  }

  set setAddress(address) {
    this.address = address;
    this.area = address.locality;
    this.pinCode = alterPincodeWithHardcodedReplacements(address.postalCode);
    notifyListeners();
  }

  set setLocation(Location location) {
    this.location = location;
  }

  alterPincodeWithHardcodedReplacements(String pincode) {
    // if (hardcodedPincodeReplacements[pincode] == null)
    return pincode;
    // else
    //   return hardcodedPincodeReplacements[pincode];
  // ignore: todo
  } // TODO: uncomment as per requirement

  findAddressFromCoordinates(double latitude, double longitude) async {
    return await Geocoder2.getDataFromCoordinates(
        latitude: latitude, longitude: longitude, googleMapApiKey: "");
  }

  Future<Position> _determinePosition() async {
    // bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Location services are not enabled don't continue
    //   // accessing the position and request users of the
    //   // App to enable the location services.
    //   // return Position();
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
