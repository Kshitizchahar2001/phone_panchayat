// ignore_for_file: file_names, overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/LocalIssueFeed/localIssueData/localIssueData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/Widgets/postCardWidget.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:provider/provider.dart';
import '../feedWidget.dart';

class LocalIssueFeed extends FeedWidget {
  final Feed feed;
  LocalIssueFeed({
    @required this.feed,
  }) : super(feed: feed);

  @override
  Widget getItem(
    int index,
    GlobalDataNotifier globalDataNotifier,
    Feed feed,
  ) {
    return Provider<LocalIssueData>.value(
      value: globalDataNotifier
          .localIssueDataReservoir[feed.latestListOfPostId()[index]],
      builder: (context, child) {
        return ChangeNotifierProvider<PostData>.value(
          value: globalDataNotifier
              .localIssueDataReservoir[feed.latestListOfPostId()[index]]
              .postData,
          builder: (context, child) {
            return PostCardWidget(
              postData: Provider.of<PostData>(context, listen: false),
              globalDataNotifier: globalDataNotifier,
              index: index,
              feed: feed,
              key: ValueKey(
                  Provider.of<PostData>(context, listen: false).post.id),
            );
          },
        );
      },
    );
  }
}
