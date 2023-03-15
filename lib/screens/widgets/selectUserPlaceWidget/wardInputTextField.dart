// ignore_for_file: file_names, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:easy_localization/easy_localization.dart';

import 'Data/selectFirestoreIdentifiers.dart';

class WardInputTextField extends StatefulWidget {
  final FirestoreItemSelection itemSelection;
  const WardInputTextField({Key key, @required this.itemSelection})
      : super(key: key);

  @override
  _WardInputTextFieldState createState() => _WardInputTextFieldState();
}

class _WardInputTextFieldState extends State<WardInputTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.addListener(setValue);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.removeListener(setValue);
    super.dispose();
  }

  setValue() {
    widget.itemSelection.selectedItem = Places(
      id: textEditingController.value.text,
      name_en: textEditingController.value.text,
      name_hi: textEditingController.value.text,
      parentId: '',
      type: PlaceType.WARD,
    );
    print(widget.itemSelection.selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.itemSelection.label,
          style: Theme.of(context).textTheme.headline3.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ).tr(),
        TextField(
          controller: textEditingController,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline1.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ),
      ],
    );
  }
}
