// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/referAndEarnData.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class ClaimTab extends StatelessWidget {
  final ReferAndEarnData referAndEarnData;

  const ClaimTab({
    Key key,
    @required this.referAndEarnData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: getPostWidgetSymmetricPadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: context.safePercentHeight * 30,
              child: Card(
                color: Theme.of(context).cardColor,
                shadowColor: Theme.of(context).shadowColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: getPostWidgetSymmetricPadding(context),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.m),
                        fontWeight: FontWeight.w400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(TOTAL_REWARDS.tr()),
                              flex: 3,
                            ),
                            Expanded(
                                child: Text(
                              referAndEarnData.total.toString(),
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(CLAIMED.tr()),
                              flex: 3,
                            ),
                            Expanded(
                                child: Text(
                              referAndEarnData.claimed.toString(),
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(ON_HOLD.tr()),
                              flex: 3,
                            ),
                            Expanded(
                                child: Text(
                              referAndEarnData.onHold.toString(),
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(BALANCE.tr()),
                              flex: 3,
                            ),
                            Expanded(
                                child: Text(
                              referAndEarnData.balance.toString(),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: context.safePercentHeight * 5,
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              percent: referAndEarnData.percentOfBalanceFromTotal,
              center: Text(
                referAndEarnData.balance.toString(),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
            SizedBox(
              height: context.safePercentHeight * 5,
            ),
            Text(
              CLAIM_REQUIREMENT_TEXT.tr(namedArgs: {
                "value": referAndEarnData.minimumClaimLimit.toString()
              }),
              style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.m),
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: context.safePercentHeight * 5,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: referAndEarnData.raisedClaimRequest,
              builder: (context, value, child) {
                if (value) {
                  return Text(
                    "We received you claim request, we will contact you soon!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  );
                } else
                  return CustomButton(
                    text: CLAIM.tr(),
                    buttonColor: maroonColor,
                    autoSize: true,
                    onPressed: () {
                      referAndEarnData.onCaimed(context);
                    },
                  );
              },
            ),
            SizedBox(
              height: context.safePercentHeight * 5,
            ),
          ],
        ),
      ),
    );
  }
}
