// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/utils/notification_tile.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';


class Alerts extends StatelessWidget {
  bool isDarkTheme = false;
  @override
  Widget build(BuildContext context) {
    isDarkTheme = Provider.of<ThemeProvider>(context).isDarkModeEnabled;
    return Scaffold(
        appBar: getPageAppBar(
          context: context,
          text: ALERTS,
        ),
        body: Consumer<FirebaseMessagingService>(
            builder: (context, messagingService, child) {
          print(messagingService.notificationList.length);
          return ListView.builder(
            itemCount: messagingService.notificationList.length,
            itemBuilder: (context, index) => NotificationTile(
              notification: messagingService.notificationList[index],
              darkMode: isDarkTheme,
              onTileTapped: () {
                // if (messagingService.notificationList[index].readStatus == 0) {
                //   messagingService.markAllNotificationsSeenForRespectivePost(
                //       postId: messagingService.notificationList[index].postId);
                // }
                // context.vxNav.push(
                //     Uri.parse(MyRoutes.singlePostViewMainScreenRoute),
                //     params: messagingService.notificationList[index].postId);
              },
            ),
          );
        }));
  }
}
