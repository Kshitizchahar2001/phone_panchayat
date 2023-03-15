// ignore_for_file: use_key_in_widget_constructors, curly_braces_in_flow_control_structures, prefer_const_constructors, prefer_const_constructors_in_immutables, missing_required_param, prefer_if_null_operators, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';
import 'package:address_finder/address_finder.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class AdressScreenOrGettingLocation extends StatefulWidget {
  @override
  _AdressScreenOrGettingLocationState createState() =>
      _AdressScreenOrGettingLocationState();
}

class _AdressScreenOrGettingLocationState
    extends State<AdressScreenOrGettingLocation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationNotifier>(
      builder: (context, value, child) {
        if (!value.isLoading && value.location != null)
          return AddressScreen(locationNotifierInstance: value);
        else
          return GettingLocation();
      },
    );
  }
}

class GettingLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // the code here will be executed after rebuild
      retry(context);
    });

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  void retry(BuildContext context) async {
    await Provider.of<LocationNotifier>(context, listen: false).getPosition();
    if (Provider.of<LocationNotifier>(context, listen: false).location ==
        null) {
      await Provider.of<LocationNotifier>(context, listen: false)
          .useTemporarilyHardcodedLocation();
      // context.vxNav.pop();
    }
  }
}

class AddressScreen extends StatefulWidget {
  // final Position positon;
  final LocationNotifier locationNotifierInstance;
  AddressScreen({this.locationNotifierInstance});

  static const id = 'AddressScreen';
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  Completer<GoogleMapController> mapController = Completer();
  AddressModel selectedAddress;
  LatLng latlong = LatLng(25.3000, 80.2990);
  Marker marker;
  LatLng pointer;
  CameraPosition initialCamera;
  FocusNode focusNode = FocusNode();

  Future<void> handelMapOnTap(LatLng tappedLocationLatLng) async {
    pointer = tappedLocationLatLng;
    selectedAddress = AddressModel(
        address: await Geocoder2.getDataFromCoordinates(
      latitude: tappedLocationLatLng.latitude,
      longitude: tappedLocationLatLng.longitude,
    ).then((value) => value.address));

    GoogleMapController controller = await mapController.future;
    await controller
        .animateCamera(CameraUpdate.newLatLngZoom(tappedLocationLatLng, 18));
    setState(() {
      focusNode.unfocus();
      marker =
          Marker(markerId: MarkerId('pointer'), position: tappedLocationLatLng);
    });
  }

  @override
  void initState() {
    initialCamera = CameraPosition(
      target: LatLng(widget.locationNotifierInstance.location.lat,
          widget.locationNotifierInstance.location.lon),
      zoom: 18.0000,
    );
    pointer = initialCamera.target;

    marker =
        Marker(markerId: MarkerId('pointer'), position: initialCamera.target);

    selectedAddress = AddressModel(
        latitude: widget.locationNotifierInstance.location.lat,
        longitude: widget.locationNotifierInstance.location.lon,
        address: widget.locationNotifierInstance.address);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: marker != null ? {marker} : null,
              onTap: handelMapOnTap,
              mapType: MapType.normal,
              initialCameraPosition: initialCamera,
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.safePercentWidth * 2,
                  vertical: context.safePercentHeight * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(),
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: SearchMapPlaceWidget(
                      focusNode: focusNode,
                      iconColor: maroonColor,
                      strictBounds: true,
                      location: pointer == null
                          ? LatLng(18.516726, 73.856255)
                          : pointer,
                      radius: pointer == null ? 300000 : 300000,
                      apiKey: kGoogleApiKey,
                      onSelected: (place) async {
                        try {
                          final geolocation = await place.geolocation;
                          latlong = geolocation.coordinates;
                          await handelMapOnTap(latlong);
                        } catch (e, s) {
                          FirebaseCrashlytics.instance.recordError(e, s);
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        pointer != null
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: KThemeDarkGrey, width: 2),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      // ignore: todo
                                      Radius.circular(10), //TODO change radius
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x0D000000),
                                          blurRadius: 11)
                                    ]),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (selectedAddress.address != null)
                                        ? selectedAddress.address.addressLine
                                            .toString()
                                        : PLEASE_SELECT_ADDRESS.tr(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ))
                            : selectedAddress == null
                                ? Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: KThemeDarkGrey, width: 2),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              // ignore: todo
                                              10), //TODO responsive radius
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x0D000000),
                                              blurRadius: 11)
                                        ]),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'You can search address or Tap on map to select location',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ))
                                : Container(),
                        SizedBox(height: 10),
                        CustomButton(
                          text: SELECT_LOCATION,
                          buttonColor: maroonColor,
                          autoSize: true,
                          onPressed: () {
                            Provider.of<LocationNotifier>(context,
                                        listen: false)
                                    .setLocation =
                                Location(
                                    lat: selectedAddress.latitude,
                                    lon: selectedAddress.longitude);
                            Provider.of<LocationNotifier>(context,
                                    listen: false)
                                .setAddress = selectedAddress.address;
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressModel {
  AddressModel({this.address, this.latitude, this.longitude, this.geohash});
  double latitude;
  double longitude;
  var address;
  var geohash;
}
