// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/screens/widgets/selectUserPlaceWidget/selectUserAreaIdentifiersData.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';

import 'Data/selectFirestoreIdentifiers.dart';
import 'Data/userTypeByArea.dart';

class AreaTypeSelectionRadioButton extends StatelessWidget {
  final UserTypeByArea userTypeByArea;
  final SelectUserAreaIdentifiersData selectUserAreaIdentifiersData;
  final FirestoreItemSelection firestoreItemSelection;
  final Function setState;
  const AreaTypeSelectionRadioButton(
      {Key key,
      @required this.userTypeByArea,
      @required this.selectUserAreaIdentifiersData,
      @required this.firestoreItemSelection,
      @required this.setState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirestoreItemSelection>.value(
        value: firestoreItemSelection,
        builder: (context, child) {
          return Consumer<FirestoreItemSelection>(
              builder: (context, itemSelection, child) {
            return InkWell(
              onTap: () {
                onChanged(userTypeByArea);
              },
              splashColor: Colors.transparent,
              enableFeedback: false,
              child: ListTile(
                title: Text(
                  // RURAL.tr(),
                  userTypeByArea.userTypeValue,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s10),
                      fontWeight: FontWeight.w500),
                ),
                trailing: Radio<UserTypeByArea>(
                  value: userTypeByArea,
                  groupValue: selectUserAreaIdentifiersData.selectedUserType,
                  onChanged: onChanged,
                ),
              ),
            );
          });
        });
  }

  void onChanged(UserTypeByArea value) {
    // setState(() {
    selectUserAreaIdentifiersData.setUserType(value);
    selectUserAreaIdentifiersData.userAreaType
        .onItemTap(Places(id: value.userTypeValue, parentId: null, type: null));
    setState();
    // });
  }
}
