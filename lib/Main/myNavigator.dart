// ignore_for_file: file_names, avoid_print, prefer_const_constructors, unnecessary_string_interpolations

import 'package:online_panchayat_flutter/enum/singlePostOpenSource.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/individualProfessionalListScreen.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/individualProfessionalListScreenData.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/individualProfessionalScreen.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/placeListScreen.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/placeSuggestionScreen.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/registration_screen.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/suggestionMessageScreen.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/add_post_screen.dart';
import 'package:online_panchayat_flutter/screens/additional_tehsil_select/additional_tehsil_placeList.dart';
import 'package:online_panchayat_flutter/screens/additional_tehsil_select/additional_tehsil_share.dart';
import 'package:online_panchayat_flutter/screens/designatedMembersByPanchayatSamitiScreen.dart';
import 'package:online_panchayat_flutter/screens/designatedMembersRegistrationRequests.dart';
import 'package:online_panchayat_flutter/screens/designatedMembersScreen.dart';
import 'package:online_panchayat_flutter/screens/developer_screen/developer_screen.dart';
import 'package:online_panchayat_flutter/screens/electedMemberRegistrationScreen/electedMemberRegistrationScreen.dart';
import 'package:online_panchayat_flutter/screens/enter_aadhaar_screen.dart';
import 'package:online_panchayat_flutter/screens/in_app_web_view_screen.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/add_images.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/individual_match.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/match_image.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/matches_list.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/matches_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_personal_details.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_plan.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_section.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_success.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/profile_image_select.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/update_matrimonial_profile.dart';
import 'package:online_panchayat_flutter/screens/my_profile_screen.dart';
import 'package:online_panchayat_flutter/screens/notificationLinkWebView.dart';
import 'package:online_panchayat_flutter/screens/otp_screen/Data/signInVerification.dart';
import 'package:online_panchayat_flutter/screens/otp_screen/Data/writeOperationVerification.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/all_reviews_screen.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/all_services.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/edit_professional.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/full_screen_image.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/individual_professional.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/invite_friends.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/professional_list_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/professional_registration_complete.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/professionals_list.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/register_professional.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/route/customRoute.dart';
import 'package:online_panchayat_flutter/screens/recommendRepresentative/recommendRepresentativeScreen.dart';
import 'package:online_panchayat_flutter/screens/reviewConstituencyLocalIssues.dart';
import 'package:online_panchayat_flutter/screens/selectUserPlaceScreen.dart';
import 'package:online_panchayat_flutter/screens/test.dart';
import 'package:online_panchayat_flutter/screens/verifyPhoneNumberScreen.dart';
import 'package:online_panchayat_flutter/screens/viewAllComplaints.dart';
import 'package:online_panchayat_flutter/screens/widgets/ConnectivityIndicator/connectivity_indicator.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/videoFeed/videoFeedScreen.dart';
import 'package:online_panchayat_flutter/screens/youtubeVideoScreen.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/Data/suppressedUrl.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utilityService.dart';
import 'package:velocity_x/velocity_x.dart';

import 'routes.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/observer.dart';
import 'package:online_panchayat_flutter/screens/RegisterProfessionalScreen/register_professional_screen.dart';
import 'package:online_panchayat_flutter/screens/add_complaint_screen.dart';
import 'package:online_panchayat_flutter/screens/alerts_screen.dart';
import 'package:online_panchayat_flutter/screens/help_and_contact_page.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/SelectPostTagScreen/selectPostTagScreen.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/referAndEarnScreen.dart';
import 'package:online_panchayat_flutter/screens/user_profile_screen/user_profile_screen.dart';
import 'package:online_panchayat_flutter/screens/register_user_prompt.dart';
import 'package:online_panchayat_flutter/screens/view_comments_page/viewCommentPage.dart';
import 'package:online_panchayat_flutter/screens/view_community_members_screen.dart';
import 'package:online_panchayat_flutter/screens/view_reactions_screen.dart';
import 'package:online_panchayat_flutter/screens/login_screen.dart';
import 'package:online_panchayat_flutter/screens/main_screen/main_screen.dart';
import 'package:online_panchayat_flutter/screens/myposts_screen.dart';
import 'package:online_panchayat_flutter/screens/otp_screen/UI/otp_screen.dart';
import 'package:online_panchayat_flutter/screens/select_location_screen.dart';
import 'package:online_panchayat_flutter/screens/settings_screen.dart';
import 'package:online_panchayat_flutter/screens/single_post_view_screen.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:provider/provider.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/placeState.dart';

class MyNavigator {
  static String getRouteName() {
    return Uri.decodeComponent(StoreGlobalData.deepLink.toString());
  }

