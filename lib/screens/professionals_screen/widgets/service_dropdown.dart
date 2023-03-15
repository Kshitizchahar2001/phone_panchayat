// ignore_for_file: implementation_imports, prefer_typing_uninitialized_variables, deprecated_member_use, prefer_const_constructors

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceDropdown extends StatelessWidget {
  const ServiceDropdown(
      {Key key,
      @required this.dropDownItems,
      @required this.value,
      @required this.hint,
      @required this.onChanged,
      @required this.dropDownValidator,
      this.borderRadius,
      this.isExpanded = false,
      this.label,
      this.icon})
      : super(key: key);
  final List<DropdownMenuItem> dropDownItems;
  final value;
  final Widget hint;
  final Function onChanged;
  final Function dropDownValidator;
  final String label;
  final Widget icon;
  final double borderRadius;
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s)),
          ).tr(),
          SizedBox(
            height: context.safePercentHeight * 0.5,
          ),
        ],
        DropdownButtonFormField(
          isExpanded: true,
          isDense: true,
          icon: icon,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: 0.0, horizontal: context.safePercentWidth * 3),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: BorderSide(color: Colors.grey[300]),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: BorderSide(color: maroonColor),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
                borderSide: BorderSide(color: Colors.red)),
          ),

          items: dropDownItems,
          value: value,
          hint: hint,
          // dropdownColor: maroonColor,

          style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s),
              ),
          onChanged: onChanged,
          validator: dropDownValidator,
        ),
      ],
    );
  }
}
