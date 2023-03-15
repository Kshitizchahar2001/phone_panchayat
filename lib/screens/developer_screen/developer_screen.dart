// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/screens/test/generate_test_notification.dart';
import 'package:online_panchayat_flutter/screens/widgets/banner/Data/banner_post_data.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/Data/suppressedUrl.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceService.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/tourDataStorage.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/userDataStorage.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/getPageAppBar.dart';
import 'package:online_panchayat_flutter/utils/showSnackbar.dart';
import 'package:velocity_x/velocity_x.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: getPageAppBar(
        context: context,
        text: "Developer options",
        elevation: 1,
      ),
      body: ListView(
        children: [
          DeveloperOptionTile(
            title: 'Edit banner',
            function: () {
              String not_an_administrator =
                  "Sorry! You are not the administrator";
              if (Services.bannerPostData != null) {
                BannerPostData _postData = Services.bannerPostData;
                if (_postData.isPostOwnedByLoggedInUserOrAdministrator()) {
                  context.vxNav
                      .push(Uri.parse(MyRoutes.createPostRoute), params: {
                    "postData": _postData,
                  });
                } else
                  showSnackbar(context, not_an_administrator);
              } else
                showSnackbar(context, not_an_administrator);
            },
          ),
          DeveloperOptionTile(
            title: 'Test notification',
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GenerateTextNotification();
                  },
                ),
              );
            },
          ),
          DeveloperOptionTile(
            title: 'Clear shared preference',
            function: () async {
              await SharedPreferenceService.sharedPreferences.clear();
              showSnackbar(context, 'Cleared shared preference');
            },
          ),
          DeveloperOptionTile(
            title: 'Get Tour',
            function: () async {
              TourDataStorage.clearAllTourData();
              showSnackbar(
                  context, 'You will get a tour after reopening the app.');
            },
          ),
          DeveloperOptionTile(
            title: 'Put Suppressed Url Storage data',
            function: () async {
              await StoreGlobalData.suppressedUrlStorage.setData(
                SuppressedUrl(
                  name: null,
                  url:
                      'https://stackoverflow.com/questions/57886661/passing-generic-type-by-functiont-in-flutter',
                  showWebPage: true,
                ),
              );
              showSnackbar(context, 'Dummy data put in Suppressed Url Storage');
            },
          ),
          DeveloperOptionTile(
            title: 'Clear local user data',
            function: () async {
              await UserDataStorage.deleteAllStoredUserData();

              showSnackbar(context, 'User data cleared');
            },
          ),
        ],
      ),
    );
  }
}

class DeveloperOptionTile extends StatefulWidget {
  final String title;
  final Function function;
  const DeveloperOptionTile({Key key, this.title, this.function})
      : super(key: key);

  @override
  State<DeveloperOptionTile> createState() => _DeveloperOptionTileState();
}

class _DeveloperOptionTileState extends State<DeveloperOptionTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.title.toString(),
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
          ),
          trailing: Icon(
            FontAwesomeIcons.chevronRight,
            color: Theme.of(context).textTheme.headline1.color,
          ),
          onTap: widget.function,
        ),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
