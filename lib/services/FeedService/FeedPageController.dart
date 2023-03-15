// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/FeedService/singlePageFeed.dart';
import 'feedInterface.dart';
import 'package:flutter/cupertino.dart';

abstract class FeedPageController extends ChangeNotifier
    implements FeedInterface {
  ScrollController controller;

  Duration scrollDuration;
  bool hasMoreData = true;

  FeedPageController() {
    scrollDuration = Duration(milliseconds: 200);

    controller = ScrollController();
    controller.addListener(scrollControllerListener);
  }

  scrollControllerListener() {
    queryForMorePosts();
  }

  // ignore: annotate_overrides
  scrollToTop() {
    controller.animateTo(
      controller.position.minScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  queryForMorePosts() async {
    if (this is SinglePageFeed) return;
    if (controller.position.maxScrollExtent == controller.position.pixels &&
        !isUpdatePostInProgress() &&
        hasMoreData) {
      print("querying next");
      await addMorePosts().then((value) => queryForMorePosts());
    }
  }
}
