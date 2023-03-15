// ignore_for_file: file_names, prefer_initializing_formals, annotate_overrides

import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/models/AdditionalTehsil.dart';
import 'package:online_panchayat_flutter/models/PostCategory.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/FeedService/feedQueryData.dart';
import '../multiPageFeed.dart';

class AdditionalTehsilFeed extends MultiPageFeed {
  String tagId;
  AdditionalTehsils additionalTehsil;
  AdditionalTehsilFeed({String tagId, AdditionalTehsils additionalTehsil}) {
    feedType = FeedType.AdditionalTehsilFeed;
    this.tagId = tagId;
    this.additionalTehsil = additionalTehsil;
  }

  String adminPostNextToken;

  @override
  bool getFeedSpecificConditionForPostAddition(PostData postData) =>
      (postData.post.postCategory == null ||
          postData.post.postCategory == PostCategory.PUBLIC);

  @override
  addMorePosts() async {
    await addNewPostsToTheList();
    // if (!hasMoreData) {
    //   await _addAdminPostsToAllPincodes(AdminTagForPostsAtTheEnd);
    // }
  }

  @override
  Future<void> renewPostsListData() async {
    adminPostNextToken = null;
    //await _addAdminPostsToAllPincodes(AdminTagForPostsAtTheBeginning);
    await addNewPostsToTheList();
  }

  Future<FeedQueryData> getPosts() async {
    return await Services.gqlQueryService.searchPostByTag.searchPostByTag(
      tag: tagId,
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

  // Future<void> _addAdminPostsToAllPincodes(String pincode) async {
  //   // posts created in admin pincode will be visible to all users irrespective of their pincode.
  //   // if pincode is -1 : these posts will be listed after all the user created posts are listed.
  //   // if pincode is -100 : these posts will be listed before all the user created posts are listed.

  //   await _getAdminCreatedPosts(pincode).then((value) => {
  //         adminPostNextToken = value.nextToken,
  //         value.list.forEach((element) {
  //           if (element.user != null) {
  //             listOfPostId.add(element.id);
  //             if (Services.globalDataNotifier.postReservoir[element.id] == null)
  //               Services.globalDataNotifier.postReservoir[element.id] =
  //                   PostData(
  //                       post: element, version: value.postVersion[element.id]);
  //           }
  //         }),
  //         listOfPostId = [
  //           ...{...listOfPostId},
  //         ],
  //         if (pincode == AdminTagForPostsAtTheEnd) notifyListeners(),
  //       });
  // }

  // Future<FeedQueryData> _getAdminCreatedPosts(
  //     //return all posts created by admin , common to all pincodes

  //     String tag) async {
  //   return await Services.gqlQueryService.searchPostByTag.searchPostByTag(
  //     tag: tag,
  //     numberOfPostsTofetch: numberOfPostsToFetch,
  //     nextToken: adminPostNextToken,
  //   );
  // }
}
