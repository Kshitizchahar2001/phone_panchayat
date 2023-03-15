// ignore_for_file: prefer_const_constructors_in_immutables, deprecated_member_use, unnecessary_string_interpolations, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_key_in_widget_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/designatedUserDesignation.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/UiDataModels/drawerItem.dart';
import 'package:online_panchayat_flutter/screens/main_screen/logoutDialog.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/DesignatedUserDataNotifier.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

// List drawerItems;
Color drawerItemColor;

class MyCustomDrawer extends StatefulWidget {
  MyCustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  _MyCustomDrawerState createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  User _localUser;
  List drawerItems;
  bool isPremiumUser = false;

  @override
  void initState() {
    _localUser =
        Provider.of<GlobalDataNotifier>(context, listen: false).localUser;

    isPremiumUser = CheckForPremiumUser.isPremiumUser(_localUser);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    drawerItems = [
      DrawerItemModel(
          label: MY_PROFILE,
          leadingIconData: Icons.person,
          params: _localUser,
          route: _localUser.name == null
              ? MyRoutes.registerPromptPage
              : MyRoutes.myProfileRoute),
      DrawerItemModel(
          label: MY_POSTS,
          leadingIconData: Icons.person,
          route: MyRoutes.myPostsRoute,
          params:
              Provider.of<GlobalDataNotifier>(context, listen: false).myFeed),
      // DrawerItemModel(
      //   label: ALERTS,
      //   leadingIconData: Icons.notifications,
      //   route: MyRoutes.alertsRoute,
      // ),
      DrawerItemModel(
        label: SETTINGS,
        leadingIconData: Icons.settings,
        route: MyRoutes.settingsRoute,
      ),
      DrawerItemModel(
        label: HELP_AND_CONTACT,
        route: MyRoutes.helpAndContactPage,
        leadingIconData: Icons.contact_support,
      ),
      DrawerItemModel(
        label: REFER_AND_EARN,
        route: MyRoutes.referAndEarnScreen,
        leadingIconData: Icons.contact_support,
      ),
      DrawerItemModel(
        label: VIEW_ELECTED_MEMBERS,
        route: (Services.globalDataNotifier.localUser.place_1_id != null)
            ? MyRoutes.viewAllDesignatedUsers
            : MyRoutes.selectUserAreaIdentifiers,
        leadingIconData: Icons.person,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    drawerItemColor = Theme.of(context).textTheme.headline1.color;
    String userDesignation = isPremiumUser
        ? "Premium ${_localUser.designation}"
        : "${_localUser.designation}";

    return Drawer(
      child: Container(
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: isPremiumUser
                    ? BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(premium_user_background),
                            fit: BoxFit.fill))
                    : null,
                child: Column(children: [
                  SizedBox(
                    height: context.safePercentHeight * 5,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.close,
                            size: context.safePercentHeight * 5,
                            color:
                                isPremiumUser ? yellowColor : drawerItemColor,
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.safePercentWidth * 4,
                      ),
                      _localUser.image != null
                          ? CircleAvatar(
                              radius: context.safePercentHeight * 5,
                              backgroundColor: Theme.of(context).cardColor,
                              backgroundImage: NetworkImage(_localUser.image),
                            )
                          : Container(),
                      SizedBox(
                        width: context.safePercentWidth * 3,
                      ),
                      _localUser.name == null
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Please_Register,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        fontSize: responsiveFontSize(context,
                                            size: ResponsiveFontSizes.s),
                                        // color: Theme.of(context).cardColor,
                                      ),
                                ).tr(),
                                SizedBox(height: 20.0),
                                CustomButton(
                                  text: Register_Heading,
                                  buttonColor: maroonColor,
                                  textColor: Colors.white,
                                  boxShadow: [],
                                  // autoSize: true,
                                  onPressed: () {
                                    context.vxNav.push(
                                        Uri.parse(MyRoutes.registrationRoute));
                                  },
                                ),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_localUser.name}",
                                  style: drawerTextStyle.copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.m),
                                      fontWeight: FontWeight.bold,
                                      color: isPremiumUser
                                          ? Colors.white
                                          : drawerItemColor),
                                ),
                                Text(
                                  userDesignation,
                                  style: drawerTextStyle.copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                    color: isPremiumUser
                                        ? yellowColor
                                        : drawerItemColor,
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 5,
                  ),
                ]),
              ),
              for (var model in drawerItems)
                DrawerItem(
                  drawerItemModel: model,
                ),
              Consumer<DesignatedUserDataNotifier>(
                builder: (context, designationNotifier, child) {
                  if (designationNotifier.designatedUserModel != null &&
                      designationNotifier.designatedUserModel.status ==
                          DesignatedUserStatus.VERIFIED) {
                    if (designationNotifier.designatedUserModel.designation ==
                        DesignatedUserDesignation.PHONE_PANCHAYAT_MODERATOR) {
                      final model = DrawerItemModel(
                        label: REVIEW_REQUESTS,
                        leadingIconData: Icons.request_page_outlined,
                        route: MyRoutes.reviewRequests,
                      );
                      return DrawerItem(
                        drawerItemModel: model,
                      );
                    } else {
                      final model = DrawerItemModel(
                        label: REVIEW_COMPLAINTS,
                        leadingIconData: Icons.sync_problem_outlined,
                        route: MyRoutes.reviewConstituencyLocalIssues,
                      );
                      return DrawerItem(
                        drawerItemModel: model,
                      );
                    }
                  } else {
                    final model = DrawerItemModel(
                      label: REGISTER_AS_ELECTED_REPRESENTATIVE,
                      leadingIconData: Icons.app_registration_outlined,
                      route: MyRoutes.registerAsElectedRepresentative,
                    );
                    return DrawerItem(
                      drawerItemModel: model,
                    );
                  }
                },
              ),
              DrawerItem(
                drawerItemModel: DrawerItemModel(
                    label: SIGN_OUT,
                    route: MyRoutes.settingsRoute,
                    leadingIconData: Icons.logout,
                    onPressed: () async {
                      print("here");
                      showLogoutDialog(context);
                    }),
              ),
              Divider(
                color: drawerItemColor,
                height: 1.5,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Version  ${RemoteConfigService.info.version} (${RemoteConfigService.info.buildNumber}) ",
                  style: TextStyle(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                      // color: drawerItemColor,
                      color: Theme.of(context).textTheme.headline4.color),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final DrawerItemModel drawerItemModel;
  DrawerItem({this.drawerItemModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (drawerItemModel.onPressed == null) {
          Navigator.of(context).pop();
          if (drawerItemModel.route != null)
            context.vxNav
                .push(Uri.parse(drawerItemModel.route),
                    params: drawerItemModel.params)
                .then((value) {
              // widget.setSreenOnPop
            });
        } else {
          drawerItemModel.onPressed();
        }
      },
      child: Column(
        children: [
          Divider(
            color: drawerItemColor,
            height: 0.8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.safePercentWidth * 3,
                vertical: context.safePercentHeight * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      (drawerItemModel.leadingIconData != null)
                          ? Icon(
                              drawerItemModel.leadingIconData,
                              color: drawerItemColor,
                            )
                          : Image(
                              image: AssetImage(
                                drawerItemModel.leadingImage,
                              ),
                              height: 20,
                            ),
                      SizedBox(
                        width: context.safePercentWidth * 3,
                      ),
                      Flexible(
                        child: Text(
                          drawerItemModel.label,
                          // overflow: TextOverflow.ellipsis,
                          // softWrap: false,
                          style: drawerTextStyle.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s10),
                            color: drawerItemColor,
                          ),
                        ).tr(),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: drawerItemColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
