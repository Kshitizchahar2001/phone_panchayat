// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/Widgets/viewDesignatedUserCard.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'designatedUsersFeed.dart';

class ViewDesignatedUsersFeed extends DesignatedUsersFeed {
  ViewDesignatedUsersFeed()
      : super(
          feed:
              Services.globalDataNotifier.viewAllVerifiedDesignatedMembersFeed,
        );

  @override
  Widget getCard(
    GlobalDataNotifier globalDataNotifier,
    int index,
  ) {
    return ViewDesignatedUserCard(
      designatedUserData: globalDataNotifier
          .designatedUserDataReservoir[feed.latestListOfPostId()[index]],
    );
  }
}
