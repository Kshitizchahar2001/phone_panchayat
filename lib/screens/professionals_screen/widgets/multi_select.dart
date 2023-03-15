// ignore_for_file: implementation_imports, annotate_overrides, prefer_const_constructors, deprecated_member_use

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';

class MultiSelect extends StatefulWidget {
  final List<Map> items;
  final List<Map> initailItems;
  const MultiSelect({Key key, @required this.items, this.initailItems})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<Map> _selectedItems = [];

  void initState() {
    if (widget.initailItems != null) _selectedItems.addAll(widget.initailItems);
    super.initState();
  }

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(Map itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Work Speciality'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item["name"]).tr(),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text(CANCEL).tr(),
          onPressed: _cancel,
          style: TextButton.styleFrom(primary: lightGreySubheading),
        ),
        TextButton(
          child: Text(SUBMIT).tr(),
          onPressed: _submit,
          style: TextButton.styleFrom(primary: maroonColor),
        ),
      ],
    );
  }
}
