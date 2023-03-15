// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/loading.dart';
import 'package:online_panchayat_flutter/screens/user_profile_screen/user_profile_data.dart';
import 'package:online_panchayat_flutter/screens/user_profile_screen/user_profile_header.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/postFeed.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final User user;
  Profile({this.user});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalDataNotifier _globalDataNotifier;

  @override
  void initState() {
    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    print("here id is ${widget.user.id}");
    _globalDataNotifier.userFeed.uniqueId = widget.user.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).cardColor,
      // resizeToAvoidBottomInset: false,
      appBar: getPageAppBar(
        context: context,
        text: widget.user.name,
      ),

      body: Column(
        children: [
          Flexible(
            child: Responsive(
              mobile: ResponsiveProfile(
                user: widget.user,
                globalDataNotifier: _globalDataNotifier,
              ),
              tablet: ResponsiveProfile(
                user: widget.user,
                globalDataNotifier: _globalDataNotifier,
              ),
              desktop: ResponsiveProfile(
                user: widget.user,
                globalDataNotifier: _globalDataNotifier,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _globalDataNotifier.userFeed.listOfPostId = [];
    super.dispose();
  }
}

class ResponsiveProfile extends StatelessWidget {
  final User user;
  final GlobalDataNotifier globalDataNotifier;
  ResponsiveProfile({this.user, this.globalDataNotifier});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfileData>(
      builder: (context, child) {
        return Consumer<UserProfileData>(
          builder: (context, value, child) {
            if (value.isLoading)
              return Center(
                child: Loading(),
              );
            else if (value.isProfileOwnerFollowedByProfileVisitor != null)
              return PostFeed(
                feed: globalDataNotifier.userFeed,
                child: UserProfileHeader(
                  user: user,
                  globalDataNotifier: globalDataNotifier,
                  userProfileData: value,
                ),
              );
            else
              return Center(
                child: Padding(
                  padding: getPostWidgetSymmetricPadding(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Error while getting user details",
                          style: Theme.of(context).textTheme.headline2.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: responsiveFontSize(context,
                                    size: ResponsiveFontSizes.m),
                              )),
                      SizedBox(
                        height: 100,
                      ),
                      CustomButton(
                        text: "Try Again",
                        autoSize: true,
                        buttonColor: maroonColor,
                        onPressed: value.tryAgain,
                      )
                    ],
                  ),
                ),
              );
          },
        );
      },
      create: (_) => UserProfileData(
        profileOwner: user,
        profileVisitor: globalDataNotifier.localUser,
      ),
    );
  }
}
