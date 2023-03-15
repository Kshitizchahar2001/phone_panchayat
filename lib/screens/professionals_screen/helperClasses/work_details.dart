// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class WorkDetail {
  WorkDetail({
    this.occupationValue,
    this.workSpecialities,
    this.workSpecialityItems,
    this.workExperience,
    this.workExperienceItems = const ["0.5", "1", "2", "3", "5", "10"],
  });

  Map occupationValue;
  List<Map> workSpecialities;
  List<Map> workSpecialityItems;
  String workExperience;
  List<String> workExperienceItems;

  /// Method used for converting a List<Map> services into dropdown items
  /// used in register professional and edit professional
  List<DropdownMenuItem> getDropDownItems(List items) {
    List<DropdownMenuItem> dropDownlist = [];
    for (int i = 0; i < items.length; i++) {
      dropDownlist.add(DropdownMenuItem(
          child: Text(items[i]["name"]).tr(), value: items[i]));
    }
    return dropDownlist;
  }
}
