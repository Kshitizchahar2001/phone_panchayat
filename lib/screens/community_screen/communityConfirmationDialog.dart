// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/CasteCommunity.dart';
import 'package:online_panchayat_flutter/screens/community_screen/CommunityScreenData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class CommunityConfirmationDialog extends StatelessWidget {
  final CasteCommunity casteCommunity;
  final GlobalDataNotifier globalDataNotifier;
  final GQLMutationService gqlMutationService;
  final FirebaseMessagingService firebaseMessagingService;
  final CommunityScreenData communityScreenData;

  const CommunityConfirmationDialog(
      {Key key,
      @required this.casteCommunity,
      @required this.globalDataNotifier,
      @required this.gqlMutationService,
      @required this.firebaseMessagingService,
      @required this.communityScreenData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: context.safePercentHeight * 45,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: RemovableWidget(
          onRemoved: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: getPostWidgetSymmetricPadding(context,
                horizontal: 6, vertical: 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      JOIN_COMMUNITY,
                      style: Theme.of(context).textTheme.displayMedium.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.m10),
                          fontWeight: FontWeight.w500),
                    ).tr(),
                    ResponsiveHeight(),
                    // ${casteCommunity?.name}
                    Center(
                      child: Text(
                        casteCommunity?.name?.toString(),
                        style: Theme.of(context).textTheme.headline2.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.m10),
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    ResponsiveHeight(),
                    Text(
                      "${JOIN_COMMUNITY_CONFIRMATION_MESSAGE.tr()} ${JOIN_COMMUNITY_CAUTION.tr()}",
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s),
                          fontWeight: FontWeight.w400),
                    ),

                    ResponsiveHeight(),
                  ],
                ),
                CustomButton(
                    text: JOIN,
                    buttonColor: maroonColor,
                    autoSize: true,
                    onPressed: () async {
                      showMaterialDialog(context);
                      await gqlMutationService.updateUser
                          .updateUserCommunity(
                              notifierService: globalDataNotifier,
                              messagingService: firebaseMessagingService,
                              id: globalDataNotifier.localUser.id,
                              communityId: casteCommunity.id)
                          .then((value) {
                        AnalyticsService.firebaseAnalytics
                            .logEvent(name: "community_joined", parameters: {
                          "communityId": casteCommunity.id,
                        });
                      });

                      communityScreenData.rebuildCommunityScreen();

//await
                      // run mutation to join
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ));
  }
}
