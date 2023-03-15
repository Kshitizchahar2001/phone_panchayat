// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class LabelAndCustomTextField extends StatelessWidget {
  final Function validator;
  final String label;
  final bool multiLines;
  final TextEditingController textEditingController;
  final TextInputType inputType;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final bool enabled;
  final Widget suffixIcon;
  final Widget prefix;
  final int maxLength;
  final bool autofocus;
  final FocusNode focusNode;
  LabelAndCustomTextField({
    this.label,
    this.textEditingController,
    this.inputType,
    this.validator,
    this.textCapitalization,
    this.maxLines,
    this.enabled,
    this.suffixIcon,
    this.prefix,
    this.maxLength,
    this.autofocus = false,
    this.multiLines = false,
    this.focusNode,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      autofocus: autofocus,
      maxLength: maxLength,
      maxLines: (multiLines)
          ? (maxLines != null)
              ? maxLines
              : null
          : 1,
      focusNode: focusNode,
      decoration: InputDecoration(
        prefix: prefix,
        suffixIcon: suffixIcon,
        errorStyle: TextStyle(color: Colors.red),
        focusColor: maroonColor,
        enabledBorder: textFormFieldBorder(context, color: Colors.grey[300]),
        // enabledBorder: textFormFieldBorder(context, color: Colors.greenAccent),
        focusedBorder: textFormFieldBorder(context, color: maroonColor),
        errorBorder: textFormFieldBorder(context, color: Colors.red),
        disabledBorder: textFormFieldBorder(context, color: Colors.grey[300]),
        focusedErrorBorder: textFormFieldBorder(context, color: Colors.red),
        labelText: label.tr(),
        labelStyle: Theme.of(context).textTheme.headline3.copyWith(
              fontWeight: FontWeight.normal,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s),
            ),
      ),
      // maxLines: multiLines,
      keyboardType: inputType,
      controller: textEditingController,
      validator: validator,
      textCapitalization: textCapitalization,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: responsiveFontSize(context, size: ResponsiveFontSizes.s),
          ),
    );
  }

  OutlineInputBorder textFormFieldBorder(BuildContext context, {Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1.25, color: color),
      borderRadius: BorderRadius.circular(4),
    );
  }
}
        // CustomTextField(
        //   multiLines: multiLines,
        //   inputType: inputType,
        //   textEditingController: textEditingController,
        //   validator: validator,
        //   textCapitalization: textCapitalization,
        // ),
