// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/otp_screen/Data/otpVerification.dart';
import 'package:online_panchayat_flutter/screens/widgets/otp/pin_entry_field.dart';
import 'package:online_panchayat_flutter/screens/widgets/otp/pin_entry_style.dart';
import '../../../constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class OtpScreen extends StatefulWidget {
  final OtpVerificationData otpVerificationData;
  OtpScreen({@required this.otpVerificationData});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();

  textControllerListener() {
    if (textEditingController.text.length == 4) {
      widget.otpVerificationData.verifyOtp(
        otp: textEditingController.text,
        context: context,
      );
      textEditingController.removeListener(textControllerListener);
    }
  }

  @override
  void initState() {
    textEditingController.addListener(textControllerListener);
    widget.otpVerificationData.initiateSignIn();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.removeListener(textControllerListener);
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Getting screen height width
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.safePercentHeight * 5,
                    ),
                    HeadingAndSubheading(
                      heading: OTP_VERIFICATION,
                      subheading:
                          "$ENTER_VERIFICATION_CODE_SENT_TO_YOUR_NUMBER",
                    ),
                    Text(
                      widget.otpVerificationData.phoneNo.toString(),
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ),
                    SizedBox(
                      height: context.safePercentHeight * 10,
                    ),
                    PinEntryField(
                      textEditingController: textEditingController,
                      fieldStyle: PinEntryStyle(
                        textStyle: TextStyle(
                          color: KThemeLightGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                        fieldBackgroundColor: Colors.white,
                        fieldBorder: Border.all(
                          color: Theme.of(context).shadowColor,
                          width: 2,
                        ),
                        fieldBorderRadius: BorderRadius.circular(5),
                        fieldPadding: context.safePercentWidth * 10,
                      ),
                      fieldCount: 4,
                      fieldWidth: context.safePercentWidth * 10,
                      onSubmit: (text) {},
                    ),
                    SizedBox(
                      height: context.safePercentHeight * 5,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          RESEND_OTP,
                          style: Theme.of(context).textTheme.headline2.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s)),
                        ).tr(),
                      ),
                    ),
                    SizedBox(
                      height: context.safePercentHeight * 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 12.0,
              ),
              child: CustomButton(
                text: VERIFY,
                buttonColor: maroonColor,
                autoSize: true,
                boxShadow: [],
                onPressed: () {
                  if (textEditingController.text.length == 4)
                    widget.otpVerificationData.verifyOtp(
                      otp: textEditingController.text,
                      context: context,
                    );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
