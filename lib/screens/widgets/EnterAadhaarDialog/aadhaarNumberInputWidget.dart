// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, deprecated_member_use, unnecessary_new, prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';

class AadhaarNumberInputWidget extends StatefulWidget {
  final TextEditingController aadharNumberTextEditingController;
  final PageController pageController;

  AadhaarNumberInputWidget({
    this.aadharNumberTextEditingController,
    this.pageController,
  });

  @override
  _AadhaarNumberInputWidgetState createState() =>
      _AadhaarNumberInputWidgetState();
}

class _AadhaarNumberInputWidgetState extends State<AadhaarNumberInputWidget> {
  final int numberOfdigitsInAadhaarNumber = 12;
  final int numberOfSpacesBetweenDigitsOfAadhaarNumber = 2;
  int maxInputLengthForAadharNumber;
  final FocusNode _focusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  String aadherFieldValidator(String input) {
    if (input.length != maxInputLengthForAadharNumber)
      return INCORRECT_AADHAAR_NUMBER.tr();
    return null;
  }

  @override
  void initState() {
    maxInputLengthForAadharNumber = numberOfdigitsInAadhaarNumber +
        numberOfSpacesBetweenDigitsOfAadhaarNumber;
    widget.pageController.addListener(() {
      if (_focusNode.hasFocus) _focusNode.unfocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.safePercentWidth * 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveHeight(heightRatio: 4),
              HeadingAndSubheading(
                heading: AADHAR_NUMBER,
                subheading: ENTER_AADHAR_NUMBER_DESCRIPTION,
              ),
              ResponsiveHeight(heightRatio: 8),
              Text(
                AADHAR_NUMBER,
                style: Theme.of(context).textTheme.headline3.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.s)),
              ).tr(),
              ResponsiveHeight(heightRatio: 2),
              CustomTextField(
                focusNode: _focusNode,
                inputType: TextInputType.number,
                textEditingController: widget.aadharNumberTextEditingController,
                validator: aadherFieldValidator,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  new CustomInputFormatter(),
                  LengthLimitingTextInputFormatter(
                      maxInputLengthForAadharNumber),
                ],
              ),
              ResponsiveHeight(
                heightRatio: 2,
              ),
              Text(
                WE_MAY_VERIFY_YOUR_ADDHAR_LATER,
                style: Theme.of(context).textTheme.headline3.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.xs10)),
              ).tr(),
              ResponsiveHeight(heightRatio: 5),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogBoxButton(
                    text: LATER,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    width: context.safePercentWidth * 5,
                  ),
                  DialogBoxButton(
                    text: SUBMIT,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        widget.pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      }
                    },
                  ),
                ],
              ),
              ResponsiveHeight(heightRatio: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
