// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_native_admob/flutter_native_admob.dart';
// import 'package:flutter_native_admob/native_admob_controller.dart';
// import 'package:flutter_native_admob/native_admob_options.dart';
// import 'package:online_panchayat_flutter/utils/utils.dart';

// class FLutterNativeAdmobWidget extends StatefulWidget {
//   const FLutterNativeAdmobWidget({Key key}) : super(key: key);

//   @override
//   _FLutterNativeAdmobWidgetState createState() =>
//       _FLutterNativeAdmobWidgetState();
// }

// class _FLutterNativeAdmobWidgetState extends State<FLutterNativeAdmobWidget> {
//   static const _adUnitID = "ca-app-pub-9013425290681574/5014172896";
//   bool error;
//   // static const _adUnitID = "<Your ad unit ID>";

//   final _nativeAdController = NativeAdmobController();
//   bool _loadComplete = false;
//   // double _height = 0;

//   StreamSubscription _subscription;
//   double _adHeight = 450.0;

//   @override
//   void initState() {
//     error = false;
//     _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _subscription.cancel();
//     _nativeAdController.dispose();
//     super.dispose();
//   }

//   void _onStateChanged(AdLoadState state) {
//     switch (state) {
//       case AdLoadState.loading:
//         setState(() {
//           _loadComplete = false;
//         });
//         break;

//       case AdLoadState.loadCompleted:
//         setState(() {
//           _loadComplete = true;
//           // _height = 341;
//           // _height = 330;
//         });
//         break;

//       case AdLoadState.loadError:
//         setState(() {
//           error = true;
//         });

//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return error
//         ? const SizedBox()
//         : Column(
//             children: [
//               Container(
//                 color: Colors.grey[100],
//                 height: _loadComplete ? 0 : _adHeight,
//               ),
//               Container(
//                 height: _loadComplete ? _adHeight : 0,
//                 child: Padding(
//                   padding: getPostWidgetSymmetricPadding(context,
//                       vertical: 0.5, horizontal: 3),
//                   child: NativeAdmob(
//                     // Your ad unit id
//                     adUnitID: _adUnitID,
//                     numberAds: 1,
//                     controller: _nativeAdController,
//                     type: NativeAdmobType.full,
//                     options: NativeAdmobOptions(
//                         callToActionStyle: NativeTextStyle(
//                           backgroundColor: Colors.blue,
//                         ),
//                         advertiserTextStyle: NativeTextStyle(
//                           fontSize: responsiveFontSize(context,
//                               size: ResponsiveFontSizes.xs10),
//                           color: Theme.of(context).textTheme.headline4.color,
//                         ),
//                         bodyTextStyle: NativeTextStyle(
//                           color: Theme.of(context).textTheme.subtitle1.color,
//                           // fontSize: responsiveFontSize(context, size: ResponsiveFontSizes.m),
//                         ),
//                         adLabelTextStyle: NativeTextStyle(
//                           color: Colors.grey[800],
//                           backgroundColor: Colors.white,
//                         )),
//                   ),
//                 ),
//               ),
//               _loadComplete
//                   ? Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Divider(
//                         thickness: 1.0,
//                       ),
//                     )
//                   : const SizedBox(),
//             ],
//           );
//   }
// }
