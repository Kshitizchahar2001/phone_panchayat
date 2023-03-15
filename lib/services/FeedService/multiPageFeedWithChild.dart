// ignore_for_file: file_names, unnecessary_this, curly_braces_in_flow_control_structures

import 'package:online_panchayat_flutter/services/FeedService/multiPageFeed.dart';

abstract class MultiPageFeedWithChild extends MultiPageFeed {
  MultiPageFeedWithChild() {
    this.postAdjustmentNumber = 1;
  }
  @override
  int getItemCount() {
    int _itemCount = 0;
    if (latestListOfPostId() != null)
      _itemCount = latestListOfPostId().length + 2;
    return _itemCount;
  }
}
