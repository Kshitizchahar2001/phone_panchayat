// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/user_profile_screen/follow_relationships_query_data.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class UserProfileData extends ChangeNotifier {
  User _profileOwner;
  User _profileVisitor;

  bool _isProfileOwnerFollowedByProfileVisitor;
  bool _isLoading = true;

  int _version;

  ValueNotifier<bool> _isUserRelationChangeMutationRunning;

  UserProfileData({
    @required User profileOwner,
    @required User profileVisitor,
  }) {
    _profileOwner = profileOwner;
    _profileVisitor = profileVisitor;
    _isUserRelationChangeMutationRunning = ValueNotifier(false);
    getFollowRelation();
  }

  Future<void> getFollowRelation() async {
    _isLoading = true;
    FollowRelationQueryData followRelationQueryData = await Services
        .gqlQueryService.getFollowRelationships
        .getFollowRelationships(
      followeeId: _profileOwner.id,
      followerId: _profileVisitor.id,
    );
    if (followRelationQueryData.success) {
      if (followRelationQueryData.recordFound) {
        _version = followRelationQueryData.version;
        _isProfileOwnerFollowedByProfileVisitor =
            followRelationQueryData.status == Status.ACTIVE;
      } else {
        _isProfileOwnerFollowedByProfileVisitor = false;
      }
    } else {
      _isProfileOwnerFollowedByProfileVisitor = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  tryAgain() async {
    _isLoading = false;
    notifyListeners();
    await getFollowRelation();
  }

  getButtonText() {
    if (!_isProfileOwnerFollowedByProfileVisitor)
      return FOLLOW;
    else
      return UNFOLLOW;
  }

  onButtonPressed() async {
    if (!_isProfileOwnerFollowedByProfileVisitor)
      await followUser();
    else
      await unfollowUser();
  }

  Future<void> followUser() async {
    _isUserRelationChangeMutationRunning.value = true;
    FollowRelationQueryData followRelationQueryData;

    if (_version == null) {
      followRelationQueryData = await Services
          .gqlMutationService.createFollowRelationships
          .createFollowRelationships(
        followerId: _profileVisitor.id,
        followeeId: _profileOwner.id,
        status: Status.ACTIVE,
      );
    } else {
      followRelationQueryData = await Services
          .gqlMutationService.updateFollowRelationships
          .updateFollowRelationships(
        followerId: _profileVisitor.id,
        followeeId: _profileOwner.id,
        expectedVersion: _version,
        status: Status.ACTIVE,
      );
    }

    if (followRelationQueryData.success) {
      _isProfileOwnerFollowedByProfileVisitor = true;
      _version = followRelationQueryData.version;
    }
    _isUserRelationChangeMutationRunning.value = false;
  }

  Future<void> unfollowUser() async {
    _isUserRelationChangeMutationRunning.value = true;

    FollowRelationQueryData followRelationQueryData = await Services
        .gqlMutationService.updateFollowRelationships
        .updateFollowRelationships(
      followerId: _profileVisitor.id,
      followeeId: _profileOwner.id,
      expectedVersion: _version,
      status: Status.INACTIVE,
    );
    if (followRelationQueryData.success) {
      _isProfileOwnerFollowedByProfileVisitor = false;
      _version = followRelationQueryData.version;
    }
    _isUserRelationChangeMutationRunning.value = false;
  }

  bool get isLoading => _isLoading;

  bool get isProfileOwnerFollowedByProfileVisitor =>
      _isProfileOwnerFollowedByProfileVisitor;

  ValueNotifier<bool> get isUserRelationChangeMutationRunning =>
      _isUserRelationChangeMutationRunning;
}
