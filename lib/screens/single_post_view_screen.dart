// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/singlePostOpenSource.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/postFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class SinglePostView extends StatefulWidget {
  final String uniqueId;
  final SinglePostOpenSource singlePostOpenSource;
  SinglePostView({
    @required this.uniqueId,
    @required this.singlePostOpenSource,
  });
  @override
  _SinglePostViewState createState() => _SinglePostViewState();
}

class _SinglePostViewState extends State<SinglePostView> {
  Feed _feed;
  @override
  void initState() {
    _feed = Services.globalDataNotifier.singlePost;
    _feed.uniqueId = widget.uniqueId;
    try {
      logEvent();
    } catch (e, s) {
      String _exception =
          "Error logging event from single post view screen" + e.toString();
      FirebaseCrashlytics.instance.recordError(_exception, s);
    }
    super.initState();
  }

  void logEvent() {
    if (widget.singlePostOpenSource == SinglePostOpenSource.SHARE_LINK) {
      Services.analyticsService.registerAppLaunchByLinkEvent(
          isAuthenticated: Services.authStatusNotifier.isUserSignedIn,
          isRegistered: Services.globalDataNotifier.isUserRegistered);
    }
    Map<String, String> parameters = {
      "source": widget.singlePostOpenSource.toString().split(".").last,
      "post_id": widget.uniqueId,
    };
    AnalyticsService.firebaseAnalytics.logEvent(
      name: "single_post_open",
      parameters: parameters,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      // resizeToAvoidBottomInset: false,
      appBar: getPageAppBar(
        context: context,
        text: "View post",
      ),

      body: Responsive(
        mobile: PostFeed(
          feed: _feed,
        ),
        tablet: PostFeed(
          feed: _feed,
        ),
        desktop: PostFeed(
          feed: _feed,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _feed.uniqueId = null;
    _feed.listOfPostId = <String>[];
    super.dispose();
  }
}
