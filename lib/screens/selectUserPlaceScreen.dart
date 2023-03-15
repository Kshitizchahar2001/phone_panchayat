// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/selectUserPlaceWidget/SelectUserPlaceFormWidget.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class SelectUserAreaIdentifiersScreen extends StatefulWidget {
  const SelectUserAreaIdentifiersScreen({Key key}) : super(key: key);

  @override
  _SelectUserAreaIdentifiersScreenState createState() =>
      _SelectUserAreaIdentifiersScreenState();
}

class _SelectUserAreaIdentifiersScreenState
    extends State<SelectUserAreaIdentifiersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: SELECT_PANCHAYAT,
        // text: "Select panchayat",
      ),
      body: SelectUserPlaceFormWidget(),
    );
  }
}
