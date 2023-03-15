// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_is_empty, avoid_print, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/initFunctions.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/screens/main_screen/HomeTabChildren/sarpanchTab.dart';
import 'package:online_panchayat_flutter/screens/main_screen/additional_tehsil_button.dart';
import 'package:online_panchayat_flutter/screens/main_screen/drawer.dart';
import 'package:online_panchayat_flutter/screens/main_screen/floatingActionButton.dart';
import 'package:online_panchayat_flutter/screens/main_screen/mainScreenAppBar.dart';

import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/postFeed.dart';
import 'package:online_panchayat_flutter/screens/widgets/myDescribedFeatureOverlay.dart';
import 'package:online_panchayat_flutter/screens/widgets/top_snackbar.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/additonalTehsilFeed.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/tour.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/tourDataStorage.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/AdditionalTehsil.dart';
import 'HomeTabChildren/stateTab.dart';

class HomeTab extends StatefulWidget {
  final PageController mainScreenPageController;
  const HomeTab({Key key, this.mainScreenPageController}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Tour rajasthanNewsTour;
  Widget rajasthanNewsTabIcon;
  TabController tabController;
  ValueKey rajasthanNewsTabKey = ValueKey('rajasthanNewsTabKey');
  bool showSarpanchTab = true;
  bool userHasAdditionalTehsils = false;
  List<Widget> tabs = <Widget>[];
  List<Widget> additionalTabs = <Widget>[];
  List<Widget> tabBarViewChildren = <Widget>[];
  TextStyle labelTextStyle;
  List<AdditionalTehsilFeed> additionalTehsilFeedList =
      <AdditionalTehsilFeed>[];

  @override
  bool get wantKeepAlive => true;

  bool checkShowSarpanchTab() {
    // bool showSarpanchTab = true;
    PlaceType placeType =
        Services.globalDataNotifier.localUser?.state_place?.type;

    if (placeType == null) return true;
    if (placeType == PlaceType.STATE) {
      return true;
    } else
      return false;
  }

  @override
  void initState() {
    rajasthanNewsTour =
        TourDataStorage.getTour(TourDataStorage.RAJASTHAN_NEWS_TOUR);

    showSarpanchTab = checkShowSarpanchTab();

    if (Services.globalDataNotifier.additionalTehsilList.value.length > 0) {
      userHasAdditionalTehsils = true;
    }

    // rajasthanNewsTour.showTour(context);
    // uncomment to show tour guide
    initialiseTabController();

    /// Init additional Tehsil list
    initiliazeAdditionalTehsilList();

    if (!rajasthanNewsTour.isTourComplete)
      tabController.addListener(tabControllerListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        checkIfAppIsLaunchedFromNotification(context);
      } catch (e, s) {
        String exception =
            "Error in checkIfAppIsLaunchedFromNotification function : " +
                e.toString();
        FirebaseCrashlytics.instance.recordError(exception, s);
      }
    });

