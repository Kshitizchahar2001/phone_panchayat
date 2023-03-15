// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/DesignatedUserData/designatedUserData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/Widgets/loadingMorePosts.dart';
import 'package:online_panchayat_flutter/screens/widgets/ScrollToTop/scrollToTop.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class DesignatedUsersFeed extends StatefulWidget {
  final Feed feed;
  DesignatedUsersFeed({
    @required this.feed,
  });
  Widget getCard(
    GlobalDataNotifier globalDataNotifier,
    int index,
  );

  @override
  _DesignatedUsersFeedState createState() => _DesignatedUsersFeedState();
}

class _DesignatedUsersFeedState extends State<DesignatedUsersFeed> {
  @override
  void initState() {
    if (widget.feed.listOfPostId.isEmpty) widget.feed.refreshData();
    super.initState();
  }

  Widget getItem(
    int index,
    GlobalDataNotifier globalDataNotifier,
    Feed feed,
  ) {
    return ChangeNotifierProvider<DesignatedUserData>.value(
      value: globalDataNotifier
          .designatedUserDataReservoir[feed.latestListOfPostId()[index]],
      builder: (context, child) {
        return widget.getCard(globalDataNotifier, index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int itemCount;

    return ChangeNotifierProvider<Feed>.value(
      value: widget.feed,
      builder: (context, child) {
        return Consumer<Feed>(
          builder: (context, value, child) {
            itemCount = widget.feed.getItemCount();

            return RefreshIndicator(
                color: maroonColor,
                onRefresh: () => widget.feed.refreshData(),
                child: ScrollToTop(
                  scrollController: widget.feed.controller,
                  bottomPadding: 50,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: itemCount,
                    cacheExtent: 4 * context.safePercentHeight * 100,
                    itemBuilder: _itemBuilder,
                    controller: widget.feed.controller,
                  ),
                ));
          },
        );
      },
    );
  }

  Widget _itemBuilder(context, index) {
    if (index >= widget.feed.latestListOfPostId().length) {
      if (widget.feed.hasMoreData) {
        return LoadingMorePosts();
      } else {
        if (index == 0) {
          return SizedBox(
            height: 500,
            // height: context.safePercentHeight * 100,
            child: Center(
              child: Text(
                widget.feed.noDataAvailableMessage.toString(),
                style: Theme.of(context).textTheme.headline3.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                    ),
              ).tr(),
            ),
          );
        } else
          return Container();
      }
    }
    return getItem(
      index,
      Services.globalDataNotifier,
      widget.feed,
    );
  }
}