  static final List<String> allowedNamedRoutes = [
    "PostView",
    "MatrimonialSection"
  ];

  static PlatformRouteInformationProvider getRouterInformation() {
    PlatformRouteInformationProvider routeInformationProvider;
    if (StoreGlobalData.deepLink != null &&
        StoreGlobalData.deepLink.toString().contains(allowedNamedRoutes[0])) {
      print("route pushed from deeplink");
      String route = getRouteName();
      print("route is : $route");
      routeInformationProvider = PlatformRouteInformationProvider(
          initialRouteInformation: RouteInformation(
              location:
                  Uri.decodeComponent(StoreGlobalData.deepLink.toString())));
      StoreGlobalData.deepLink = null;
    } else if (StoreGlobalData.deepLink != null &&
        StoreGlobalData.deepLink.toString().contains(allowedNamedRoutes[1])) {
      String route = getRouteName();
      print("route is : $route");

      routeInformationProvider = PlatformRouteInformationProvider(
          initialRouteInformation: RouteInformation(
              location:
                  Uri.decodeComponent(StoreGlobalData.deepLink.toString())));
    } else {
      print("no route is pushed");
      routeInformationProvider = PlatformRouteInformationProvider(
          initialRouteInformation: RouteInformation(location: '/'));
    }
    return routeInformationProvider;
  }

