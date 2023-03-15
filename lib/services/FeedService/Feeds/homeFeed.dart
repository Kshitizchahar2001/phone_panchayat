// ignore_for_file: file_names, annotate_overrides, avoid_function_literals_in_foreach_calls, curly_braces_in_flow_control_structures

import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/models/PostCategory.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/FeedService/multiPageFeedWithChild.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';

class HomeFeed extends MultiPageFeedWithChild {
  HomeFeed() {
    feedType = FeedType.HomeFeed;
  }

  String adminPostNextToken;

  @override
  bool getFeedSpecificConditionForPostAddition(PostData postData) =>
      (postData.post.postCategory == null ||
          postData.post.postCategory == PostCategory.PUBLIC);

  @override
  addMorePosts() async {
    await addNewPostsToTheList();
    if (!hasMoreData) {
      await _addAdminPostsToAllPincodes(AdminTagForPostsAtTheEnd);
    }
  }

  @override
  Future<void> renewPostsListData() async {
    adminPostNextToken = null;
    await _addAdminPostsToAllPincodes(AdminTagForPostsAtTheBeginning);
    await addNewPostsToTheList();
  }

  Future<FeedQueryData> getPosts() async {
    return await Services.gqlQueryService.searchPostByTag.searchPostByTag(
      tag: Services.globalDataNotifier.localUser.tag,
      numberOfPostsTofetch: numberOfPostsToFetch,
      nextToken: nextToken,
    );
    // FeedQueryData feed;
    // feed = await Services.gqlQueryService.searchPostByTag.searchPostByTag(
    //   tag: Services.globalDataNotifier.localUser.tag,
    //   numberOfPostsTofetch: numberOfPostsToFetch,
    //   nextToken: nextToken,
    // );
    // feed.setList = [feed.list[0]];
    // feed.nextToken = lastNextTokenEqualToNull;
    // return feed;
  }

  Future<void> _addAdminPostsToAllPincodes(String pincode) async {
    // posts created in admin pincode will be visible to all users irrespective of their pincode.
    // if pincode is -1 : these posts will be listed after all the user created posts are listed.
    // if pincode is -100 : these posts will be listed before all the user created posts are listed.

    await _getAdminCreatedPosts(pincode).then((value) => {
          adminPostNextToken = value.nextToken,
          value.list.forEach((element) {
            PostWithTags postWithTags = element as PostWithTags;
            if (postWithTags.user != null || postWithTags.id.contains(BANNER)) {
              listOfPostId.add(postWithTags.id);
              if (Services.globalDataNotifier.postReservoir[postWithTags.id] ==
                  null)
                Services.globalDataNotifier.postReservoir[postWithTags.id] =
                    PostData(
                        post: postWithTags,
                        version: value.postVersion[element.id]);
            }
          }),
          listOfPostId = [
            ...{...listOfPostId},
          ],
          if (pincode == AdminTagForPostsAtTheEnd) notifyListeners(),
        });
  }

  Future<FeedQueryData> _getAdminCreatedPosts(
      //return all posts created by admin , common to all pincodes

      String tag) async {
    return await Services.gqlQueryService.searchPostByTag.searchPostByTag(
      tag: tag,
      numberOfPostsTofetch: numberOfPostsToFetch,
      nextToken: adminPostNextToken,
    );
  }
}
