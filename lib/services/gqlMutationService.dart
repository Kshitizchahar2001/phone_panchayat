// ignore_for_file: file_names

import 'package:online_panchayat_flutter/services/gqlMutationServices/createFollowRelationships.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createLocalIssueWithTags.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/updateDesignatedUser.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/updateFollowRelationships.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/updatePostWithTags.dart';
import 'gqlMutationServices/createComment.dart';
import 'gqlMutationServices/createDesignatedMember.dart';
import 'gqlMutationServices/createMemberRecommendation.dart';
import 'gqlMutationServices/createNewPostWithTags.dart';
import 'gqlMutationServices/createNewUser.dart';
import 'gqlMutationServices/createView.dart';
import 'gqlMutationServices/updateCommunityPost.dart';
import 'gqlMutationServices/updateReaction.dart';
import 'gqlMutationServices/createReaction.dart';
import 'gqlMutationServices/updateUser.dart';

export './gqlMutationServices/createComment.dart';
export './gqlMutationServices/createNewPostWithTags.dart';
export './gqlMutationServices/createNewUser.dart';
export 'gqlMutationServices/createView.dart';
export 'gqlMutationServices/updateReaction.dart';
export 'gqlMutationServices/createReaction.dart';
export 'gqlMutationServices/updateUser.dart';

class GQLMutationService {
  CreateReaction createReaction;
  CreateNewPostWithTags createNewPostWithTags;
  CreateNewUser createNewUser;
  CreateComment createComment;
  CreateView createView;
  UpdateReaction updateReaction;
  UpdateUser updateUser;
  UpdatePost updatePost;
  UpdateCommunityPost updateCommunityPost;
  CreateFollowRelationships createFollowRelationships;
  UpdateFollowRelationships updateFollowRelationships;
  CreateDesignatedUser createDesignatedUser;
  UpdateDesignatedUser updateDesignatedUser;
  CreateLocalIssueWithTag createLocalIssueWithTag;
  CreateMemberRecommendation createMemberRecommendation;
  GQLMutationService() {
    createReaction = CreateReaction();
    createNewPostWithTags = CreateNewPostWithTags();
    createNewUser = CreateNewUser();
    createComment = CreateComment();
    createView = CreateView();
    updateReaction = UpdateReaction();
    updateUser = UpdateUser();
    updatePost = UpdatePost();
    updateCommunityPost = UpdateCommunityPost();
    createFollowRelationships = CreateFollowRelationships();
    updateFollowRelationships = UpdateFollowRelationships();
    createDesignatedUser = CreateDesignatedUser();
    updateDesignatedUser = UpdateDesignatedUser();
    createLocalIssueWithTag = CreateLocalIssueWithTag();
    createMemberRecommendation = CreateMemberRecommendation();
  }
}
