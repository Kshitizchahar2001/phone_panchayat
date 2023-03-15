// ignore_for_file: file_names

import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/DesignatedUsersFeed/designatedUsersFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class DesignatedUserRegistrationRequestsFeed extends DesignatedUsersFeed {
  @override
  Future<FeedQueryData> getPosts() async {
    return await Services.gqlQueryService.searchDesignatedUsersByPlaceAndStatus
        .searchDesignatedUsersByPlaceAndStatus(
      identifier_1_id: Services.globalDataNotifier.localUser.place_1_id,
      designatedUserStatus: DesignatedUserStatus.UNVERIFIED,
      nextToken: nextToken,
      // limit: numberOfPostsToFetch,
    );
  }
}
