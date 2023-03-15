// ignore_for_file: file_names, curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/tour.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/tourDataStorage.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';

class MainScreenData extends ChangeNotifier {
  PageController pageController;
  int oldPageIndex = 0;
  int newPageIndex;
  GlobalDataNotifier globalDataNotifier;
  Tour professionalTabTour;
  Tour rajasthanNewsTour;

  MainScreenData({
    @required this.pageController,
    @required this.globalDataNotifier,
  }) {
    pageController.addListener(listenPageController);
    professionalTabTour =
        TourDataStorage.getTour(TourDataStorage.PROFESSIONAL_TAB_TOUR);
    rajasthanNewsTour =
        TourDataStorage.getTour(TourDataStorage.RAJASTHAN_NEWS_TOUR);
  }

  listenPageController() {
    newPageIndex = pageController.page.toInt();
    if (oldPageIndex != newPageIndex) {
      oldPageIndex = newPageIndex;
      notifyListeners();
    }
  }

  performAdditionalOperationsForASpecificPage(
      int newIndex, int currentIndex) async {
    if (newIndex == 0 &&
        currentIndex ==
            newIndex) // if home icon is Tapped & user was already on home
    {
      globalDataNotifier.homeFeed.scrollToTop();
    } else if (newIndex == 1) {
      if (!professionalTabTour.isTourComplete)
        await professionalTabTour.markTourComplete();
    }
  }

  void registerCurrentScreenInAnalytics(int pageIndex) {
    switch (pageIndex) {
      case 0:
        globalDataNotifier.mainScreenTab = MyRoutes.feedsPage;
        AnalyticsService.setCurrentScreenOnPush(MyRoutes.feedsPage);
        break;
      case 1:
        globalDataNotifier.mainScreenTab = MyRoutes.professionalsTab;
        AnalyticsService.setCurrentScreenOnPush(MyRoutes.professionalsTab);
        break;
      default:
    }
  }

  void showProfessionalTour(BuildContext context) {
    if (rajasthanNewsTour.isTourComplete &&
        !professionalTabTour.isTourComplete) {
      professionalTabTour.showTour(context);
    }
  }
}
