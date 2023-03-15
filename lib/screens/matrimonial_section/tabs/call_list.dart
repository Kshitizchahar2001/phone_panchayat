// ignore_for_file: implementation_imports, prefer_const_constructors, annotate_overrides, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/call_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_card.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';
import 'package:auto_animated/auto_animated.dart';

class CallList extends StatefulWidget {
  const CallList({Key key}) : super(key: key);

  @override
  State<CallList> createState() => _CallListState();
}

class _CallListState extends State<CallList>
    with
        AutomaticKeepAliveClientMixin<CallList>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  CallListData _callListData;
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

    _callListData = Provider.of<CallListData>(context, listen: false);

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
          Consumer<CallListData>(
            builder: (context, value, child) {
              if (value.loading)
                return ListLoadingShimmer();
              else if (value.allContacts.isEmpty)
                return SizedBox(
                  height: context.safePercentHeight * 60,
                  child: Center(
                    child: Text(
                      CALL_LIST_EMPTY,
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
              return ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  LiveList.options(
                    options: listViewAnimationOptions,
                    shrinkWrap: true, // 1st add
                    physics: ClampingScrollPhysics(),
                    itemCount: _callListData.incomingRequests.length,
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
                              matrimonialProfile: _callListData
                                  .incomingRequests[index].requesterProfile,
                              currentUserProfile:
                                  _currentProfile.currentUserProfile,
                            )),
                      );
                    },
                  ),
                  LiveList.options(
                    options: listViewAnimationOptions,
                    shrinkWrap: true, // 1st add
                    physics: ClampingScrollPhysics(),
                    itemCount: _callListData.sentRequests.length,

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
                              matrimonialProfile: _callListData
                                  .sentRequests[index].responderProfile,
                              currentUserProfile:
                                  _currentProfile.currentUserProfile,
                            )),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
