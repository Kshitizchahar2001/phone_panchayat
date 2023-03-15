// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/utils/zoomPinchOverlay.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:easy_localization/easy_localization.dart';

class CommentSection extends StatefulWidget {
  final PostData postData;
  // final Function onViewAllCommentsClicked;
  final Feed feed;
  final Function showSinglePost;

  CommentSection(
      {this.postData,
      // this.onViewAllCommentsClicked,
      this.feed,
      this.showSinglePost});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  int totalNoOfComments = 0;
  int numberOfCommentsDisplayed;

  @override
  Widget build(BuildContext context) {
    numberOfCommentsDisplayed = (widget.postData.post.comments == null)
        ? 0
        : (widget.postData.post.comments.length < 2)
            ? widget.postData.post.comments.length
            : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < numberOfCommentsDisplayed; i++)
              InkWell(
                onTap: () {
                  if (widget.feed.feedType == FeedType.SinglePost)
                    context.vxNav.push(Uri.parse(MyRoutes.profileRoute),
                        params: widget.postData.post.comments[i].user);
                  else {
                    widget.showSinglePost();
                  }
                },
                child: Padding(
                    padding: getPostWidgetSymmetricPadding(context,
                        horizontal: 0, vertical: 0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(children: [
                            TextSpan(
                              text:
                                  "${widget.postData.post.comments[i].user?.name} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            ),
                            TextSpan(
                              text: widget.postData.post.comments[i].content,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            ),
                          ]),
                        ),
                        (widget.postData.post.comments[i].imageURL == null)
                            ? Container()
                            : showImage(
                                widget.postData.post.comments[i].imageURL),
                      ],
                    )

                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Flexible(
                    //       flex: 3,
                    //       child: Text(
                    //         "${widget.postData.post.comments[i].user.name} : ",
                    //         style:
                    //             Theme.of(context).textTheme.headline4.copyWith(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: responsiveFontSize(context,
                    //                       size: ResponsiveFontSizes.s),
                    //                 ),
                    //       ),
                    //     ),
                    //     Flexible(
                    //         flex: 4,
                    //         child: Text(
                    //           "${widget.postData.post.comments[i].content}",
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .headline4
                    //               .copyWith(
                    //                   fontWeight: FontWeight.normal,
                    //                   fontSize: responsiveFontSize(context,
                    //                       size: ResponsiveFontSizes.s)),
                    //         ))
                    //   ],
                    // ),
                    ),
              )
          ],
        ),
        SizedBox(
          height: context.safePercentHeight * .4,
        ),
        (numberOfCommentsDisplayed >= 2)
            ? InkWell(
                // onTap: widget.showSinglePost,
                onTap: () {
                  context.vxNav.push(
                      Uri.parse(
                        MyRoutes.viewComment,
                      ),
                      params: widget.postData);
                },
                child: Column(
                  children: [
                    Text(
                      VIEW_ALL_COMMENTS,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.xs10)),
                    ).tr(
                      args: [
                        // null
                        // totalNoOfComments.toString(),
                      ],
                    ),
                    SizedBox(
                      height: context.safePercentHeight * 1.5,
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  showImage(String imageURL) {
    return Column(
      children: [
        SizedBox(
          height: context.safePercentHeight * .4,
        ),
        ZoomOverlay(
          twoTouchOnly: true,
          child: Container(
            height: (widget.feed.feedType != FeedType.SinglePost) ? 20.0 : null,
            constraints:
                BoxConstraints(maxHeight: context.safePercentHeight * 50),
            child: Align(
              alignment: (widget.feed.feedType != FeedType.SinglePost)
                  ? Alignment.centerLeft
                  : Alignment.center,
              child: Image.network(imageURL),
            ),
          ),
        ),
      ],
    );
  }
}