  static VxNavigator getNavigator(
    bool isUserValid,
    bool isUserRegistered,
  ) {
    return VxNavigator(
      observers: [MyObs()],
      notFoundPage: (uri, params) {
        // AnalyticsService.setCurrentScreen('notFoundPage');
        AnalyticsService.firebaseAnalytics.logEvent(
            name: 'not_found_page_shown',
            parameters: {'path_required': '${uri.path}'});
        return MaterialPage(
          key: ValueKey('not-found-page'),
          child: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: Text('Page ${uri.path} not found'),
              ),
            ),
          ),
        );
      },
      routes: routesMap(isUserValid, isUserRegistered),
    );
  }

  static Map<String, VxPageBuilder> routesMap(
      bool isUserValid, bool isUserRegistered) {
    return {
      MyRoutes.initialRoute: (_, __) => MaterialPage(
          key: UniqueKey(),
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Builder(
                    builder: (context) {
                      if (isUserValid && isUserRegistered) {
                        if (Services.globalDataNotifier.localUser.tag != null) {
                          return MainPage();
                        } else {
                          AnalyticsService.firebaseAnalytics.logEvent(
                              name: "tag_does_not_exist_for_user",
                              parameters: {});
                          return PlaceList(
                            place: PlaceState(),
                          );
                        }
                      } else if (isUserValid && !isUserRegistered) {
                        return PlaceList(
                          place: PlaceState(),
                        );
                      } else {
                        AnalyticsService.setCurrentScreenOnPush(
                            MyRoutes.loginRoute);
                        return LoginScreen();
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConnectivityIndicatorWidget(),
                  ),
                ],
              ),
            ),
          )),
      MyRoutes.homeRoute: (_, __) {
        return MaterialPage(child: MainPage());
      },
      MyRoutes.loginRoute: (_, __) {
        return MaterialPage(child: LoginScreen());
      },
      MyRoutes.signInOtpRoute: (uri, params) {
        return MaterialPage(
            child: OtpScreen(
          otpVerificationData: SignInVerification(
            params as String,
          ),
        ));
      },
      MyRoutes.writeOperationVerificationOtpRoute: (uri, params) {
        return MaterialPage(
          child: OtpScreen(
            otpVerificationData: WriteOperationVerification(
              params as String,
            ),
          ),
        );
      },
      MyRoutes.registrationRoute: (uri, params) {
        return CustomRoute(
            child: CreateProfileForm(
          message: params,
        ));
      },
      MyRoutes.createPostRoute: (uri, params) {
        return MaterialPage(
            child: AddPost(
          complaint: params['complaint'],
          postData: params['postData'],
          postTag: params['postTag'],
        ));
      },
      MyRoutes.selectLocationRoute: (uri, params) {
        return MaterialPage(child: AdressScreenOrGettingLocation());
      },
      MyRoutes.settingsRoute: (_, __) {
        return MaterialPage(child: Settings());
      },
      MyRoutes.singlePostViewLinkRoute: (uri, params) {
        return MaterialPage(
            child: SinglePostView(
          uniqueId:
              UtilityService.removeSlashSymbols(uri.queryParameters['id']),
          singlePostOpenSource: SinglePostOpenSource.SHARE_LINK,
        ));
      },
      MyRoutes.singlePostViewMainScreenRoute: (uri, params) {
        return MaterialPage(
            child: SinglePostView(
          uniqueId: params,
          singlePostOpenSource: SinglePostOpenSource.IN_APP,
        ));
      },
      MyRoutes.singlePostViewNotificationRoute: (uri, params) {
        return MaterialPage(
            child: SinglePostView(
          uniqueId: params,
          singlePostOpenSource: SinglePostOpenSource.NOTIFICATION,
        ));
      },
      MyRoutes.myPostsRoute: (_, params) {
        return MaterialPage(
            child: MyPosts(
          feedType: params,
        ));
      },
      MyRoutes.alertsRoute: (_, params) {
        return MaterialPage(child: Alerts());
      },
      MyRoutes.viewReactionsRoute: (_, params) {
        return MaterialPage(
            child: ViewReactions(
          postId: params,
        ));
      },
      MyRoutes.profileRoute: (_, params) {
        return MaterialPage(
            child: Profile(
          user: params,
        ));
      },
      MyRoutes.myProfileRoute: (_, params) {
        return MaterialPage(child: MyProfile());
      },
      MyRoutes.enterAadhaarRoute: (_, __) {
        return MaterialPage(child: EnterAadhaarScreen());
      },
      MyRoutes.viewCommunityMembers: (_, params) {
        return MaterialPage(
            child: ViewCommunityMembers(
          communityId: params,
        ));
      },
      MyRoutes.registerPromptPage: (_, params) {
        return MaterialPage(child: RegisterPromptPage());
      },
      MyRoutes.viewComment: (_, params) {
        return MaterialPage(child: ViewComments(postData: params));
      },
      MyRoutes.helpAndContactPage: (_, __) {
        return MaterialPage(child: HelpAndContactPage());
      },
      MyRoutes.registerProfessional: (_, __) {
        return MaterialPage(child: RegisterProfessionalScreen());
      },
      MyRoutes.listProfessionals: (_, params) {
        return MaterialPage(
            child: ChangeNotifierProvider<IndividualProfessionalListScreenData>(
          create: (_) => IndividualProfessionalListScreenData(
            profession: params,
          ),
          builder: (context, child) => IndividualProfessionalListScreen(),
        ));
      },
      MyRoutes.videoFeedScreen: (_, __) {
        return MaterialPage(child: VideoFeedScreen());
      },
      MyRoutes.placeList: (_, params) {
        return MaterialPage(
            child: PlaceList(
          place: params,
        ));
      },
      MyRoutes.selectComplaintArea: (_, __) {
        return MaterialPage(child: AddComplaintScreen());
      },
      MyRoutes.selectPostTag: (_, __) {
        return MaterialPage(child: SelectPostTag());
      },
      MyRoutes.referAndEarnScreen: (_, __) {
        return MaterialPage(child: ReferAndEarnScreen());
      },
      MyRoutes.viewProfessional: (_, params) {
        return MaterialPage(
            child: IndividualProfessionalScreen(
          professional: params[0],
          myLocation: params[1],
        ));
      },
      MyRoutes.reviewRequests: (_, params) {
        return MaterialPage(
            child: DesignatedMembersRegistrationRequestsScreen());
      },
      MyRoutes.registerAsElectedRepresentative: (_, params) {
        return MaterialPage(child: ElectedMemberScreen());
      },
      MyRoutes.viewAllDesignatedUsers: (_, params) {
        return MaterialPage(child: DesignatedMembersScreen());
      },
      MyRoutes.reviewConstituencyLocalIssues: (_, params) {
        return MaterialPage(child: ReviewConstituencyLocalIssues());
      },
      MyRoutes.selectUserAreaIdentifiers: (_, params) {
        return MaterialPage(child: SelectUserAreaIdentifiersScreen());
      },
      MyRoutes.viewAllComplaintsScreen: (_, params) {
        return MaterialPage(child: ViewAllComplaintsScreen());
      },
      MyRoutes.recommendRepresentativeScreen: (_, params) {
        return MaterialPage(child: RecommendRepresentativeScreen());
      },
      MyRoutes.editProfile: (_, params) {
        return MaterialPage(child: EditProfileForm());
      },
      MyRoutes.myUpdatePage: (_, params) {
        return MaterialPage(child: MyUpdatePage());
      },
      MyRoutes.placeSuggestionScreen: (_, params) {
        return MaterialPage(
            child: PlaceSuggestionScreen(
          placeSuggestionData: params,
        ));
      },
      MyRoutes.suggestionMessageScreen: (_, params) {
        return MaterialPage(
            child: SuggestionMessageScreen(
          placeSuggestionData: params,
        ));
      },
      MyRoutes.notificationLinkWebView: (_, params) {
        return MaterialPage(
          child: NotificationLinkWebView(
            suppressedUrl: params as SuppressedUrl,
          ),
        );
      },
      MyRoutes.youtubeVideoScreen: (_, params) {
        return MaterialPage(
          child: YoutubeVideoScreen(url: params as String),
        );
      },
      MyRoutes.inAppWebViewScreen: (_, params) {
        return MaterialPage(
          child: InAppWebViewScreen(url: params as String),
        );
      },
      MyRoutes.designatedMembersByPanchayatSamitiScreen: (_, params) {
        return MaterialPage(
          child: DesignatedMembersByPanchayatSamitiScreen(
              panchayatSamitiId: params as String),
        );
      },
      MyRoutes.seeAllServices: (uri, params) {
        return CustomRoute(
            child: AllServices(
          servicesList: params,
        ));
      },
      MyRoutes.registerProfessionalForm: (_, params) {
        return CustomRoute(child: RegisterProfessionalForm());
      },
      MyRoutes.professionalList: (uri, params) {
        return CustomRoute(
            child: ChangeNotifierProvider<ProfessionalListData>(
          create: (_) => ProfessionalListData(service: params),
          builder: (context, child) => ProfessionalList(),
        ));
      },
      MyRoutes.professionalRegistrationComplete: (uri, params) {
        return MaterialPage(
            child: ProfessionalRegistrationComplete(
          registrationStatus: params,
        ));
      },
      MyRoutes.inviteFriends: (uri, params) {
        return MaterialPage(child: InviteFriends());
      },
      MyRoutes.seeProfessionalProfile: (uri, params) {
        return CustomRoute(
            child: IndividualProfessional(
          myLocation: params[1],
          professional: params[0],
        ));
      },
      MyRoutes.seeFullScreenImage: (uri, params) {
        return MaterialPage(
          child: FullScreenImage(
            imageUrl: params,
          ),
        );
      },
      MyRoutes.editProfessional: (uri, params) {
        return CustomRoute(
            child: EditProfessional(
          professional: params,
        ));
      },
      MyRoutes.seeAllReviews: (uri, params) {
        return CustomRoute(
            child: AllReviewsScreen(
          allReviews: params,
        ));
      },
      MyRoutes.verifyPhoneNumberRoute: (uri, params) {
        return CustomRoute(
            child: VerifyPhoneNumberScreen(
          phoneNumber: params as String,
        ));
      },
      MyRoutes.selectAdditionalTehsil: (uri, params) {
        return CustomRoute(child: AdditionalTehsilPlaceList(place: params));
      },
      MyRoutes.developerScreen: (uri, params) {
        return CustomRoute(child: DeveloperScreen());
      },
      MyRoutes.shareAdditionalTehsil: (uri, params) {
        return CustomRoute(child: ShareAdditionalTehsilPoster());
      },
      MyRoutes.registerInMatrimonial: (uri, params) {
        return CustomRoute(child: MatrimonailPersonalDetails());
      },
      MyRoutes.matrimonialPlanScreen: (uri, params) {
        return CustomRoute(
            child: MatrimonialPlan(
          matrimonialProfile: params,
        ));
      },
      MyRoutes.shareMatrimonialPlan: (uri, params) {
        return CustomRoute(child: MatrimonialShare());
      },
      MyRoutes.matchList: (uri, params) {
        return CustomRoute(
            child: ChangeNotifierProvider<MatchesListData>(
          create: (_) => MatchesListData(currentProfile: params),
          builder: (context, child) => MatchesList(),
        ));
      },
      MyRoutes.individualMatch: (uri, params) {
        return CustomRoute(
            child: IndividualMatch(
          profile: params[0],
          incomingRequestListData: params[1],
          callListData: params[2],
          sentRequestListData: params[3],
        ));
      },
      MyRoutes.updateMatrimonialProfile: (uri, params) {
        return CustomRoute(
            child: UpdateMatrimonialProfile(currentProfile: params));
      },
      MyRoutes.addImagesForMatrimonial: (uri, params) {
        return CustomRoute(child: AddMatrimonialImages(profile: params));
      },
      MyRoutes.showMatchImages: (uri, params) {
        return CustomRoute(
            child: MatrimonialMatchImages(
          profile: params[0],
          isCurrentUserProfile: params[1],
          isIncomingRequest: params[2],
          callRequestStatus: params[3],
          onSendFollowRequest: params[4],
          onAcceptFollowRequest: params[5],
          onRejectFollowRequest: params[6],
        ));
      },
      MyRoutes.matrimonialSection: (uri, params) {
        return CustomRoute(child: MatrimonialSection());
      },
      MyRoutes.matrimonialProfileImageChange: (uri, params) {
        return CustomRoute(child: ProfileImageSelect());
      }
    };
  }
}
