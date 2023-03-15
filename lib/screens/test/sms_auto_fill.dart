// ignore_for_file: deprecated_member_use, curly_braces_in_flow_control_structures, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:easy_localization/easy_localization.dart';

class MyPhoneNumberInput extends StatefulWidget {
  const MyPhoneNumberInput({Key key}) : super(key: key);

  @override
  State<MyPhoneNumberInput> createState() => _MyPhoneNumberInputState();
}

class _MyPhoneNumberInputState extends State<MyPhoneNumberInput> {
  TextEditingController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LabelAndCustomTextField(
          autofocus: true,
          maxLength: 10,
          prefix: Text("+91",
              style: Theme.of(context).textTheme.headline2.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: responsiveFontSize(context,
                      size: ResponsiveFontSizes.s))),
          label: ENTER_PHONE_NO,
          inputType: TextInputType.phone,
          textEditingController: _controller,
          textCapitalization: TextCapitalization.sentences,
          validator: (String value) {
            if (value.length == 10) {
              return null;
            } else
              return INCORRECT_MOBILE_NO.tr();
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
    Future<void>.delayed(
        const Duration(milliseconds: 300), _tryPasteCurrentPhone);
  }

  Future _tryPasteCurrentPhone() async {
    if (!mounted) return;
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      _controller.text = phone;
    } on PlatformException catch (e) {
      print('Failed to get mobile number because of: ${e.message}');
    }
  }
}
