// ignore_for_file: file_names, prefer_const_constructors_in_immutables, deprecated_member_use, avoid_function_literals_in_foreach_calls

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/feedType.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/screens/widgets/linkify/linkify.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class PostContent extends StatefulWidget {
  final PostData postData;
  final Feed feed;
  PostContent({@required this.postData, this.feed, Key key}) : super(key: key);

  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  List<TextSpan> list;
  bool isThisSinglePostView;

  @override
  Widget build(BuildContext context) {
    list = [];
    isThisSinglePostView = (widget.feed.feedType == FeedType.SinglePost);
    getTextSpan(
      context,
    );
    addSeeMoreIfRequired(context);

    return RichText(
      text: TextSpan(
        children: list,
      ),
    );
  }

  addSeeMoreIfRequired(BuildContext context) {
    if (!(widget.feed.feedType == FeedType.SinglePost) &&
        (widget.postData.showSeeMore)) {
      list.add(TextSpan(
        style: Theme.of(context).textTheme.headline5.copyWith(
              fontWeight: FontWeight.normal,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s10),
            ),
        text: SeeMore.tr(),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            widget.feed.showSinglePost(context, widget.postData.post.id);
          },
      ));
    }
  }

  void getTextSpan(BuildContext context) {
    int elementsAdded = 0;
    int totalTextLengthAdded = 0;
    String elementText;
    widget.postData.postContentTextElements.forEach((element) {
      elementText = element.text;
      if (elementsAdded >=
              widget.postData.maximumNumberOfLinkifyElementsInFeedPage &&
          !isThisSinglePostView) {
        return;
      }

      if (!isThisSinglePostView &&
          elementsAdded ==
              widget.postData.maximumNumberOfLinkifyElementsInFeedPage - 1) {
        //get length of all added text;
        int remainingLength =
            widget.postData.maximumTextLength - totalTextLengthAdded;

        if (remainingLength <= 0) {
          elementText = "";
          widget.postData.showSeeMore = true;
        } else if (elementText.length > remainingLength) {
          elementText = elementText.substring(0, remainingLength);
          widget.postData.showSeeMore = true;
        }
      }

      elementsAdded++;
      totalTextLengthAdded += elementText.length;

      if (element is LinkableElement) {
        // links.add(SocialMediaVideoLink(link: element.url));
        list.add(TextSpan(
          style: Theme.of(context).textTheme.headline1.copyWith(
              fontWeight: FontWeight.normal,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m),
              color: Colors.blue),
          text: elementText,
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final url = element.url;
              if (await canLaunch(url)) {
                await launch(
                  url,
                  forceSafariVC: false,
                );
                AnalyticsService.firebaseAnalytics
                    .logEvent(name: "post_description_link_open", parameters: {
                  "link": url,
                  "post_id": widget.postData.post.id,
                  "post_owner_id": widget.postData.post.user.id,
                });
              }
            },
        ));
      } else {
        list.add(TextSpan(
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
                // responsiveFontSize(context, size: ResponsiveFontSizes.m),
              ),
          text: elementText,
        ));
      }
    });
  }
}
