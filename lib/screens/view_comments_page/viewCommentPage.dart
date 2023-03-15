// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/view_comments_page/comment_field.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/Widgets/circularIndicator_comments.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewComments extends StatefulWidget {
  final PostData postData;

  const ViewComments({Key key, this.postData}) : super(key: key);
  @override
  _ViewCommentsState createState() => _ViewCommentsState();
}

class _ViewCommentsState extends State<ViewComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: view_comment,
      ),
      body: Responsive(
        mobile: ResponsiveViewComment(
          postData: widget.postData,
        ),
        tablet: ResponsiveViewComment(
          postData: widget.postData,
        ),
        desktop: ResponsiveViewComment(
          postData: widget.postData,
        ),
      ),
    );
  }
}

class ResponsiveViewComment extends StatefulWidget {
  final PostData postData;
  const ResponsiveViewComment({Key key, this.postData}) : super(key: key);

  @override
  _ResponsiveViewCommentState createState() => _ResponsiveViewCommentState();
}

class _ResponsiveViewCommentState extends State<ResponsiveViewComment> {
  @override
  void initState() {
    widget.postData.refreshComment();
    super.initState();
  }

  int itemCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ChangeNotifierProvider.value(
            value: widget.postData,
            builder: (context, child) {
              return Consumer<PostData>(
                builder: (context, value, child) {
                  itemCount = widget.postData.commentList.length + 1;
                  return RefreshIndicator(
                    color: maroonColor,
                    onRefresh: () => widget.postData.refreshComment(),
                    child: itemCount > 1
                        ? ListView.builder(
                            // controller: _controller,
                            itemCount: itemCount,
                            itemBuilder: _itemBuilder,
                          )
                        : Center(
                            child: Text(
                              "कोई टिप्पड़ियां नहीं है",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                    // color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            ).tr(),
                          ),
                  );
                },
              );
            },
          ),
        ),
        CommentField(
          postId: widget.postData.post.id,
          refresh: widget.postData.refreshComment,
        ),
      ],
    );
  }

  Widget _itemBuilder(context, index) {
    if (index < widget.postData.commentList.length) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: getPostWidgetSymmetricPadding(context,
                horizontal: 0, vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  // radius: context.safePercentHeight * 3.2,
                  backgroundColor: Colors.white,
                  foregroundImage:
                      widget.postData.commentList[index].user.image != null
                          ? NetworkImage(
                              widget.postData.commentList[index].user.image)
                          : null,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: getPostWidgetSymmetricPadding(context,
                      horizontal: 0, vertical: 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "${widget.postData.commentList[index].user.name} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.m),
                                  ),
                            ),
                            TextSpan(
                              text: widget.postData.commentList[index].content,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      (widget.postData.commentList[index].imageURL == null)
                          ? Container()
                          : showImage(
                              widget.postData.commentList[index].imageURL),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: KThemeLightGrey,
            height: 1,
          ),
        ],
      );
    } else {
      if (widget.postData.hasMoreComment) {
        return LoadingComment(
          postData: widget.postData,
        );
      } else {
        return Container();
      }
    }
  }

  showImage(String imageURL) {
    return Column(
      children: [
        SizedBox(
          height: context.safePercentHeight * .4,
        ),
        ZoomOverlay(
          twoTouchOnly: true,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(imageURL),
          ),
        ),
      ],
    );
  }
}
