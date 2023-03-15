// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures, unused_catch_stack

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/LocalIssueFeed/localIssueData/localIssueData.dart';
import '../../../services.dart';
import '../../multiPageFeed.dart';

abstract class LocalIssuesFeed extends MultiPageFeed {
  LocalIssuesFeed() {
    feedType = FeedType.LocalIssueFeed;
    noDataAvailableMessage = NO_COMPLAINTS_AVAILABLE;
  }

  @override
  Future<void> addNewPostsToTheList() async {
    // int _numberOfPostsFetched = 0;

    updatingPosts = true;
    await getPosts()
        .then((value) => {
              nextToken = value.nextToken,
              value.list.forEach((element) {
                Services.globalDataNotifier.localIssueDataReservoir[
                        (element as LocalIssueData).localIssue.id] =
                    element as LocalIssueData;

                try {
                  if (listOfPostId
                      .contains((element as LocalIssueData).localIssue.id))
                    throw Exception([
                      "One Post was fetched two times",
                      "Error in updatePostListData function"
                    ]);
                  listOfPostId.add((element as LocalIssueData).localIssue.id);
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
