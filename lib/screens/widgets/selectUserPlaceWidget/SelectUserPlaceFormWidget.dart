// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'selectUserAreaIdentifiersData.dart';
import 'selectUserPlace.dart';

class SelectUserPlaceFormWidget extends StatefulWidget {
  const SelectUserPlaceFormWidget({Key key}) : super(key: key);

  @override
  _SelectUserPlaceFormWidgetState createState() =>
      _SelectUserPlaceFormWidgetState();
}

class _SelectUserPlaceFormWidgetState extends State<SelectUserPlaceFormWidget> {
  SelectUserAreaIdentifiersData selectUserAreaIdentifiers;

  @override
  void initState() {
    selectUserAreaIdentifiers = SelectUserAreaIdentifiersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              padding: getPostWidgetSymmetricPadding(
                context,
                vertical: 0,
              ),
              child: SelectUserPlace(
                selectUserAreaIdentifiersData: selectUserAreaIdentifiers,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            text: SUBMIT,
            autoSize: true,
            onPressed: () async {
              selectUserAreaIdentifiers.district.validate();
              selectUserAreaIdentifiers.selectedUserType.validate();
              if (selectUserAreaIdentifiers.district.isValid &&
                  selectUserAreaIdentifiers.selectedUserType.allValid()) {
                showMaterialDialog(context);
                await selectUserAreaIdentifiers.onSubmit();
                Navigator.pop(context);
                Navigator.pop(context);
                //
              } else {
                print("invalid");
              }
            },
          ),
        ),
      ],
    );
  }
}
