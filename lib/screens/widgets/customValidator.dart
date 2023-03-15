// ignore_for_file: file_names, curly_braces_in_flow_control_structures, avoid_renaming_method_parameters, annotate_overrides, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/DatePicker/src/date.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class CheckValidity {
  ValueNotifier<String> errorMessage = ValueNotifier<String>(null);
  bool isValid = true;

  validate(dynamic val) {
    String error = validator(val);
    if (error == null || error == "")
      isValid = true;
    else
      isValid = false;
    errorMessage.value = error;
  }

  String validator(dynamic val);
}

class DateValidator extends CheckValidity {
  String validator(dynamic date) {
    Date d = date as Date;
    if (d.day == null || d.month == null || d.year == null)
      return THIS_FIELD_IS_MANDATORY.tr();
    else
      return null;
  }
}

class CustomValidator extends StatelessWidget {
  final CheckValidity checkValidity;
  CustomValidator({
    Key key,
    @required this.checkValidity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: checkValidity.errorMessage,
      builder: (context, value, child) {
        if (checkValidity.isValid)
          return Container();
        else
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              value,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          );
      },
    );
  }
}
