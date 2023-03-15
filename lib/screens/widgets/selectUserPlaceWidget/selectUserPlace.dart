// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/identifierType.dart';
import 'package:velocity_x/velocity_x.dart';
import 'itemSelectionDropdown.dart';
import 'selectUserAreaIdentifiersData.dart';
import 'wardInputTextField.dart';

class SelectUserPlace extends StatefulWidget {
  final SelectUserAreaIdentifiersData selectUserAreaIdentifiersData;
  const SelectUserPlace({Key key, @required this.selectUserAreaIdentifiersData})
      : super(key: key);

  @override
  _SelectUserPlaceState createState() => _SelectUserPlaceState();
}

class _SelectUserPlaceState extends State<SelectUserPlace> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: context.safePercentHeight * 3,
        ),
        ItemSelectionDropDown(
          itemSelection: widget.selectUserAreaIdentifiersData.state,
        ),
        SizedBox(
          height: context.safePercentHeight * 3,
        ),
        ItemSelectionDropDown(
          itemSelection: widget.selectUserAreaIdentifiersData.district,
        ),
        // Text(
        //   CHOOSE_AREA_TYPE.tr(),
        //   style: Theme.of(context).textTheme.headline3.copyWith(
        //       fontSize:
        //           responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        // ).tr(),
        // AreaTypeSelectionRadioButton(
        //   userTypeByArea: widget.selectUserAreaIdentifiersData.rural,
        //   selectUserAreaIdentifiersData: widget.selectUserAreaIdentifiersData,
        //   firestoreItemSelection:
        //       widget.selectUserAreaIdentifiersData.userAreaType,
        //   setState: () {
        //     setState(() {});
        //   },
        // ),
        // AreaTypeSelectionRadioButton(
        //   userTypeByArea: widget.selectUserAreaIdentifiersData.urban,
        //   selectUserAreaIdentifiersData: widget.selectUserAreaIdentifiersData,
        //   firestoreItemSelection:
        //       widget.selectUserAreaIdentifiersData.userAreaType,
        //   setState: () {
        //     setState(() {});
        //   },
        // ),
        SizedBox(
          height: context.safePercentHeight * 3,
        ),
        ItemSelectionDropDown(
          itemSelection: widget
              .selectUserAreaIdentifiersData.selectedUserType.itemSelection1,
        ),
        SizedBox(
          height: context.safePercentHeight * 2,
        ),
        Builder(
          builder: (context) {
            if (widget.selectUserAreaIdentifiersData.selectedUserType
                    .itemSelection2.identifierType ==
                IdentifierType.WARD) {
              return WardInputTextField(
                itemSelection: widget.selectUserAreaIdentifiersData
                    .selectedUserType.itemSelection2,
              );
            } else {
              return ItemSelectionDropDown(
                itemSelection: widget.selectUserAreaIdentifiersData
                    .selectedUserType.itemSelection2,
              );
            }
          },
        )
      ],
    );
  }
}
