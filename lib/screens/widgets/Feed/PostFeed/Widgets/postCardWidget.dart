// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/Widgets/mediaWidget.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:provider/provider.dart';
import 'InteractiveBar.dart';
import 'postContent.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class PostCardWidget extends StatefulWidget {
  final int index;
  final PostData postData;
  final GlobalDataNotifier globalDataNotifier;
  final Feed feed;

  PostCardWidget(
      {@required this.postData,
      @required this.globalDataNotifier,
      @required this.index,
      @required this.feed,
      Key key})
      : super(key: key);

  @override
  _PostCardWidgetState createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  bool isDarkTheme;
  bool showSliderWidget;

  @override
  void initState() {
    isDarkTheme =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeEnabled;

    super.initState();
  }

  final double heightXs = 2.0;
  final double heightS = 4.0;
  final double heightM = 6.0;
  final double heightL = 14.0;
  final double heightXL = 20.0;

  @override
  Widget build(BuildContext context) {
    showSliderWidget = widget.postData.mediaItemsCount > 0;

    widget.postData.createView();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: heightXL,
          ),
          (showSliderWidget)
              ? Padding(
                  padding: getPostWidgetSymmetricPadding(context,
                      vertical: 0, horizontal: 3),
                  child: Consumer<PostData>(
                    builder: (context, value, child) {
                      return MediaWidget(
                        postData: widget.postData,
                      );
                    },
                  ),
                )
              : Container(),
          SizedBox(
            height: 2 * heightS,
          ),
          Padding(
            padding: getPostWidgetSymmetricPadding(
              context,
              vertical: 0,
              horizontal: 3,
            ),
            child: PostContent(
              postData: widget.postData,
              feed: widget.feed,
              key: ValueKey(widget.postData.post.id),
            ),
          ),
          SizedBox(
            height: heightS,
          ),
          Padding(
            padding: getPostWidgetSymmetricPadding(context,
                vertical: 0, horizontal: 3),
            child: InteractiveBar(
              feed: widget.feed,
              isDarkTheme: isDarkTheme,
              postData: widget.postData,
              index: widget.index,
            ),
          ),
          SizedBox(
            height: heightL,
          ),
          Divider(
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}

enum PopUpMenuOption { Edit, Delete }
