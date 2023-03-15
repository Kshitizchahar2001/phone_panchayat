// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color fillColor;
  final Color shadowColor = textFieldShadowColor;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final void Function(String) onSaved;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final String prefixText;
  final String hintText;
  final String initialValue;
  final bool multiLines;
  final int maxLines;
  final int maxLength;
  final TextInputType inputType;
  final TextEditingController textEditingController;
  final bool enabled;
  final List<TextInputFormatter> inputFormatters;
  final FocusNode focusNode;

  CustomTextField(
      {Key key,
      this.multiLines = false,
      this.maxLength,
      this.prefixText,
      this.hintText,
      this.inputType,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.onChanged,
      this.maxLines,
      this.textEditingController,
      this.readOnly,
      this.textCapitalization,
      this.fillColor = textFieldFillColor,
      this.enabled,
      this.borderRadius = const BorderRadius.all(
        Radius.circular(10),
      ),
      this.inputFormatters,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textEditingController != null && initialValue != null) {
      textEditingController.text = initialValue;
    }
    // return Material(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   elevation: 4.0,
    //   shadowColor: shadowColor,)
    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(blurRadius: 4, color: shadowColor, offset: Offset(0, 2))
        ],
      ),
      child: TextFormField(
        focusNode: focusNode,
        enabled: enabled,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        readOnly: readOnly ?? false,
        inputFormatters: (inputFormatters == null)
            ? (maxLength == null)
                ? null
                : [
                    LengthLimitingTextInputFormatter(maxLength),
                  ]
            : inputFormatters,
        controller:
            textEditingController != null ? textEditingController : null,
        initialValue:
            textEditingController == null ? initialValue ?? null : null,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        cursorColor: KThemeLightGrey,
        showCursor: true,
        style: TextStyle(height: 1.2, color: KThemeLightGrey),
        maxLength: null,
        keyboardType: inputType ?? null,
        maxLines: (multiLines)
            ? (maxLines != null)
                ? maxLines
                : null
            : 1,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
          border: InputBorder.none,
          hintText: hintText ?? null,
          prefix: (prefixText != null) ? Text(prefixText) : null,
          fillColor: fillColor,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(16.0, 14.0, 15.0, 13.0),
          enabledBorder: textFormFieldBorder(),
          focusedBorder: textFormFieldBorder(),
          errorBorder: textFormFieldBorder(),
          focusedErrorBorder: textFormFieldBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder textFormFieldBorder() {
    return OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromRGBO(255, 255, 255, 1), width: 0.0),
        borderRadius: borderRadius);
  }
}
