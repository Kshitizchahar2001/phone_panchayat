// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures, unused_catch_stack, unnecessary_cast, annotate_overrides

import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'feedPageController.dart';

abstract class Feed extends FeedPageController {
  List<String> listOfPostId = <String>[];
  int numberOfPostsToFetch;
  FeedType feedType;
  String uniqueId;
  String nextToken;
  bool updatingPosts = false;
  String noDataAvailableMessage = NO_POSTS_AVAILABLE;
  int postAdjustmentNumber = 0;

  refreshData() async {
    clearList();
    hasMoreData = true;
    await renewPostsListData().then((value) => queryForMorePosts());
  }

  clearList() {
    listOfPostId = <String>[];
    nextToken = null;
  }

  Future<void> addNewPostsToTheList() async {
    updatingPosts = true;
    await getPosts().then((value) {
      nextToken = value.nextToken;
      List<PostData> newPostsList = [];
      value.list.forEach((element) {
        PostData postData =
            PostData(post: element, version: value.postVersion[element.id]);
        if ((element.user != null && element.status != Status.INACTIVE) &&
            getFeedSpecificConditionForPostAddition(postData)) {
          // if (Services.globalDataNotifier.postReservoir[element.id] ==
          //     null)
          Services.globalDataNotifier.postReservoir[element.id] = postData;
          // else
          //   Services.globalDataNotifier.postReservoir[element.id].post =
          //       element;
          // Services.globalDataNotifier.postReservoir[element.id]
          //     .version = ;

          try {
            if (listOfPostId.contains(element.id))
              throw Exception([
                "One Post was fetched two times",
                "Error in updatePostListData function"
              ]);
            newPostsList.add(postData);
          } catch (e, s) {
            // FirebaseCrashlytics.instance.recordError(e, s);
          }
        }
      });
      listOfPostId = listOfPostId + sortNewPostsList(newPostsList);
      listOfPostId = [
        ...{...listOfPostId},
      ];

      if (nextToken == lastNextTokenEqualToNull) hasMoreData = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    });
    updatingPosts = false;
  }

  List<String> sortNewPostsList(List<PostData> newPostsList) {
    for (int i = 0; i < newPostsList.length; i++) {
      for (int j = 0; j < newPostsList.length - 1; j++) {
        if (newPostsList[j].videoURL == null &&
            newPostsList[j + 1].videoURL != null) {
          // swap
          PostData temp = newPostsList[j];
          newPostsList[j] = newPostsList[j + 1];
          newPostsList[j + 1] = temp;
        }
      }
    }
    List<String> sortedPostIdList =
        newPostsList.map((e) => e.post.id as String).toList();
    return sortedPostIdList;
  }

  bool getFeedSpecificConditionForPostAddition(PostData postData) => true;

  Future<void> addMorePosts() async => await addNewPostsToTheList();

  Future<void> renewPostsListData() async => await addNewPostsToTheList();

  List<String> latestListOfPostId() => listOfPostId;

  bool isUpdatePostInProgress() => updatingPosts;

  void notifyFeedListeners() => notifyListeners();
}
