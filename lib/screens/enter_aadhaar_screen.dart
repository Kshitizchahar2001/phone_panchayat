// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_final_fields, unnecessary_new, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/gqlQueryService.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class EnterAadhaarScreen extends StatefulWidget {
  @override
  _EnterAadhaarScreenState createState() => _EnterAadhaarScreenState();
}

class _EnterAadhaarScreenState extends State<EnterAadhaarScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: BuildResponsiveEnterAadhaarScreen(),
      tablet: BuildResponsiveEnterAadhaarScreen(),
      desktop: BuildResponsiveEnterAadhaarScreen(),
    );
    // Scaffold(
    //   backgroundColor: Theme.of(context).colorScheme.background,
    //   body: ,
    // );
  }
}

class BuildResponsiveEnterAadhaarScreen extends StatefulWidget {
  @override
  _BuildResponsiveEnterAadhaarScreenState createState() =>
      _BuildResponsiveEnterAadhaarScreenState();
}

class _BuildResponsiveEnterAadhaarScreenState
    extends State<BuildResponsiveEnterAadhaarScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _blankFocusNode = FocusNode();
  TextEditingController aadharNumberTextEditingController =
      new TextEditingController();
  int numberOfdigitsInAadhaarNumber = 12;
  int numberOfSpacesBetweenDigitsOfAadhaarNumber = 2;
  int maxInputLengthForAadharNumber;
  GQLMutationService _gqlMutationService;
  GlobalDataNotifier _globalDataNotifier;
  GQLQueryService _gqlQueryService;
  FirebaseMessagingService _messagingService;

  @override
  void initState() {
    maxInputLengthForAadharNumber = numberOfdigitsInAadhaarNumber +
        numberOfSpacesBetweenDigitsOfAadhaarNumber;

    super.initState();
  }

  @override
  void dispose() {
    aadharNumberTextEditingController.dispose();
    super.dispose();
  }

  String aadherFieldValidator(String input) {
    if (input.length != maxInputLengthForAadharNumber)
      return INCORRECT_AADHAAR_NUMBER.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _gqlMutationService = Provider.of<GQLMutationService>(context);
    _gqlQueryService = Provider.of<GQLQueryService>(context);
    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    _messagingService =
        Provider.of<FirebaseMessagingService>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: context.safePercentWidth * 8),
      child: Form(
        key: _formKey,
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
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.s)),
            ).tr(),
            ResponsiveHeight(heightRatio: 2),
            CustomTextField(
              inputType: TextInputType.number,
              textEditingController: aadharNumberTextEditingController,
              validator: aadherFieldValidator,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                new CustomInputFormatter(),
                LengthLimitingTextInputFormatter(maxInputLengthForAadharNumber),
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
                  text: SUBMIT,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      showMaterialDialog(context);
                      await _gqlMutationService.updateUser.updateUserAadhaar(
                          messagingService: _messagingService,
                          notifierService: _globalDataNotifier,
                          id: _globalDataNotifier.localUser.id,
                          aadharNumber: aadharNumberTextEditingController.text);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  },
                ),
                SizedBox(
                  width: context.safePercentWidth * 5,
                ),
                DialogBoxButton(
                  text: LATER,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            ResponsiveHeight(heightRatio: 5),
          ],
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
