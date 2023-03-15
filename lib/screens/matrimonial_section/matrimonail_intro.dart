// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/custom_fab.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/velocity_x.dart';

class MatrimonialIntro extends StatelessWidget {
  const MatrimonialIntro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: maroonColor,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: context.safePercentHeight * 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  matrimonial_image,
                  width: double.infinity,
                  colorBlendMode: BlendMode.modulate,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: context.safePercentHeight * 3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.safePercentWidth * 6),
                  child: Text(
                    MATRIMONIAL_INTRO_MESSAGE,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.m),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ).tr(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: context.safePercentHeight * 3,
                bottom: context.safePercentHeight * 5.5,
                right: context.safePercentWidth * 3.5,
                left: context.safePercentWidth * 3.5),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFAB(
        onPressed: () {
          AnalyticsService.firebaseAnalytics
              .logEvent(name: "enter_matrimonial_section", parameters: {
            "user_id": Services.globalDataNotifier.localUser.id ?? "",
            "state":
                Services.globalDataNotifier.localUser.state_place.name_en ??
                    Services.globalDataNotifier.localUser.state_place.name_hi ??
                    "",
            "district": Services
                    .globalDataNotifier.localUser.district_place.name_en ??
                Services.globalDataNotifier.localUser.district_place.name_hi ??
                ""
          });
          context.vxNav.push(Uri.parse(MyRoutes.registerInMatrimonial));
        },
        label: REGISTER_NOW,
        icon: Icon(
          Icons.app_registration_rounded,
          color: maroonColor,
          size: responsiveFontSize(context, size: ResponsiveFontSizes.m),
        ),
      ),
    );
  }
}
