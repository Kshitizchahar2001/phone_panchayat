// ignore_for_file: file_names, prefer_collection_literals

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/firestoreModels/Profession.dart';
import 'package:online_panchayat_flutter/models/AdditionalTehsil.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/DesignatedUserData/designatedUserData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/LocalIssueFeed/localIssueData/localIssueData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/DesignatedUsersFeed/Feeds/allDesignatedUsersFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/DesignatedUsersFeed/Feeds/designatedUserRegistrationRequestsFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/LocalIssuesFeed/Feeds/constituencyLocalIssuesFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/LocalIssuesFeed/Feeds/pincodeLocalIssuesFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/rajasthanFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/homeFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/myFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/singlePost.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/userFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/videosFeed.dart';
import 'package:online_panchayat_flutter/services/gqlQueryService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/userDataStorage.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class GlobalDataNotifier extends ChangeNotifier {
  User _localUser;
  bool _isUserRegistered;
  GQLQueryService gqlQueryService;

  Feed homeFeed;
  Feed myFeed;
  Feed singlePost;
  Feed userFeed;
  Feed communityFeed;
  Feed singleCommunityPost;
  Feed videosFeed;
  Feed designatedUserRegistrationRequestsFeed;
  Feed viewAllVerifiedDesignatedMembersFeed;
  Feed sarpanchFeed;
  Feed constituencyLocalIssuesFeed;
  Feed pincodeLocalIssuesFeed;
  Feed rajasthanFeed;
  static int numberOfCommentsDisplayedOnHomepage = 2;

  String currentMainScreenTab;
  List<Profession> availableProfessionals;

  GlobalDataNotifier() {
    // _localUser = User(
    //   name: 'priyanshu',
    //   homeAdressLocation: Location(lat: 10.0, lon: 10.0),
    //   area: "lucknow",
    //   pincode: "226006",
    //   id: "+918953446887",
    // );
    homeFeed = HomeFeed();
    myFeed = MyFeed();
    singlePost = SinglePost();
    userFeed = UserFeed();
    videosFeed = VideosFeed();
    designatedUserRegistrationRequestsFeed =
        DesignatedUserRegistrationRequestsFeed();
    viewAllVerifiedDesignatedMembersFeed =
        ViewAllVerifiedDesignatedMembersFeed();
    sarpanchFeed = ViewAllVerifiedDesignatedMembersFeed();
    constituencyLocalIssuesFeed = ConstituencyLocalIssuesFeed();
    pincodeLocalIssuesFeed = PincodeLocalIssuesFeed();
    rajasthanFeed = RajasthanFeed();
  }

  Map<String, PostData> postReservoir = Map<String, PostData>();
  Map<String, DesignatedUserData> designatedUserDataReservoir =
      Map<String, DesignatedUserData>();

  Map<String, LocalIssueData> localIssueDataReservoir =
      Map<String, LocalIssueData>();

  setUserData(User newUser, {bool shouldNotifyListeners = true}) {
    _localUser = newUser;
    UserDataStorage.setUserData(_localUser);

    additionalTehsilList.value =
        _localUser.additionalTehsils?.toList() ?? <AdditionalTehsils>[];

    if (_localUser.isDesignatedUser == true) {
      Services.designatedUserDataNotifier
          .updateDesignatedUserDataAndNotifyListeners(userId: _localUser.id);
    }
    if (shouldNotifyListeners) notifyListeners();
  }

  set mainScreenTab(String tab) {
    currentMainScreenTab = tab;
  }

  set setUserRegisteredStatus(bool isUserRegistered) {
    _isUserRegistered = isUserRegistered;
  }

  bool get isUserRegistered => _isUserRegistered;

  bool isuserProfileComplete() {
    if (_localUser.name == null) return false;
    if (_localUser.designation == null) return false;
    if (_localUser.gender == null) return false;
    return true;
  }

  PropertyValueNotifier<List<AdditionalTehsils>> additionalTehsilList =
      PropertyValueNotifier(<AdditionalTehsils>[]);

  User get localUser => _localUser;
}
