// ignore_for_file: file_names, constant_identifier_names, prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'tour.dart';

class TourDataStorage {
  static initialise() {
    _tours[PROFESSIONAL_TAB_TOUR].getData();
    _tours[RAJASTHAN_NEWS_TOUR].getData();
    _tours[REGISTER_AS_PROFESSIONAL_TOUR].getData();
  }

  static clearAllTourData() {
    _tours[PROFESSIONAL_TAB_TOUR].clearData();
    _tours[RAJASTHAN_NEWS_TOUR].clearData();
    _tours[REGISTER_AS_PROFESSIONAL_TOUR].clearData();
  }

  static const PROFESSIONAL_TAB_TOUR = "professional_tab_tour";
  static const RAJASTHAN_NEWS_TOUR = "rajasthan_news_tour";
  static const REGISTER_AS_PROFESSIONAL_TOUR = "register_as_professional_tour";

  static Tour getTour(String id) {
    return _tours[id];
  }

  static Map<String, Tour> _tours = {
    PROFESSIONAL_TAB_TOUR: Tour(
      id: PROFESSIONAL_TAB_TOUR,
      title: "कारीगर खोजें",
      description:
          "मजदूर,कारपेंटर,प्लम्बर,रिपेयरिंग एवं अन्य कारीगरों से समपर्क करें",
      key: GlobalKey(),
      delayDuration: Duration(seconds: 5),
    ),
    RAJASTHAN_NEWS_TOUR: Tour(
      id: RAJASTHAN_NEWS_TOUR,
      title: "देखें अपने राज्य की ताज़ा खबरें",
      description: "पाएं अपने राज्य से जुडी लाइव खबरें इस जगह पर",
      key: GlobalKey(),
      delayDuration: Duration(seconds: 5),
    ),
    REGISTER_AS_PROFESSIONAL_TOUR: Tour(
      id: REGISTER_AS_PROFESSIONAL_TOUR,
      title: "ग्राहकों से जुड़ें",
      description:
          "यदि आप भी एक पेशेवर है और नए ग्राहकों से जुड़ना चाहते है तो पंजीकरण करें",
      key: GlobalKey(),
    ),
  };
}