    super.initState();
  }

  void initialiseTabController() {
    tabController = TabController(
      length: getTabCount,
      vsync: this,
      initialIndex: 0,
    );
  }

  initiliazeAdditionalTehsilList() {
    additionalTehsilFeedList = <AdditionalTehsilFeed>[];
    List<AdditionalTehsils> additionalTehsils =
        Services.globalDataNotifier.additionalTehsilList.value;
    for (int i = 0; i < additionalTehsils.length; i++) {
      additionalTehsilFeedList.add(AdditionalTehsilFeed(
          tagId: additionalTehsils[i].place.tag.id,
          additionalTehsil: additionalTehsils[i]));
    }
  }

  /// Dynamically get tab count
  int get getTabCount {
    int tabCount = 0;
    if (userHasAdditionalTehsils)
      tabCount = Services.globalDataNotifier.additionalTehsilList.value.length;

    if (showSarpanchTab) tabCount++;
    tabCount = tabCount + 2;
    return tabCount;
  }

  /// Should list be scrollable
  bool get shouldTabbarScrollable {
    return getTabCount >= 4;
  }

  tabControllerListener() async {
    if (tabController.index == 1) {
      await rajasthanNewsTour.markTourComplete();
      print("marked complete state news tab");
    }
  }

  @override
  void dispose() {
    tabController.removeListener(tabControllerListener);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    initialiseTabs();

    return WillPopScope(
      onWillPop: () async {
        if (widget.mainScreenPageController.page.ceil() != 0) {
          return true;
        }
        if (tabController.index == 0) {
          return true;
        } else {
          tabController.animateTo(0);
          return false;
        }
      },
      child: Scaffold(
        drawer: MyCustomDrawer(),
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: Builder(builder: (context) {
            return InkWell(
              child: SizedBox(
                height: context.safePercentHeight * 2.8,
                child: Icon(
                  Icons.menu,
                  color: maroonColor,
                ),
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              onLongPress: () async {
                context.vxNav.push(Uri.parse(MyRoutes.developerScreen));
              },
            );
          }),
          bottom: TabBar(
            isScrollable: shouldTabbarScrollable,
            controller: tabController,
            labelColor: Colors.black,
            labelStyle: labelTextStyle,
            unselectedLabelStyle: TextStyle(
              color: Theme.of(context).textTheme.headline1.color,
            ),
            tabs: tabs,
          ),
          actions: [
            AdditionalTehsilButton(),
          ],
          title: MainScreenAppBarTitle(),
        ),
        body: TabBarView(
          controller: tabController,
          children: tabBarViewChildren,
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                performWriteOperationAfterConditionsCheck(
                  context: context,
                  registrationInstructionText:
                      REGISTRATION_MESSAGE_BEFORE_POST_CREATION,
                  writeOperation: () {
                    context.vxNav.push(Uri.parse(MyRoutes.selectPostTag));
                  },
                );
              },
              child: FloatingActionButtonToCreatePost(),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                FlutterShareMe().shareToWhatsApp(
                  msg: referralSentence + "\n" + whatsappShareDynamicLink,
                );
                AnalyticsService.firebaseAnalytics.logEvent(
                  name: 'share_app_on_whatsapp',
                );
              },
              child: Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.green,
                size: 42,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initialiseTabs() {
    labelTextStyle = Theme.of(context).textTheme.headline4.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        );
    rajasthanNewsTabIcon = Text(
      GetPlaceName.getPlaceName(
              Services.globalDataNotifier.localUser.state_place, context)
          .toString(),
      style: labelTextStyle,
      textAlign: TextAlign.center,
    );

    additionalTabs = <Widget>[];

    /// If there are any additonal tabs then we add it here
    if (userHasAdditionalTehsils) {
      for (int i = 0; i < additionalTehsilFeedList.length; i++) {
        /// Getting place name according to user language
        String placeName = GetPlaceName.getPlaceName(
            additionalTehsilFeedList[i].additionalTehsil.place, context);

        /// Adding all the additional tehsil tabs
        additionalTabs.add(InkWell(
          onTap: () {
            if (tabController.index == i + 1) {
              additionalTehsilFeedList[i].scrollToTop();
            } else {
              tabController.animateTo(i + 1);
            }
          },
          child: Tab(
            icon: Text(
              placeName,
              style: labelTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ));
      }

      //     additionalTehsilFeedList.map<Widget>((addtionalTehsilFeed) {

    }

    tabs = <Widget>[
      InkWell(
        onTap: () {
          if (tabController.index == 0) {
            Services.globalDataNotifier.homeFeed.scrollToTop();
          } else {
            tabController.animateTo(0);
          }
        },
        child: Tab(
          icon: Text(
            MY_AREA.tr(),
            style: labelTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      ...additionalTabs,
      InkWell(
        onTap: () {
          if (tabController.index == additionalTehsilFeedList.length + 1) {
            Services.globalDataNotifier.rajasthanFeed.scrollToTop();
          } else {
            tabController.animateTo(additionalTehsilFeedList.length + 1);
          }
          tabController.animateTo(additionalTehsilFeedList.length + 1);
        },
        child: VisibilityDetector(
          key: rajasthanNewsTabKey,
          child: MyDescribedFeatureOverlay(
            featureId: rajasthanNewsTour.id,
            tapTarget: rajasthanNewsTabIcon,
            contentLocation: ContentLocation.below,
            child: Tab(
              icon: rajasthanNewsTabIcon,
            ),
            tour: rajasthanNewsTour,
            onComplete: () async {
              tabController.animateTo(1);
              await rajasthanNewsTour.markTourComplete();
              AnalyticsService.firebaseAnalytics
                  .logEvent(name: 'tour_complete', parameters: {
                'id': rajasthanNewsTour.id.toString(),
              });

              Tour professionalTabTour = TourDataStorage.getTour(
                  TourDataStorage.PROFESSIONAL_TAB_TOUR);
              professionalTabTour.showTour(context);
              return true;
            },
          ),
          onVisibilityChanged: rajasthanNewsTour.onVisibilityChanged,
        ),
      ),
    ];

    tabBarViewChildren = <Widget>[];

    /// Adding MyArea tab to the array
    tabBarViewChildren.add(PostFeed(
      feed: Services.globalDataNotifier.homeFeed,
      child: RemoteConfigService.topSnackBarConfig["showSnackBar"]
          ? TopSnackBar(
              topSnackBarConfig: RemoteConfigService.topSnackBarConfig)
          : Container(),
    ));

    /// Addding other tabs to array`
    if (userHasAdditionalTehsils) {
      for (int i = 0; i < additionalTehsilFeedList.length; i++) {
        tabBarViewChildren.add(PostFeed(feed: additionalTehsilFeedList[i]));
      }
    }

    /// Adding state tab to the array
    tabBarViewChildren.add(StateTab());

    // tabBarViewChildren = <Widget>[
    //   PostFeed(feed: Services.globalDataNotifier.homeFeed),
    //   StateTab(),
    // ];

    if (showSarpanchTab) {
      tabs.add(
        Tab(
          icon: Text(
            SARPANCH_LIST.tr(),
            style: labelTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      );

      tabBarViewChildren.add(SarpanchTab(
        tabController: tabController,
      ));
    }
  }
}
