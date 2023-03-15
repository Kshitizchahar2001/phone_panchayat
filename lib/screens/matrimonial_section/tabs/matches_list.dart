// ignore_for_file: implementation_imports, prefer_const_constructors, annotate_overrides, deprecated_member_use, curly_braces_in_flow_control_structures

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/helperClasses/MatrimonialHelper.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/matches_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_card.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/profile_complete_dialog.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({Key key}) : super(key: key);

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList>
    with
        AutomaticKeepAliveClientMixin<MatchesList>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  MatchesListData _matchesListData;
  CurrentMatrimonailProfileData _currentProfile;
  ScrollController _scrollcontroller;
  bool isLoadingData = false;

  final listViewAnimationOptions = LiveOptions(
    showItemInterval: Duration(milliseconds: 0),
    showItemDuration: Duration(milliseconds: 100),
    visibleFraction: 0.001,
    reAnimateOnVisibility: false,
  );

  void initState() {
    _scrollcontroller = ScrollController();
    _scrollcontroller.addListener(pagination);
    _currentProfile =
        Provider.of<CurrentMatrimonailProfileData>(context, listen: false);

    _matchesListData = Provider.of<MatchesListData>(context, listen: false);

    super.initState();

    if (_currentProfile != null &&
        _currentProfile.currentProfilePercentage < 100) {
      SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (context) => ProfileCompleteDialog(
              currentProfile: _currentProfile.currentUserProfile)));
    }
  }

  void dispose() {
    _scrollcontroller.removeListener(pagination);
    _scrollcontroller.dispose();
    super.dispose();
  }

  void pagination() async {
    if ((_scrollcontroller.position.pixels ==
            _scrollcontroller.position.maxScrollExtent) &&
        (_matchesListData.nextToken != null)) {
      setState(() {
        isLoadingData = true;
      });
      await _matchesListData.getMatchesList();
      setState(() {
        isLoadingData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: ListView(
        controller: _scrollcontroller,
        children: [
          /// Top card with buttons to fill details
          InkWell(
            onTap: () async {
              context.vxNav.push(Uri.parse(MyRoutes.individualMatch), params: [
                _currentProfile.getMatrimonialProfile,
                null,
                null,
                null
              ]);
            },
            child: TopProfileHeader(currentProfile: _currentProfile),
          ),
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(
                vertical: context.safePercentHeight * 1.5,
                horizontal: context.safePercentWidth * 3),
            child: Text(
              MATCH_LIST,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.m)),
            ).tr(),
          ),
          Consumer<MatchesListData>(
            builder: (context, value, child) {
              if (value.loading)
                return ListLoadingShimmer();
              else if (value.matches.isEmpty)
                return SizedBox(
                  height: context.safePercentHeight * 60,
                  child: Center(
                    child: Text(
                      NO_MATCH_FOUND,
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
                itemCount: _matchesListData.matches.length,

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
                          matrimonialProfile: _matchesListData.matches[index],
                          currentUserProfile:
                              _currentProfile.currentUserProfile,
                        )),
                  );
                },
              );
            },
          ),
          if (isLoadingData) ...[
            SizedBox(height: context.safePercentHeight * 3),
            SizedBox(
              height: context.safePercentHeight * 5,
              child: Center(
                child: CircularProgressIndicator(
                  color: maroonColor,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class TopProfileHeader extends StatelessWidget {
  const TopProfileHeader({
    Key key,
    @required CurrentMatrimonailProfileData currentProfile,
  })  : _currentProfile = currentProfile,
        super(key: key);

  final CurrentMatrimonailProfileData _currentProfile;

  @override
  Widget build(BuildContext context) {
    final String profileImage = MatrimonialHelper.getProfileImage(
        currentProfile: _currentProfile.currentUserProfile);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.safePercentWidth * 2,
          vertical: context.safePercentHeight * 1),
      child: Row(
        children: [
          SizedBox(
            width: context.safePercentWidth * 1,
          ),

          /// Image
          ///
          InkWell(onTap: () {
            context.vxNav
                .push(Uri.parse(MyRoutes.matrimonialProfileImageChange));
          }, child: Builder(
            builder: (context) {
              return Stack(
                children: [
                  CircularPercentIndicator(
                    startAngle: 180,
                    progressColor: maroonColor,
                    backgroundColor: maroonColor.withOpacity(0.4),
                    percent: _currentProfile.currentProfilePercentage / 100,
                    lineWidth: 5.0,
                    animation: true,
                    radius: context.safePercentHeight * 14,
                    center: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: context.safePercentHeight * 6,
                      child: CircleAvatar(
                        backgroundColor: lightGreySubheading,
                        radius: context.safePercentHeight * 6,
                        backgroundImage:
                            Image.network(profileImage, fit: BoxFit.cover)
                                .image,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                          color: maroonColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 0.2,
                            color: Colors.blue,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.camera,
                          color: Colors.white,
                          // color: Colors.green,
                          size: 18,
                        ),
                      ),
                    ),
                    bottom: 0.0,
                    right: 10.0,
                  ),
                ],
              );
            },
          )),
          SizedBox(
            width: context.safePercentWidth * 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: context.safePercentHeight * 1.2,
              ),
              Text(
                "Welcome ${_currentProfile.currentUserProfile?.name ?? ""}",
                style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.m)),
              ),
              SizedBox(
                height: context.safePercentHeight * 0.6,
              ),
              if (_currentProfile.currentProfilePercentage < 100) ...[
                Text(
                  COMPLETE_PROFILE.tr() +
                      "${_currentProfile.currentProfilePercentage}%",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                      color: maroonColor),
                ),
              ],
              SizedBox(
                height: context.safePercentHeight * 0.8,
              ),
              Row(
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        side: BorderSide(color: maroonColor)),
                    onPressed: () async {
                      context.vxNav.push(
                          Uri.parse(MyRoutes.updateMatrimonialProfile),
                          params: _currentProfile.getMatrimonialProfile);
                    },
                    icon: Icon(
                      Icons.person_add_alt,
                      size: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                    ),
                    label: Text(
                      PROFILE,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                  ),
                  SizedBox(
                    width: context.safePercentWidth * 5,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Firebase analytics
                      AnalyticsService.firebaseAnalytics
                          .logEvent(name: "matrimonial_share", parameters: {
                        "user_id":
                            Services.globalDataNotifier.localUser.id ?? "",
                      });
                      context.vxNav
                          .push(Uri.parse(MyRoutes.shareMatrimonialPlan));
                    },
                    style: TextButton.styleFrom(
                        side: BorderSide(color: maroonColor)),
                    icon: Icon(Icons.send,
                        size: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                    label: Text(
                      SHARE,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
