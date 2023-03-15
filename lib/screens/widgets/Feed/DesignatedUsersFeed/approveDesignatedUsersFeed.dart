// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/Widgets/approveDesignatedUserCard.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:provider/provider.dart';
import 'DesignatedUserData/designatedUserData.dart';
import 'designatedUsersFeed.dart';

class ApproveDesignatedUsersFeed extends DesignatedUsersFeed {
  ApproveDesignatedUsersFeed()
      : super(
          feed: Services
              .globalDataNotifier.designatedUserRegistrationRequestsFeed,
        );

  @override
  Widget getCard(
    GlobalDataNotifier globalDataNotifier,
    int index,
  ) {
    return Consumer<DesignatedUserData>(
      builder: (context, value, child) {
        return ApproveDesignatedUserCard(
          designatedUserData: globalDataNotifier
              .designatedUserDataReservoir[feed.latestListOfPostId()[index]],
        );
      },
    );
  }
}
