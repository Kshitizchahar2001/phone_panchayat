// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/Widgets/viewDesignatedUserCard.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/DesignatedUsersFeed/Feeds/viewDesignatedUsersByPanchayatSamiti.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'designatedUsersFeed.dart';

class SarpanchFeed extends DesignatedUsersFeed {
  final String panchayatSamitiId;
  SarpanchFeed({@required this.panchayatSamitiId})
      : super(
          feed: ViewDesignatedUsersByPanchayatSamiti(
            panchayatSamitiId: panchayatSamitiId,
          ),
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
