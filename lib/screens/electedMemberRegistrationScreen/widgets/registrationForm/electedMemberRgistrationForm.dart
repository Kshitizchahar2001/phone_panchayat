// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/designatedUserDesignation.dart';
import 'package:online_panchayat_flutter/screens/electedMemberRegistrationScreen/electedMemberRegistrationScreenData.dart';
import 'package:online_panchayat_flutter/screens/widgets/selectUserPlaceWidget/selectUserPlace.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Data/ElectedMemberRegistrationFormData.dart';

class ElectedMemberRegistrationForm extends StatefulWidget {
  const ElectedMemberRegistrationForm({Key key}) : super(key: key);

  @override
  _ElectedMemberRegistrationFormState createState() =>
      _ElectedMemberRegistrationFormState();
}

class _ElectedMemberRegistrationFormState
    extends State<ElectedMemberRegistrationForm> {
  ElectedMemberRegistrationFormData electedMemeberRegistrationData;

  @override
  void initState() {
    electedMemeberRegistrationData = ElectedMemberRegistrationFormData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: REGISTER_AS_ELECTED_REPRESENTATIVE,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: getPostWidgetSymmetricPadding(
                context,
                vertical: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.safePercentHeight * 3,
                  ),
                  Text(
                    SELECT_DESIGNATION.tr(),
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  DropdownButton(
                    isExpanded: true,
                    value: electedMemeberRegistrationData.selectedDesignation,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (DesignatedUserDesignation value) {
                      setState(() {
                        electedMemeberRegistrationData.selectedDesignation =
                            value;
                      });
                    },
                    items: electedMemeberRegistrationData.designationsList
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
                    selectUserAreaIdentifiersData:
                        electedMemeberRegistrationData,
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
                  registrationInstructionText:
                      REGISTRATION_MESSAGE_BEFORE_REGISTERING_AS_ELECTED_MEMBER,
                  writeOperation: () async {
                    electedMemeberRegistrationData.selectedUserType.validate();
                    if (electedMemeberRegistrationData.selectedUserType
                        .allValid()) {
                      showMaterialDialog(context);
                      await electedMemeberRegistrationData.onSubmit();
                      Navigator.pop(context);
                      //
                      await Provider.of<ElectedMemberRegistrationScreenData>(
                              context,
                              listen: false)
                          .fetchDesignatedUser();
                    } else {
                      print("invalid");
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
