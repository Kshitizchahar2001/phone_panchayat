// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/postFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class MyPosts extends StatefulWidget {
  final Feed feedType;
  MyPosts({this.feedType});
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getPageAppBar(
          context: context,
          text: MY_POSTS,
        ),
        body: PostFeed(
          feed: widget.feedType,
        ));
  }
}
