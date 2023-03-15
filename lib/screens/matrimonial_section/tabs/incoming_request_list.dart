// ignore_for_file: implementation_imports, prefer_const_constructors, annotate_overrides, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/incoming_request_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_card.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';
import 'package:auto_animated/auto_animated.dart';

class IncomingRequestList extends StatefulWidget {
  const IncomingRequestList({Key key}) : super(key: key);

  @override
  State<IncomingRequestList> createState() => _IncomingRequestListState();
}

class _IncomingRequestListState extends State<IncomingRequestList>
    with
        AutomaticKeepAliveClientMixin<IncomingRequestList>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  IncomingRequestListData _incomingRequestListData;
  CurrentMatrimonailProfileData _currentProfile;
  ScrollController _scrollcontroller;

  final listViewAnimationOptions = LiveOptions(
    showItemInterval: Duration(milliseconds: 0),
    showItemDuration: Duration(milliseconds: 100),
    visibleFraction: 0.001,
    reAnimateOnVisibility: false,
  );

  void initState() {
    _scrollcontroller = ScrollController();
    _currentProfile =
        Provider.of<CurrentMatrimonailProfileData>(context, listen: false);

    _incomingRequestListData =
        Provider.of<IncomingRequestListData>(context, listen: false);

    super.initState();
  }

  void dispose() {
    _scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: ListView(
        controller: _scrollcontroller,
        children: [
          // Container(
          //   color: Colors.grey[200],
          //   padding: EdgeInsets.symmetric(
          //       vertical: context.safePercentHeight * 1.5,
          //       horizontal: context.safePercentWidth * 3),
          //   child: Text(
          //     INCOMING_REQUEST,
          //     style: Theme.of(context).textTheme.headline1.copyWith(
          //         fontSize:
          //             responsiveFontSize(context, size: ResponsiveFontSizes.m)),
          //   ).tr(),
          // ),
          Consumer<IncomingRequestListData>(
            builder: (context, value, child) {
              if (value.loading)
                return ListLoadingShimmer();
              else if (value.incomingRequests.isEmpty)
                return SizedBox(
                  height: context.safePercentHeight * 60,
                  child: Center(
                    child: Text(
                      EMPTY_INCOMING_REQUEST,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(
                              context,
                              size: ResponsiveFontSizes.s,
                            ),
                          ),
                    ).tr(),
                  ),
                );

              /// Animated list which comes from package auto_animated
              ///
              return LiveList.options(
                options: listViewAnimationOptions,
                shrinkWrap: true, // 1st add
                physics: ClampingScrollPhysics(),
                itemCount: _incomingRequestListData.incomingRequests.length,

                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index, animation) {
                  return FadeTransition(
                    opacity: Tween<double>(
                      begin: 0,
                      end: 1,
                    ).animate(animation),
                    // And slide transition
                    child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, -0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        // Paste you Widget
                        child: MatrimonialCard(
                          matrimonialProfile: _incomingRequestListData
                              .incomingRequests[index].requesterProfile,
                          currentUserProfile:
                              _currentProfile.currentUserProfile,
                        )),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
