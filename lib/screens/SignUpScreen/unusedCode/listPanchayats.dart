// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:online_panchayat_flutter/constants/constants.dart';
// import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
// import 'package:online_panchayat_flutter/firestoreModels/Panchayat.dart';
// import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/setRadiusDialog.dart';
// import 'package:online_panchayat_flutter/screens/SignUpScreen/unusedCode/signUpScreenData.dart';
// import 'package:online_panchayat_flutter/utils/utils.dart';
// import 'package:provider/provider.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'panchayatTile.dart';

// class ListPanchayats extends StatefulWidget {
//   const ListPanchayats({Key key}) : super(key: key);

//   @override
//   _ListPanchayatsState createState() => _ListPanchayatsState();
// }

// class _ListPanchayatsState extends State<ListPanchayats> {
//   SignUpScreenData signUpScreenData;
//   @override
//   void initState() {
//     signUpScreenData = Provider.of<SignUpScreenData>(context, listen: false);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: getPageAppBar(
//         context: context,
//         text: SELECT_AREA,
//         showBackArrow: false,
//       ),
//       body: Container(
//         constraints: BoxConstraints.expand(),
//         child: ListView(
//           padding: EdgeInsets.only(
//             top: 15,
//             left: context.safePercentWidth * 2,
//             right: context.safePercentWidth * 2,
//           ),
//           children: <Widget>[
//             InkWell(
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return Material(
//                         type: MaterialType.transparency,
//                         child: SetRadiusDialog(
//                           radiusData: signUpScreenData,
//                         ),
//                       );
//                     });
//               },
//               child: Padding(
//                 padding: getPostWidgetSymmetricPadding(context),
//                 child: Consumer<SignUpScreenData>(
//                     builder: (context, value, child) {
//                   return RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: PANCHAYAT_RADIUS_MESSAGE.tr(
//                               namedArgs: {'km': '${signUpScreenData.radius}'}),
//                         ),
//                         TextSpan(
//                           text: CHANGE_RADIUS.tr(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: maroonColor,
//                           ),
//                         ),
//                       ],
//                       style: Theme.of(context).textTheme.headline1.copyWith(
//                               fontSize: responsiveFontSize(
//                             context,
//                             size: ResponsiveFontSizes.s,
//                           )),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             Consumer<SignUpScreenData>(
//               builder: (context, value, child) {
//                 if (value.loading)
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 else if (value.panchayatList.isEmpty)
//                   return Container(
//                     height: context.safePercentHeight * 60,
//                     child: Center(
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
//                     ),
//                   );
//                 return ListView.builder(
//                   shrinkWrap: true, // 1st add
//                   physics: ClampingScrollPhysics(),
//                   itemCount: value.panchayatList.length,
//                   padding: EdgeInsets.only(
//                     top: 5,
//                   ),
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         value.onIndexChange(index);
//                         Navigator.pop(context);
//                       },
//                       child: PanchayatTile(
//                         panchayat: value.panchayatList[index],
//                         myLocation: value.myLocation,
//                         selected: index == value.selectedIndex,
//                       ),
//                     );
//                   },
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
