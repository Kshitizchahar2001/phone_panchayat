// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/postFeed.dart';
import 'package:online_panchayat_flutter/services/services.dart';

import 'stateLiveNewsData.dart';
import 'storySection.dart';

class StateTab extends StatefulWidget {
  const StateTab({Key key}) : super(key: key);

  @override
  State<StateTab> createState() => _StateTabState();
}

class _StateTabState extends State<StateTab>
    with AutomaticKeepAliveClientMixin {
  StateLiveNewsData stateLiveNewsData;

  @override
  void initState() {
    stateLiveNewsData = StateLiveNewsData();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ValueListenableBuilder<bool>(
      valueListenable: stateLiveNewsData.loading,
      builder: (context, value, child) {
        if (value == true)
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(maroonColor),
            ),
          );
        else
          return PostFeed(
            feed: Services.globalDataNotifier.rajasthanFeed,
            child: (!stateLiveNewsData.dataFetched ||
                    stateLiveNewsData.list?.length == 0)
                ? Container()
                : StorySection(
                    list: stateLiveNewsData.list,
                  ),
          );
      },
    );
  }
}
