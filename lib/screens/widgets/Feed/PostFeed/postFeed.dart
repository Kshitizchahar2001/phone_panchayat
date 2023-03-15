// ignore_for_file: file_names, overridden_fields, annotate_overrides, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/widgets/banner/Data/banner_post_data.dart';
import 'package:online_panchayat_flutter/screens/widgets/banner/bannerWidget.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:provider/provider.dart';

import '../feedWidget.dart';
import 'PostData/PostData.dart';
import 'Widgets/postCardWidget.dart';

class PostFeed extends FeedWidget {
  final Feed feed;
  final Widget child;
  PostFeed({
    @required this.feed,
    this.child,
  }) : super(feed: feed, child: child);

  @override
  Widget getItem(
    int index,
    GlobalDataNotifier globalDataNotifier,
    Feed feed,
  ) {
    PostData _postData =
        globalDataNotifier.postReservoir[feed.latestListOfPostId()[index]];
    if (_postData.post.id.contains(BANNER))
      return BannerWidget(
          bannerPostData: BannerPostData(
        post: _postData.post,
        version: _postData.version,
      ));
    return ChangeNotifierProvider<PostData>.value(
      value: _postData,
      builder: (context, child) {
        return PostCardWidget(
          postData: Provider.of<PostData>(context, listen: false),
          globalDataNotifier: globalDataNotifier,
          index: index,
          feed: feed,
          key: ValueKey(Provider.of<PostData>(context, listen: false).post.id),
        );
      },
    );
  }
}
