// ignore_for_file: file_names
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/material.dart';
// import 'package:online_panchayat_flutter/Main/routes.dart';
// import 'package:online_panchayat_flutter/constants/constants.dart';
// import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
// import 'package:online_panchayat_flutter/firestoreModels/Panchayat.dart';
// import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/setRadiusDialog.dart';
// import 'package:online_panchayat_flutter/screens/SignUpScreen/unusedCode/signUpScreenData.dart';
// import 'package:online_panchayat_flutter/services/analyticsService.dart';
// import 'package:online_panchayat_flutter/utils/utils.dart';
// import 'package:provider/provider.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'panchayatTile.dart';

// class PanchayatConfirmation extends StatefulWidget {
//   const PanchayatConfirmation({Key key}) : super(key: key);

//   @override
//   _PanchayatConfirmationState createState() => _PanchayatConfirmationState();
// }

// class _PanchayatConfirmationState extends State<PanchayatConfirmation> {
//   SignUpScreenData signUpScreenData;
//   @override
//   void initState() {
//     signUpScreenData = Provider.of<SignUpScreenData>(context, listen: false);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: getPostWidgetSymmetricPadding(context),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Consumer<SignUpScreenData>(
//                 builder: (context, value, child) {
//                   if (value.loading)
//                     return Center(child: CircularProgressIndicator());
//                   else if (value.panchayatList.isEmpty)
//                     return Center(
//                       child: Text(
//                         NO_PANCHAYAT_FOUND.tr(
//                           namedArgs: {"km": "${value.radius}"},
//                         ),
//                         style: Theme.of(context).textTheme.headline1.copyWith(
//                               fontSize: responsiveFontSize(
//                                 context,
//                                 size: ResponsiveFontSizes.s,
//                               ),
//                             ),
//                       ),
//                     );
//                   else {
//                     Panchayat panchayat =
//                         value.panchayatList[value.selectedIndex];
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Flexible(
//                           child: Container(),
//                           flex: 1,
//                         ),
//                         Flexible(
//                           flex: 2,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                     image: NetworkImage(
//                                         panchayat.imageURL ?? APP_ICON_URL))),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Flexible(
//                           flex: 4,
//                           child: Center(
//                               child: RichText(
//                             textAlign: TextAlign.center,
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: DISPLAY_PANCHAYAT_NAME.tr(namedArgs: {
//                                     "name": panchayat.panchayatName.toString(),
//                                   }),
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headline1
//                                       .copyWith(
//                                         fontSize: responsiveFontSize(
//                                           context,
//                                           size: ResponsiveFontSizes.l,
//                                         ),
//                                       ),
//                                 ),
//                                 TextSpan(
//                                   text: "\n\n",
//                                 ),
//                                 TextSpan(
//                                   text: DO_YOU_WANT_TO_JOIN_THIS_PANCHAYAT
//                                       .tr(namedArgs: {
//                                     "name": panchayat.panchayatName.toString(),
//                                   }),
//                                 ),
//                               ],
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headline1
//                                   .copyWith(
//                                     fontSize: responsiveFontSize(
//                                       context,
//                                       size: ResponsiveFontSizes.m10,
//                                     ),
//                                   ),
//                             ),
//                           )),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//             Column(
//               children: [
//                 CustomButton(
//                   text: NEXT,
//                   buttonColor: maroonColor,
//                   autoSize: true,
//                   boxShadow: [],
//                   borderRadius: 5,
//                   onPressed: () {
//                     if (signUpScreenData.panchayatList.length > 0) {
//                       showMaterialDialog(context);
//                       AnalyticsService.firebaseAnalytics
//                           .logEvent(name: "panchayat_selected", parameters: {
//                         "panchayat_name": signUpScreenData
//                             .panchayatList[signUpScreenData.selectedIndex]
//                             .panchayatName,
//                         "selection_type": signUpScreenData.selectedIndex == 0
//                             ? "closest"
//                             : "manually_selected"
//                       });
//                       signUpScreenData.completeSignUp();
//                     } else {
//                       Scaffold.of(context).showSnackBar(
//                           SnackBar(content: Text(NO_PANCHAYAT_SELECTED).tr()));
//                       print("error");
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 CustomButton(
//                   text: CHANGE_PLACE,
//                   buttonColor: Colors.transparent,
//                   autoSize: true,
//                   boxShadow: [],
//                   borderRadius: 5,
//                   textColor: maroonColor,
//                   boxBorder: Border.all(
//                     color: maroonColor,
//                     width: 1,
//                   ),
//                   onPressed: () {
//                     context.vxNav.push(Uri.parse(
//                       MyRoutes.listPanchayat,
//                     ));
//                   },
//                 ),
//               ],
//             )
//           ],
//         ));
//   }
// }
