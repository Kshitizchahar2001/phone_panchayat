// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';

class LoadingMorePosts extends StatefulWidget {
  @override
  _LoadingMorePostsState createState() => _LoadingMorePostsState();
}

class _LoadingMorePostsState extends State<LoadingMorePosts>
    with AutomaticKeepAliveClientMixin {
  @override
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Align(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(maroonColor),
      ),
    ));
  }
}
