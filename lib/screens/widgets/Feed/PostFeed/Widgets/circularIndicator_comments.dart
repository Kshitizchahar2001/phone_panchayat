// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';

class LoadingComment extends StatefulWidget {
  final PostData postData;

  const LoadingComment({Key key, this.postData}) : super(key: key);
  @override
  _LoadingCommentState createState() => _LoadingCommentState();
}

class _LoadingCommentState extends State<LoadingComment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.postData.updateList();
    super.initState();
  }

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
