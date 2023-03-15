import 'package:online_panchayat_flutter/screens/widgets/banner/Data/banner_post_data.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/appUpdateService.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/gqlQueryService.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/utils/DesignatedUserDataNotifier.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class Services {
  static GQLQueryService gqlQueryService;
  static GQLMutationService gqlMutationService;
  static GlobalDataNotifier globalDataNotifier;
  static FirebaseMessagingService firebaseMessagingService;
  static LocationNotifier locationNotifier;
  static AuthenticationService authenticationService;
  static AuthStatusNotifier authStatusNotifier;
  static DesignatedUserDataNotifier designatedUserDataNotifier;
  static AnalyticsService analyticsService;
  static AppUpdateService appUpdateService;

  static BannerPostData bannerPostData;
}
