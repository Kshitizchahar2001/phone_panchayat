// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/designatedUserDesignation.dart';
import 'package:online_panchayat_flutter/screens/electedMemberRegistrationScreen/widgets/registrationForm/Data/ElectedMemberRegistrationFormData.dart';
import 'package:online_panchayat_flutter/screens/widgets/OperationCompletionStatusDialog.dart';
import 'package:online_panchayat_flutter/screens/widgets/selectUserPlaceWidget/selectUserPlace.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'recommendRepresentativeData.dart';

class RecommendRepresentativeScreen extends StatefulWidget {
  const RecommendRepresentativeScreen({Key key}) : super(key: key);

  @override
  _RecommendRepresentativeScreenState createState() =>
      _RecommendRepresentativeScreenState();
}

class _RecommendRepresentativeScreenState
    extends State<RecommendRepresentativeScreen> {
  RecommendRepresentativeData recommendRepresentativeData;
  TextEditingController representativeNameController;
  TextEditingController representativePhoneNumberController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    representativeNameController = TextEditingController();
    representativePhoneNumberController = TextEditingController();
    recommendRepresentativeData = RecommendRepresentativeData();
    super.initState();
  }

  @override
  void dispose() {
    representativeNameController.dispose();
    representativePhoneNumberController.dispose();
    super.dispose();
  }

  String emptyStringCheckValidator(String input) {
    if (input == '' || input == null) return THIS_FIELD_IS_MANDATORY.tr();
    return null;
  }

  String phoneNumberInputValidation(String input) {
    if (input?.length != 10) return THIS_FIELD_IS_MANDATORY.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: RECOMMEND_A_REPRESENTATIVE,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: getPostWidgetSymmetricPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HeadingAndSubheading(
                  //   heading: RECOMMEND_A_REPRESENTATIVE,
                  //   subheading: "nirvichit pranidhi ki jankari dein. ",
                  // )
                  SizedBox(height: 5),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ELECTED_MEMBER_NAME,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s)),
                          ).tr(),
                          TextFormField(
                            validator: emptyStringCheckValidator,
                            controller: representativeNameController,
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                    ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            ELECTED_MEMBER_PHONE_NUMBER,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s)),
                          ).tr(),
                          TextFormField(
                            validator: phoneNumberInputValidation,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            controller: representativePhoneNumberController,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s)),
                          ),
                        ],
                      )),
                  SizedBox(height: 10),
                  Text(
                    SELECT_DESIGNATION.tr(),
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  DropdownButton(
                    isExpanded: true,
                    value: recommendRepresentativeData.selectedDesignation,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (DesignatedUserDesignation value) {
                      setState(() {
                        recommendRepresentativeData.selectedDesignation = value;
                      });
                    },
                    items: recommendRepresentativeData.designationsList
                        .map<DropdownMenuItem<DesignatedUserDesignation>>(
                          (e) => DropdownMenuItem(
                            child: Text(
                              electedMembersDesignation[e],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s10),
                                      fontWeight: FontWeight.w500),
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                  ),
                  SelectUserPlace(
                    selectUserAreaIdentifiersData: recommendRepresentativeData,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: SUBMIT,
              autoSize: true,
              onPressed: () async {
                performWriteOperationAfterConditionsCheck(
                  registrationInstructionText: null,
                  writeOperation: () async {
                    bool allInputsAreValid = _formKey.currentState.validate();

                    recommendRepresentativeData.selectedUserType.validate();
                    recommendRepresentativeData.district.validate();
                    if (recommendRepresentativeData.selectedUserType
                            .allValid() &&
                        allInputsAreValid) {
                      showMaterialDialog(context);
                      bool wasRecommendationOperationSuccessful =
                          await recommendRepresentativeData.onFormSubmit(
                        representativeNameController.text,
                        representativePhoneNumberController.text,
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (_) => Material(
                          type: MaterialType.transparency,
                          child: Center(
                            child: Padding(
                                padding: getPostWidgetSymmetricPadding(context,
                                    horizontal: 8),
                                child: OperationCompletionStatusDialog(
                                  heading: wasRecommendationOperationSuccessful
                                      ? "सिफारिश सफल"
                                      : "सिफारिश विफल",
                                  subheading: wasRecommendationOperationSuccessful
                                      ? "आपकी सिफारिश सफलता पूर्वक स्वीकार कर ली गई है।"
                                      : "तकनीकी समस्या के कारण यह अनुरोध पूरा नहीं किया जा सकता है।",
                                )),
                          ),
                        ),
                      );
                      //

                      // ignore: todo
                      // TODO : show success dialog
                    } else {
                    }
                  },
                  context: context,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
