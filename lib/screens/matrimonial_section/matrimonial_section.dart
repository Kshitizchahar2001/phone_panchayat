// ignore_for_file: annotate_overrides, deprecated_member_use, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/call_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/incoming_request_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/matches_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonail_intro.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_list.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/sent_request_list_data.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class MatrimonialSection extends StatefulWidget {
  const MatrimonialSection({Key key}) : super(key: key);

  @override
  State<MatrimonialSection> createState() => _MatrimonialSectionState();
}

class _MatrimonialSectionState extends State<MatrimonialSection> {
  void initState() {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "click_matrimonial_button", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "state": Services.globalDataNotifier.localUser.state_place.name_en ??
          Services.globalDataNotifier.localUser.state_place.name_hi ??
          "",
      "district":
          Services.globalDataNotifier.localUser.district_place.name_en ??
              Services.globalDataNotifier.localUser.district_place.name_hi ??
              ""
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CurrentMatrimonailProfileData>(
          builder: (context, value, child) {
        if (!value.isUserLoaded)
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.safePercentWidth * 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  FAILED_TO_LOAD_MATRIMONIAL_PROFILE,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.m)),
                ).tr(),
                SizedBox(
                  height: context.safePercentHeight * 2,
                ),
                ElevatedButton(
                  onPressed: () => value.fetchMatrimonailProfile(),
                  child: Text(
                    RETRY,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s),
                        color: Colors.white),
                  ).tr(),
                  style: ElevatedButton.styleFrom(primary: maroonColor),
                ),
              ],
            ),
          );
        else if (value.isUserRegistered == null) {
          return Center(
            child: CircularProgressIndicator(
              color: maroonColor,
            ),
          );
        } else if (!value.isUserRegistered)
          return MatrimonialIntro();
        else
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<MatchesListData>(
                  create: (_) => MatchesListData(
                      currentProfile: value.currentUserProfile)),
              ChangeNotifierProvider<IncomingRequestListData>(
                  create: (_) => IncomingRequestListData(
                      currentProfile: value.currentUserProfile)),
              ChangeNotifierProvider<SentRequestListData>(
                  create: (_) => SentRequestListData(
                      currentProfile: value.currentUserProfile)),
              ChangeNotifierProvider<CallListData>(
                  create: (_) =>
                      CallListData(currentProfile: value.currentUserProfile)),
            ],
            builder: (context, child) => MatrimonialList(),
          );
      }),
    );
  }
}
