// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors_in_immutables, duplicate_ignore, prefer_const_constructors, deprecated_member_use, curly_braces_in_flow_control_structures, unnecessary_new

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/referAndEarnData.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:share/share.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/services.dart';

class ReferTab extends StatefulWidget {
  final ReferAndEarnData referAndEarnData;
  ReferTab({
    Key key,
    @required this.referAndEarnData,
  }) : super(key: key);

  @override
  _ReferTabState createState() => _ReferTabState();
}

class _ReferTabState extends State<ReferTab> {
  String referralStep1Title;

  String referralStep2Title;

  String referralStep3Title;

  @override
  void initState() {
    referralStep1Title = REFERRAL_STEP_1.tr();
    referralStep2Title = REFERRAL_STEP_2.tr();
    referralStep3Title = REFERRAL_STEP_3.tr();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: getPostWidgetSymmetricPadding(context),
      children: [
        Stepper(
          physics: NeverScrollableScrollPhysics(),
          currentStep: 0,
          type: StepperType.vertical,
          controlsBuilder:
              (BuildContext context, ControlsDetails controlsDetails) =>
                  Container(),
          steps: [
            Step(
              title: Text(referralStep1Title,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                      fontWeight: FontWeight.w400)),
              content: Container(),
              isActive: true,
            ),
            Step(
              title: Text(
                referralStep2Title,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                      fontWeight: FontWeight.w400,
                    ),
              ),
              content: Container(),
              isActive: true,
            ),
            Step(
              title: Text(referralStep3Title,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                      fontWeight: FontWeight.w400)),
              content: Container(),
              isActive: true,
            ),
          ],
        ),
        SizedBox(
          height: context.safePercentHeight * 5,
        ),
        FutureBuilder<String>(
          future: widget.referAndEarnData.getMyReferralLink(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (!snapshot.hasData)
              return Text("Could not get your custom referral link",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s),
                        color: maroonColor,
                        fontWeight: FontWeight.w400,
                      ));
            else
              return Column(
                children: [
                  Padding(
                    padding: getPostWidgetSymmetricPadding(
                      context,
                      vertical: 0.2,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          // flex: 4,
                          child: Text(
                            snapshot.data,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline2.copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                      color: Colors.green,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: () async {
                              Clipboard.setData(
                                      new ClipboardData(text: snapshot.data))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("link copied to clipboard")));
                              });
                            },
                            child: Icon(
                              Icons.copy,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 5,
                  ),
                  CustomButton(
                    text: SHARE_VIA_WHATSAPP.tr(),
                    buttonColor: maroonColor,
                    autoSize: true,
                    onPressed: () {
                      Share.share(
                        referralSentence + snapshot.data,
                      );
                    },
                  ),
                ],
              );
          },
        )
      ],
    );
  }
}
