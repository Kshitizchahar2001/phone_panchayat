// ignore_for_file: file_names, prefer_final_fields, prefer_const_constructors, deprecated_member_use, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  final String phoneNumber;
  const VerifyPhoneNumberScreen({
    Key key,
    @required this.phoneNumber,
  }) : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  TextEditingController textEditingController;
  final _formKey = GlobalKey<FormState>();
  FocusNode _blankFocusNode = FocusNode();
  String _trimmedPhoneNumber;

  @override
  void initState() {
    _trimmedPhoneNumber = widget.phoneNumber?.substring(3);
    textEditingController = TextEditingController(
      text: _trimmedPhoneNumber ?? "",
    );
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusScope.of(context).requestFocus(_blankFocusNode);
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.safePercentWidth * 8),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: context.safePercentHeight * 8,
                                ),
                                HeadingAndSubheading(
                                  heading: "कृपया फ़ोन नंबर वेरीफाई करें",
                                  // subheading: "",
                                ),
                                SizedBox(
                                  height: context.safePercentHeight * 7,
                                ),
                                LabelAndCustomTextField(
                                  autofocus: true,
                                  maxLength: 10,
                                  prefix: Text("+91",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontSize: responsiveFontSize(
                                                  context,
                                                  size:
                                                      ResponsiveFontSizes.s))),
                                  label: ENTER_PHONE_NO,
                                  inputType: TextInputType.phone,
                                  textEditingController: textEditingController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (String value) {
                                    if (value.length == 10) {
                                      return null;
                                    } else
                                      return INCORRECT_MOBILE_NO.tr();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12.0,
                ),
                child: Center(
                  child: CustomButton(
                    text: "ओटीपी भेजे",
                    buttonColor: maroonColor,
                    autoSize: true,
                    onPressed: submitPhoneNumber,
                    boxShadow: [],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submitPhoneNumber() async {
    if (_formKey.currentState.validate()) {
      AnalyticsService.firebaseAnalytics.logEvent(
          name: "verify_mobile_number",
          parameters: {"mobile_number": "+91${textEditingController.text}"});

      context.vxNav.push(Uri.parse(MyRoutes.writeOperationVerificationOtpRoute),
          params: "+91${textEditingController.text}");
    }
  }
}
