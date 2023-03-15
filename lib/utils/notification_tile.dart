// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/notificationModel.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:velocity_x/velocity_x.dart';
import 'customResponsiveValues.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final void Function() onTileTapped;
  final bool darkMode;
  const NotificationTile(
      {Key key, @required this.notification, @required this.darkMode,@required this.onTileTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (notification.eventType) {
      case NOTIFICATION_EVENT_TYPE_COMMENT:
        return Column(children: [
      CommentNotificationListTile(notification: notification,onTileTapped: onTileTapped,),
      buildCustomDivider(context),
    ]);
        break;
      case NOTIFICATION_EVENT_TYPE_REACTION:
        return Column(children: [
     ReactionNotificationListTile(notification: notification,onTileTapped: onTileTapped,),
      buildCustomDivider(context),
    ]);
        break;
      default:
      return Container();
    }
    
  }

  Divider buildCustomDivider(BuildContext context) {
    return Divider(
      color: KThemeLightGrey,
      height: 1,
      indent: context.safePercentWidth * 4,
      endIndent: context.safePercentWidth * 4,
    );
  }
}

class CommentNotificationListTile extends StatelessWidget {
  const CommentNotificationListTile({
    Key key,
    @required this.notification,@required this.onTileTapped,
  }) : super(key: key);

  final NotificationModel notification;
  final void Function() onTileTapped;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTileTapped, 
      tileColor: Theme.of(context).cardColor,
      contentPadding: getPostWidgetSymmetricPadding(context, vertical: 1),
      leading: CircleAvatar(
        radius: context.safePercentHeight * 3.2,
        backgroundColor: Colors.grey[400],
        foregroundImage: NetworkImage(notification.userImage),
      ),
      title: Container(
        padding:
            getPostWidgetSymmetricPadding(context, vertical: 1, horizontal: 0),
        child: Text(
          '${notification.userName} '+ COMMENTED_ON_YOUR_PANCHAYAT.tr(),
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontWeight: FontWeight.normal,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s),
              ),
        ),
      ),
      subtitle: Container(
        padding: getPostWidgetSymmetricPadding(context, vertical: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color:notification.readStatus==1?KThemeLightGrey:  Theme.of(context).accentColor)),
        child: Text(
          '${notification.postContent}....',
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontWeight: FontWeight.normal,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s),
              ),
        ),
      ),
    );
  }
}

class ReactionNotificationListTile extends StatelessWidget {
  const ReactionNotificationListTile({
    Key key,
    @required this.notification,@required this.onTileTapped,
  }) : super(key: key);

  final NotificationModel notification;
  final void Function() onTileTapped;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTileTapped,
      tileColor: Theme.of(context).cardColor,
      contentPadding: getPostWidgetSymmetricPadding(context, vertical: 1),
      leading: CircleAvatar(
        radius: context.safePercentHeight * 3.2,
        backgroundColor: Colors.grey[400],
        foregroundImage: NetworkImage(notification.userImage),
      ),
      title: Container(
        padding:
            getPostWidgetSymmetricPadding(context, vertical: 1, horizontal: 0),
        child: Text(
          '${notification.userName} '+REACTED_TO_YOUR_PANCHAYAT.tr(),
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontWeight: FontWeight.normal,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s),
              ),
        ),
      ),
      subtitle: Container(
        padding: getPostWidgetSymmetricPadding(context, vertical: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color:notification.readStatus==1?KThemeLightGrey: Theme.of(context).accentColor)),
        child: Text(
          '${notification.postContent}....',
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontWeight: FontWeight.normal,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s),
              ),
        ),
      ),
    );
  }
}
