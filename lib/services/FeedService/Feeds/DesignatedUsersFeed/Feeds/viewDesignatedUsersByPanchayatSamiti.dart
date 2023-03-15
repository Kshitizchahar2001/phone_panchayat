// ignore_for_file: file_names, unnecessary_this

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/DesignatedUsersFeed/Feeds/allDesignatedUsersFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class ViewDesignatedUsersByPanchayatSamiti
    extends ViewAllVerifiedDesignatedMembersFeed {
  String panchayatSamitiId;
  ViewDesignatedUsersByPanchayatSamiti({@required this.panchayatSamitiId});

  @override
  Future<FeedQueryData> getPosts() async {
    return await Services.gqlQueryService.searchDesignatedUsersByPlaceAndStatus
        .searchDesignatedUsersByPlaceAndStatus(
      identifier_1_id: this.panchayatSamitiId,
      designatedUserStatus: DesignatedUserStatus.VERIFIED,
      nextToken: nextToken,
      // limit: numberOfPostsToFetch,
    );
  }
}
