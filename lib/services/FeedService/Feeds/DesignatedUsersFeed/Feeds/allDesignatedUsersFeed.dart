// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/enum/designatedUserDesignation.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/DesignatedUserData/designatedUserData.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/DesignatedUsersFeed/designatedUsersFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class ViewAllVerifiedDesignatedMembersFeed extends DesignatedUsersFeed {
  @override
  Future<FeedQueryData> getPosts() async {
    return await Services.gqlQueryService.searchDesignatedUsersByPlaceAndStatus
        .searchDesignatedUsersByPlaceAndStatus(
      identifier_1_id: Services.globalDataNotifier.localUser.place_1_id,
      designatedUserStatus: DesignatedUserStatus.VERIFIED,
      nextToken: nextToken,
      // limit: numberOfPostsToFetch,
    );
  }

  @override
  Future<void> addNewPostsToTheList() async {
    // int _numberOfPostsFetched = 0;

    updatingPosts = true;
    await getPosts()
        .then((value) => {
              nextToken = value.nextToken,
              value.list.forEach((element) {
                DesignatedUserData designatedUserData = DesignatedUserData(
                    designatedUser: element,
                    version: value.postVersion[element.id]);
                Services.globalDataNotifier
                        .designatedUserDataReservoir[element.id] =
                    designatedUserData;

                try {
                  if (listOfPostId.contains(element.id))
                    throw Exception([
                      "One Post was fetched two times",
                      "Error in updatePostListData function"
                    ]);
                  if (designatedUserData.designatedUser.designation !=
                      DesignatedUserDesignation.PHONE_PANCHAYAT_MODERATOR)
                    listOfPostId.add(element.id);
                } catch (e, s) {
                  FirebaseCrashlytics.instance.recordError(e, s);
                }
              }),
              listOfPostId = [
                ...{...listOfPostId},
              ],
              if (nextToken == lastNextTokenEqualToNull) hasMoreData = false,
              notifyListeners(),
            })
        .onError((error, stackTrace) =>
            {FirebaseCrashlytics.instance.recordError(error, stackTrace)});
    updatingPosts = false;
  }
}
