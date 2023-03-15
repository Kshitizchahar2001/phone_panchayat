// ignore_for_file: file_names

import 'package:online_panchayat_flutter/services/gqlQueryServices/getCommentsByPostId.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getCommunityPost.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getCommunityPostByUpdateAt.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getFollowRelationships.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getReactions.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getReactionsByPostId.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getUserById.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/listCommunitys.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/searchPlaceByParentIdAndType.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/searchPostByTag.dart';
import 'gqlQueryServices/getCasteCommunity.dart';
import 'gqlQueryServices/getDesignatedUser.dart';
import 'gqlQueryServices/getPostWithTags.dart';
import 'gqlQueryServices/getPostWithTagsByUserIdAndsortKeyCreatedAt.dart';
import 'gqlQueryServices/searchDesignatedUsersByPlaceAndStatus.dart';
import 'gqlQueryServices/searchLocalIssuesbyTagAndIdentifiers.dart';
import 'gqlQueryServices/searchNewsByPlace.dart';

class GQLQueryService {
  GetReactions getReactions;
  GetUserById getUserById;
  GetReactionsbyPostId getReactionsbyPostId;
  GetCommunityPostByUpdatedAt getCommunityPostByUpdatedAt;
  GetCommunityPost getCommunityPost;
  ListCasteCommunitys listCasteCommunitys;
  GetCasteCommunity getCasteCommunity;
  GetCommentsByPostId getCommentsByPostId;
  GetFollowRelationships getFollowRelationships;
  GetDesignatedUser getDesignatedUser;
  SearchDesignatedUsersByPlaceAndStatus searchDesignatedUsersByPlaceAndStatus;

  GetPostWithTags getPostWithTags;
  GetPostWithTagsByUserIdAndSortByCreatedAt
      getPostWithTagsByUserIdAndSortByCreatedAt;
  SearchPostByTag searchPostByTag;
  SearchLocalIssuesbyTagAndIdentifiers searchLocalIssuesbyTagAndIdentifiers;
  SearchPlacedByParentIdAndType searchPlacedByParentIdAndType;
  SearchNewsByPlace searchNewsByPlace;

  GQLQueryService() {
    getReactions = GetReactions();
    getUserById = GetUserById();
    getReactionsbyPostId = GetReactionsbyPostId();
    getCommunityPostByUpdatedAt = GetCommunityPostByUpdatedAt();
    getCommunityPost = GetCommunityPost();
    listCasteCommunitys = ListCasteCommunitys();
    getCasteCommunity = GetCasteCommunity();
    getCommentsByPostId = GetCommentsByPostId();
    getFollowRelationships = GetFollowRelationships();
    // getPostByPostCategoryAndUpdateTime = GetPostByPostCategoryAndUpdateTime();
    getDesignatedUser = GetDesignatedUser();
    searchDesignatedUsersByPlaceAndStatus =
        SearchDesignatedUsersByPlaceAndStatus();
    // searchLocalIssuesbyPincodeAndIdentifiers =
    //     SearchLocalIssuesbyPincodeAndIdentifiers();

    searchPlacedByParentIdAndType = SearchPlacedByParentIdAndType();
    searchPostByTag = SearchPostByTag();
    getPostWithTags = GetPostWithTags();
    getPostWithTagsByUserIdAndSortByCreatedAt =
        GetPostWithTagsByUserIdAndSortByCreatedAt();
    searchLocalIssuesbyTagAndIdentifiers =
        SearchLocalIssuesbyTagAndIdentifiers();
    searchNewsByPlace = SearchNewsByPlace();
  }
}
