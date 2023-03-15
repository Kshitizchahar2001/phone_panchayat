// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures, deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/loading_splash_screen.dart';
import 'package:online_panchayat_flutter/screens/widgets/ScrollToTop/scrollToTop.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'PostFeed/Widgets/loadingMorePosts.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class FeedWidget extends StatefulWidget {
  final Feed feed;
  final Widget child;
  FeedWidget({
    @required this.feed,
    this.child,
  });
  Widget getItem(
    int index,
    GlobalDataNotifier globalDataNotifier,
    Feed feed,
  );
  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget>
    with AutomaticKeepAliveClientMixin<FeedWidget> {
  @override
  bool get wantKeepAlive => true;
  GlobalDataNotifier _globalDataNotifier;
  int itemCount;
  List<int> adIndex = [];

  @override
  void initState() {
    adIndex = <int>[4];
    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    if (widget.feed.listOfPostId.isEmpty) widget.feed.refreshData();
    super.initState();
  }

  addRandomAdIndex() {
    int last = adIndex.last;
    int val = last + Random().nextInt(3) + 2;
    adIndex.add(val);
    print(adIndex);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    if (adIndex.last <= index) addRandomAdIndex();
                    if (adIndex.contains(index)) {
                      // return FLutterNativeAdmobWidget();
                    }
                    return const SizedBox();
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: itemCount,
                  cacheExtent: 3.0 * context.safePercentHeight * 100,
                  itemBuilder: _itemBuilder,
                  controller: widget.feed.controller,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (widget.child != null && index == 0) return widget.child;

    if (index >= widget.feed.latestListOfPostId().length &&
        !(widget.child != null &&
            index == widget.feed.latestListOfPostId().length)) {
      if (widget.feed.hasMoreData) {
        if (index == 0)
          return Container(
            height: context.safePercentHeight * 100,
            child: LoadingSplashScreen(),
          );
        else
          return LoadingMorePosts();
      } else {
        if (index == 0) {
          return Container(
            height: 600,
            // height: context.safePercentHeight * 1,
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
    } else
      return widget.getItem(
        index - widget.feed.postAdjustmentNumber,
        _globalDataNotifier,
        widget.feed,
      );
  }
}
