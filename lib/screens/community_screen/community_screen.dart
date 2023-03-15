// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/CasteCommunity.dart';
import 'package:online_panchayat_flutter/screens/community_screen/CommunityScreenData.dart';
import 'package:online_panchayat_flutter/screens/community_screen/communityTile.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/postFeed.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/gqlQueryService.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../loading.dart';
import 'communityConfirmationDialog.dart';

class CommunityScreen extends StatefulWidget {
  final GlobalDataNotifier globalDataNotifier;
  final CommunityScreenData communityScreenData;
  CommunityScreen({
    @required this.globalDataNotifier,
    @required this.communityScreenData,
  });
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  GQLQueryService _gqlQueryService;
  @override
  void initState() {
    _gqlQueryService = Provider.of<GQLQueryService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.globalDataNotifier.localUser.community?.id != null)
      return PostFeed(
        feed: widget.globalDataNotifier.communityFeed,
      );
    else if (widget.communityScreenData.listOfCommunitys != null)
      return JoinCommunity(
        listOfCommunitys: widget.communityScreenData.listOfCommunitys,
      );
    else
      return FutureBuilder<List<CasteCommunity>>(
        future: widget.communityScreenData.getListOfCastCommunitys(
          gqlQueryService: _gqlQueryService,
          pincode: widget.globalDataNotifier.localUser.pincode,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            // return Container();
            return Loading();
          else
            return
                // Container();
                JoinCommunity(
              listOfCommunitys: snapshot.data,
            );
        },
      );
  }
}

class JoinCommunity extends StatefulWidget {
  final List<CasteCommunity> listOfCommunitys;
  const JoinCommunity({Key key, @required this.listOfCommunitys})
      : super(key: key);

  @override
  _JoinCommunityState createState() => _JoinCommunityState();
}

class _JoinCommunityState extends State<JoinCommunity> {
  GlobalDataNotifier _globalDataNotifier;
  GQLMutationService _gqlMutationService;
  FirebaseMessagingService _firebaseMessagingService;
  CommunityScreenData _communityScreenData;

  @override
  void initState() {
    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    _gqlMutationService =
        Provider.of<GQLMutationService>(context, listen: false);
    _firebaseMessagingService =
        Provider.of<FirebaseMessagingService>(context, listen: false);
    _communityScreenData =
        Provider.of<CommunityScreenData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding:
            getPostWidgetSymmetricPadding(context, horizontal: 3, vertical: 0),
        child: ListView(padding: EdgeInsets.only(top: 15), children: <Widget>[
          Text(
            JOIN_COMMUNITY,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.l),
                fontWeight: FontWeight.w500),
          ).tr(),
          ResponsiveHeight(
            heightRatio: 1,
          ),
          Text(
            JOIN_COMMUNITY_DESCRIPTION,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s10),
                fontWeight: FontWeight.normal),
          ).tr(),
          ResponsiveHeight(
            heightRatio: 1,
          ),
          ListView.builder(
            shrinkWrap: true, // 1st add
            physics: ClampingScrollPhysics(),
            itemCount: widget.listOfCommunitys.length,
            padding: EdgeInsets.only(top: 10),
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Material(
                        type: MaterialType.transparency,
                        child: Center(
                          child: Padding(
                            padding: getPostWidgetSymmetricPadding(context,
                                horizontal: 8),
                            child: CommunityConfirmationDialog(
                              casteCommunity: widget.listOfCommunitys[index],
                              firebaseMessagingService:
                                  _firebaseMessagingService,
                              globalDataNotifier: _globalDataNotifier,
                              gqlMutationService: _gqlMutationService,
                              communityScreenData: _communityScreenData,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: CommunityTile(
                    casteCommunity: widget.listOfCommunitys[index],
                  ));
            },
          )
        ]),
      ),
    );
    // );
  }
}
