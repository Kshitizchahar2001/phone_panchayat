// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:online_panchayat_flutter/constants/constants.dart';
// import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
// import 'package:online_panchayat_flutter/screens/SignUpScreen/signUpScreenData.dart';
// import 'package:online_panchayat_flutter/services/analyticsService.dart';
// import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
// import 'package:online_panchayat_flutter/utils/custom_button.dart';
// import 'package:provider/provider.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:easy_localization/easy_localization.dart';

// class AskForLocationScreen extends StatelessWidget {
//   final Function nextPage;
//   const AskForLocationScreen({
//     Key key,
//     @required this.nextPage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints.expand(),
//       child: Padding(
//         padding:
//             getPostWidgetSymmetricPadding(context, vertical: 0, horizontal: 6),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               ResponsiveHeight(
//                 heightRatio: 10,
//               ),
//               Text(ENABLE_LOCATION,
//                       style: Theme.of(context).textTheme.headline1.copyWith(
//                           fontSize: responsiveFontSize(
//                             context,
//                             size: ResponsiveFontSizes.l,
//                           ),
//                           fontWeight: FontWeight.normal))
//                   .tr(),
//               ResponsiveHeight(
//                 heightRatio: 15,
//               ),
//               Icon(
//                 Icons.location_on,
//                 color: Colors.red,
//                 size: context.safePercentHeight * 30,
//               ),
//               ResponsiveHeight(
//                 heightRatio: 20,
//               ),
//               CustomButton(
//                 text: GIVE_PERMISSION,
//                 autoSize: true,
//                 onPressed: () async {
//                   AnalyticsService.firebaseAnalytics.logEvent(
//                     name: "location_permission_button_press",
//                   );
//                   SignUpScreenData signUpScreenData =
//                       Provider.of<SignUpScreenData>(context, listen: false);

//                   bool locationEnabled =
//                       await signUpScreenData.askForCurrentLocation();
//                   if (locationEnabled) {
//                     nextPage();
//                     signUpScreenData.getPanchayatList();
//                     // go to next page
//                   }
//                 },
//                 buttonColor: maroonColor,
//                 textColor: Colors.white,
//               ),
//               ResponsiveHeight(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
