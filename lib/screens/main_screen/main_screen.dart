// ignore_for_file: use_key_in_widget_constructors, duplicate_ignore, prefer_const_constructors, empty_catches, curly_braces_in_flow_control_structures

// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/appUpdateStatus.dart';
import 'package:online_panchayat_flutter/models/AdditionalTehsil.dart';
import 'package:online_panchayat_flutter/screens/main_screen/appUpdateDialog.dart';
import 'package:online_panchayat_flutter/screens/main_screen/mainScreenData.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/find_professionals.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/Data/suppressedUrl.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/StoreGlobalData.dart';
import 'package:online_panchayat_flutter/screens/widgets/myDescribedFeatureOverlay.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/appUpdateService.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'homeTab.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: ResponsiveMainPage(),
        tablet: ResponsiveMainPage(),
        desktop: ResponsiveMainPage());
  }
}

class ResponsiveMainPage extends StatefulWidget {
  @override
  _ResponsiveMainPageState createState() => _ResponsiveMainPageState();
}

class _ResponsiveMainPageState extends State<ResponsiveMainPage> {
  int currentIndex = 0;
  PageController pageController;
  GlobalDataNotifier _globalDataNotifier;
  List<Widget> pageList;
  bool showSelectedLabels = true;
  bool showUnselectedLabels = false;
  bool isDarkTheme;
  MainScreenData mainScreenData;
  Widget professionalTabIcon;
  final double iconSize = 28.0;
  ValueKey professionalTabKey = ValueKey('professionalTabKey');
  AppUpdateService appUpdateService;
  AppUpdateStatus appUpdateStatus;

  @override
  void initState() {
    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    appUpdateService = Provider.of<AppUpdateService>(context, listen: false);
    isDarkTheme =
        Provider.of<ThemeProvider>(context, listen: false).getThemeMode ==
            ThemeMode.dark;

    pageController = PageController(initialPage: currentIndex);

    mainScreenData = MainScreenData(
        pageController: pageController,
        globalDataNotifier: _globalDataNotifier);

    mainScreenData.registerCurrentScreenInAnalytics(currentIndex);
    // mainScreenData.showProfessionalTour(context);
    // uncomment to show professional tab tour guide

    pageList = [
      ValueListenableBuilder(
          valueListenable: Services.globalDataNotifier.additionalTehsilList,
          builder: (BuildContext context, List<AdditionalTehsils> list,
              Widget child) {
            return HomeTab(
              mainScreenPageController: pageController,
              key: UniqueKey(),
            );
          }),

      /// Removing Matrimonial Section
      ///
      //MatrimonialSection(),
      // ChangeNotifierProvider<MatchesListData>(
      //   create: (_) => MatchesListData(lookingFor: LookingFor.GROOM),
      //   builder: (context, child) => MatchesList(),
      // ),
      FindProfessionals(),
    ];
    professionalTabIcon = Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Image(
        image: AssetImage(
          'assets/images/plumber.png',
        ),
        height: 26,
      ),
    );

    try {
      appUpdateStatus = RemoteConfigService.versionCheck();
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError("Error getting app update status : " + e, s);
    }

    appUpdateService.addListener(appUpdateListener);

    SuppressedUrl suppressedUrl =
        StoreGlobalData.suppressedUrlStorage.getData();
    if (suppressedUrl?.showWebPage == true && suppressedUrl.url != null) {
      StoreGlobalData.suppressedUrlStorage.remove();
      try {
        AnalyticsService.firebaseAnalytics
            .logEvent(name: 'show_web_page_from_notification', parameters: {
          'name': suppressedUrl?.name?.toString(),
          'url': suppressedUrl?.url?.toString(),
        });
      } catch (e) {}
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.vxNav.push(
          Uri.parse(MyRoutes.notificationLinkWebView),
          params: suppressedUrl,
        );
      });
    }

    super.initState();
  }

  void appUpdateListener() {
    if (appUpdateService.infoAvailable) {
      if (appUpdateStatus == AppUpdateStatus.OptionalUpdateAvailable &&
          appUpdateService.canStartFlexibleUpdate)
        appUpdateService.startFlexibleUpdate();
      else if (appUpdateStatus == AppUpdateStatus.ForceUpdateRequired &&
          appUpdateService.immediateUpdateAvailable) {
        RemoteConfigService.showForceUpdateVersionDialog(context);
      }
    } else {
      FirebaseCrashlytics.instance.log("Update info unavailable");
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    mainScreenData.dispose();
    appUpdateService.removeListener(appUpdateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainScreenData>.value(
      value: mainScreenData,
      builder: (context, child) {
        return WillPopScope(
          onWillPop: () async {
            if (pageController.page.ceil() == 0) {
              return true;
            } else {
              animateToPage(0);
              return false;
            }
          },
          child: Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  children: pageList,
                  controller: pageController,
                  onPageChanged: (int index) {
                    mainScreenData.registerCurrentScreenInAnalytics(index);
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                Consumer<AppUpdateService>(
                  builder: (context, value, child) {
                    if (value.canCompleteFlexibleUpdate &&
                        value.showCompleteUpdateDialog)
                      return AppUpdateDialog(appUpdateService: value);
                    else
                      return Container();
                  },
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: responsiveFontSize(context,
                      size: ResponsiveFontSizes.xs10)),
              currentIndex: currentIndex,
              showSelectedLabels: showSelectedLabels,
              showUnselectedLabels: showUnselectedLabels,
              onTap: onBottomNavigationBarItemTap,
              items: [
                BottomNavigationBarItem(
                  label: HOME.tr(),
                  icon: Icon(
                    Icons.home_rounded,
                    size: iconSize,
                    // color: Color(0xff940922),
                  ),
                ),
                //// Removing Bottom section
                ///
                // BottomNavigationBarItem(
                //   label: MATRIMONIAL.tr(),
                //   icon: Padding(
                //     padding: const EdgeInsets.only(bottom: 4.0),
                //     child: Image(
                //       image: AssetImage(
                //         'assets/images/matrimonail_icon.png',
                //       ),
                //       height: 26,
                //     ),
                //   ),
                // ),
                BottomNavigationBarItem(
                  label: SERVICES.tr(),
                  icon: VisibilityDetector(
                    key: professionalTabKey,
                    onVisibilityChanged:
                        mainScreenData.professionalTabTour.onVisibilityChanged,
                    child: MyDescribedFeatureOverlay(
                      featureId: mainScreenData.professionalTabTour.id,
                      tapTarget: professionalTabIcon,
                      child: professionalTabIcon,
                      tour: mainScreenData.professionalTabTour,
                      onComplete: () async {
                        onBottomNavigationBarItemTap(1);
                        AnalyticsService.firebaseAnalytics
                            .logEvent(name: 'tour_complete', parameters: {
                          'id':
                              mainScreenData.professionalTabTour.id.toString(),
                        });
                        return true;
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void onBottomNavigationBarItemTap(int index) async {
    setState(() {
      mainScreenData.performAdditionalOperationsForASpecificPage(
        index,
        currentIndex,
      );
      currentIndex = index;
      animateToPage(index);
    });
  }

  void animateToPage(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
