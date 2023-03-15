// ignore_for_file: implementation_imports, deprecated_member_use, prefer_const_constructors

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/helperClasses/work_details.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/services_constant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/multi_select.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/service_dropdown.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';

class WorkDetails extends StatefulWidget {
  const WorkDetails({
    Key key,
    @required this.formKey,
    @required this.workDetail,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final WorkDetail workDetail;

  @override
  State<WorkDetails> createState() => _WorkDetailsState();
}

class _WorkDetailsState extends State<WorkDetails> {
  Map occupationValue;
  void occupationOnChanged(value) {
    setState(() {
      widget.workDetail.occupationValue = value;
      widget.workDetail.workSpecialityItems = value["subServices"];
    });
  }

  void workSpecilityOnConfirm(values) {
    setState(() {
      widget.workDetail.workSpecialities = values;
    });
  }

  void workExperienceOnChanged(value) {
    setState(() {
      widget.workDetail.workExperience = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: WorkDetailDropDowns(
        workDetail: widget.workDetail,
        occupationOnChanged: occupationOnChanged,
        workSpecilityOnConfirm: workSpecilityOnConfirm,
        workExperienceOnChanged: workExperienceOnChanged,
      ),
    );
  }
}

class WorkDetailDropDowns extends StatelessWidget {
  const WorkDetailDropDowns({
    Key key,
    @required this.workDetail,
    @required this.occupationOnChanged,
    @required this.workSpecilityOnConfirm,
    @required this.workExperienceOnChanged,
  }) : super(key: key);
  final WorkDetail workDetail;
  final Function occupationOnChanged;
  final Function workSpecilityOnConfirm;
  final Function workExperienceOnChanged;

  @override
  Widget build(BuildContext context) {
    double textFieldVerticalPadding = 10.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServiceDropdown(
          label: OCCUPATION,
          dropDownItems: workDetail.getDropDownItems(serviceList),
          hint: Text(
            SELECT,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s)),
          ).tr(),
          value: workDetail.occupationValue,
          onChanged: occupationOnChanged,
          dropDownValidator: RegistrationScreenUtilities.dropDownValidator,
        ),
        SizedBox(height: textFieldVerticalPadding * 2),

        ///
        /// Multi select bottom sheet for work speciality
        /// rendering it conditionally to always provide it a value of subservices
        if (workDetail.occupationValue != null) ...[
          Text(
            WORK_SPECIALITY,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s)),
          ).tr(),
          SizedBox(
            height: textFieldVerticalPadding,
          ),
          Container(
            decoration: BoxDecoration(
                // border: Border.all(
                //   color: Theme.of(context).primaryColor,
                //   width: 0.1,
                // ),
                // borderRadius: BorderRadius.circular(10.0),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // MultiSelect(
                //   items: workDetail.workSpecialityItems,
                // )

                InkWell(
                  onTap: () async {
                    final List<Map> results = await showGeneralDialog(
                      context: context,
                      pageBuilder: (ctx, a1, a2) => Container(),
                      transitionBuilder:
                          (context, animation, animation1, child) {
                        var curve =
                            Curves.bounceInOut.transform(animation.value);
                        return Transform.scale(
                          child: MultiSelect(
                              initailItems: workDetail.workSpecialities,
                              items: workDetail.workSpecialityItems),
                          scale: curve,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 200),
                    );
                    if (results != null) {
                      workSpecilityOnConfirm(results);
                    }
                  },
                  child: LabelAndCustomTextField(
                    enabled: false,
                    textEditingController:
                        TextEditingController(text: SELECT.tr()),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    label: WORK_SPECIALITY,
                    validator: (value) =>
                        RegistrationScreenUtilities.listValidator(
                            workDetail.workSpecialities),
                  ),
                ),

                if (workDetail.workSpecialities != null) ...[
                  SizedBox(height: textFieldVerticalPadding),
                  Wrap(
                    children: workDetail.workSpecialities.map((work) {
                      return Container(
                        margin:
                            EdgeInsets.only(right: 5.0, bottom: 5.0, left: 3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: maroonColor),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: Text(work["name"]).tr(),
                      );
                    }).toList(),
                  ),
                ]
                //   MultiSelectBottomSheetField<Map>(
                //     decoration: BoxDecoration(
                //         border: Border.all(color: maroonColor, width: 0.1),
                //         borderRadius: BorderRadius.circular(10.0)),
                //     listType: MultiSelectListType.LIST,
                //     initialChildSize: workDetail.getBottomSheetHeight,
                //     initialValue: workDetail.workSpecialities,
                //     maxChildSize: 0.9,
                //     buttonText: Text(SELECT,
                //             style: Theme.of(context).textTheme.headline2.copyWith(
                //                 fontSize: responsiveFontSize(context,
                //                     size: ResponsiveFontSizes.s)))
                //         .tr(),
                //     title: Center(
                //       child: Text(WORK_SPECIALITY,
                //           style: Theme.of(context).textTheme.headline1.copyWith(
                //                 fontSize: responsiveFontSize(context,
                //                     size: ResponsiveFontSizes.m),
                //               )).tr(),
                //     ),
                //     selectedItemsTextStyle:
                //         Theme.of(context).textTheme.headline2.copyWith(
                //               fontSize: responsiveFontSize(context,
                //                   size: ResponsiveFontSizes.s),
                //             ),
                //     itemsTextStyle:
                //         Theme.of(context).textTheme.headline2.copyWith(
                //               fontSize: responsiveFontSize(context,
                //                   size: ResponsiveFontSizes.s),
                //             ),
                //     items: workDetail
                //         .mapToMultiSelectItems(workDetail.workSpecialityItems),
                //     onConfirm: workSpecilityOnConfirm,
                //     chipDisplay: MultiSelectChipDisplay(
                //       chipColor: maroonColor,
                //       textStyle: TextStyle(color: Colors.white),
                //       onTap: (value) {
                //         print(value);
                //       },
                //     ),
                //     validator: RegistrationScreenUtilities.listValidator,
                //   ),
              ],
            ),
          ),
        ],
        SizedBox(height: textFieldVerticalPadding * 2),
        ServiceDropdown(
          label: WORK_EXPERIENCE,
          icon: Text(
            YEAR,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s)),
          ).tr(),
          value: workDetail.workExperience,
          hint: Text(
            SELECT,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s)),
          ).tr(),
          dropDownItems: workDetail.workExperienceItems.map((value) {
            return DropdownMenuItem(child: Text(value), value: value);
          }).toList(),
          onChanged: workExperienceOnChanged,
          dropDownValidator: RegistrationScreenUtilities.dropDownValidator,
        ),
        SizedBox(height: textFieldVerticalPadding * 2),
      ],
    );
  }
}
