// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/AreaType.dart';
import 'package:online_panchayat_flutter/models/Complaint.dart';
import 'package:online_panchayat_flutter/models/DesignatedUserType.dart';
import 'package:online_panchayat_flutter/screens/widgets/selectUserPlaceWidget/selectUserAreaIdentifiersData.dart';
import 'package:online_panchayat_flutter/screens/widgets/selectUserPlaceWidget/selectUserPlace.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:online_panchayat_flutter/utils/getPageAppBar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class AddComplaintScreen extends StatefulWidget {
  const AddComplaintScreen({Key key}) : super(key: key);

  @override
  _AddComplaintScreenState createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  SelectUserAreaIdentifiersData selectUserAreaIdentifiersData;

  @override
  void initState() {
    selectUserAreaIdentifiersData = SelectUserAreaIdentifiersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: ADD_COMPLAINT.tr(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: getPostWidgetSymmetricPadding(
                context,
                vertical: 0,
              ),
              child: SelectUserPlace(
                  selectUserAreaIdentifiersData: selectUserAreaIdentifiersData),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: SUBMIT,
              buttonColor: maroonColor,
              autoSize: true,
              onPressed: () {
                selectUserAreaIdentifiersData.district.validate();
                selectUserAreaIdentifiersData.selectedUserType.validate();
                if (selectUserAreaIdentifiersData.district.isValid &&
                    selectUserAreaIdentifiersData.selectedUserType.allValid()) {
                  Complaint complaint;

                  if (selectUserAreaIdentifiersData
                          .selectedUserType.designatedUserType ==
                      DesignatedUserType.URBAN)
                    complaint = Complaint(
                      areaType: AreaType.URBAN,
                      municipality: selectUserAreaIdentifiersData
                          .selectedUserType.itemSelection1.selectedItem.id,
                      wardNo: int.parse(selectUserAreaIdentifiersData
                          .selectedUserType.itemSelection2.selectedItem.id),
                    );
                  else
                    complaint = Complaint(
                      areaType: AreaType.RURAL,
                      panchayatCommittee: selectUserAreaIdentifiersData
                          .selectedUserType.itemSelection1.selectedItem.id,
                      villagePanchayat: selectUserAreaIdentifiersData
                          .selectedUserType.itemSelection2.selectedItem.id,
                    );
                  context.vxNav
                      .push(Uri.parse(MyRoutes.createPostRoute), params: {
                    "complaint": complaint,
                  });
                  //
                } else {
                  print("invalid");
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(PLEASE_FILL_ALL_FIELDS).tr()));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


            // Text(
            //   CHOOSE_AREA_TYPE.tr(),
            //   style: Theme.of(context).textTheme.headline3.copyWith(
            //       fontSize:
            //           responsiveFontSize(context, size: ResponsiveFontSizes.s)),
            // ).tr(),
            // SizedBox(
            //   height: context.safePercentHeight * 2,
            // ),
            // DropdownButton(
            //   isExpanded: true,
            //   value: userType,
            //   icon: Icon(Icons.arrow_drop_down),
            //   onChanged: (value) {
            //     setState(() {
            //       textEditingController1.clear();
            //       textEditingController2.clear();
            //       userType = value;
            //     });
            //   },
            //   items: userTypes
            //       .map<DropdownMenuItem<String>>(
            //         (e) => DropdownMenuItem(
            //           child: Text(
            //             e,
            //             style: Theme.of(context).textTheme.headline2.copyWith(
            //                 fontSize: responsiveFontSize(context,
            //                     size: ResponsiveFontSizes.s10),
            //                 fontWeight: FontWeight.w500),
            //           ),
            //           value: e,
            //         ),
            //       )
            //       .toList(),
            // ),
            // ResponsiveHeight(
            //   heightRatio: 2,
            // ),
            // LabelAndCustomTextField(
            //   label: (userType == userTypes[0])
            //       ? MUNICIPALITY
            //       : PANCHAYAT_COMMITTEE,
            //   textEditingController: textEditingController1,
            // ),
            // ResponsiveHeight(
            //   heightRatio: 2,
            // ),
            // LabelAndCustomTextField(
            //   label: (userType == userTypes[0]) ? WARD_NO : VILLAGE_PANCHAYAT,
            //   textEditingController: textEditingController2,
            //   inputType: (userType == userTypes[0])
            //       ? TextInputType.number
            //       : TextInputType.multiline,
            // ),
            // ResponsiveHeight(
            //   heightRatio: 2,
            // ),