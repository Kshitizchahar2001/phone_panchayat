// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures, unused_catch_stack

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/DesignatedUserData/designatedUserData.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import '../../multiPageFeed.dart';

abstract class DesignatedUsersFeed extends MultiPageFeed {
  DesignatedUsersFeed() {
    noDataAvailableMessage = NO_REPRESENTATIVES_AVAILABLE;

    // feedType = FeedType.UserFeed;
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
                  listOfPostId.add(element.id);
                } catch (e, s) {
                  // FirebaseCrashlytics.instance.recordError(e, s);
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
