// ignore_for_file: prefer_final_fields, avoid_print, prefer_const_constructors, deprecated_member_use, curly_braces_in_flow_control_structures, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/constants.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

import 'RegistrationScreen/labelAndCustomTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key key,
  }) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textEditingController;
  final _formKey = GlobalKey<FormState>();
  FocusNode _blankFocusNode = FocusNode();
  String readPhoneNumber;

  @override
  void initState() {
    textEditingController = TextEditingController();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Future<void>.delayed(
    //       const Duration(milliseconds: 300), _tryPasteCurrentPhone);
    // });
    super.initState();

    SchedulerBinding.instance
        .addPostFrameCallback((_) => _tryPasteCurrentPhone());
  }

  Future _tryPasteCurrentPhone() async {
    if (!mounted) return;
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      readPhoneNumber = phone.substring(phone.length - 10);
      textEditingController.text = readPhoneNumber;
      submitPhoneNumber();
    } on PlatformException catch (e) {
      print('Failed to get mobile number because of: ${e.message}');
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  switchLocale() {
    if (EasyLocalization.of(context).currentLocale.toString() == 'hi') {
      context.setLocale(Locale('en', 'US'));
    } else {
      context.setLocale(Locale('hi'));
    }
    Provider.of<AuthStatusNotifier>(context, listen: false).rebuildRoot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                                  heading: LOGIN_LOWERCASE,
                                  subheading: ENTER_PHONE_NO,
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
                    text: LOGIN_UPPERCASE,
                    buttonColor: maroonColor,
                    autoSize: true,
                    onPressed: submitPhoneNumber,
                    // ignore: prefer_const_literals_to_create_immutables
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
          name: "enter_mobile_number",
          parameters: {"mobile_number": "+91${textEditingController.text}"});

      if (textEditingController.text == readPhoneNumber) {
        // skip otp verification
        print('read phone number is $readPhoneNumber');
        await StoreGlobalData.guestUserId.set("+91${readPhoneNumber}");
        await Provider.of<AuthenticationService>(context, listen: false)
            .initialiseAuthenticationService();
        Provider.of<AuthStatusNotifier>(context, listen: false).rebuildRoot();
        AnalyticsService().registerGuestSignInEvent();
      } else {
        // verify otp
        context.vxNav.push(Uri.parse(MyRoutes.signInOtpRoute),
            params: "+91${textEditingController.text}");
      }
    }
  }
}
