// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, prefer_const_constructors, unnecessary_new, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/buttonType.dart';
import 'package:online_panchayat_flutter/enum/shareMethod.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/LocalIssueFeed/localIssueFeed.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/services/FeedService/Feeds/homeFeed.dart';
import 'package:online_panchayat_flutter/services/FeedService/feed.dart';
import 'package:online_panchayat_flutter/services/FeedService/singlePageFeed.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/humanizeNumber.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'likeButton.dart';
import 'menuItemTile.dart';
import 'nameAndDesignation.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

double likeIconSize = 20;
double whatsappIconSize = 22;
double menuIconSize = 16;
double iconCountSize = 15;

class InteractiveBar extends StatefulWidget {
  final bool isDarkTheme;
  final int index;
  final PostData postData;
  final Feed feed;

  InteractiveBar({
    this.postData,
    this.index,
    this.isDarkTheme,
    this.feed,
  });

  @override
  _InteractiveBarState createState() => _InteractiveBarState();
}

class _InteractiveBarState extends State<InteractiveBar> {
  InteractiveButtonModel whatsappShareButton;

  @override
  void initState() {
    whatsappShareButton = InteractiveButtonModel(
      icon: Icon(
        FontAwesomeIcons.whatsapp,
        color: Colors.green,
        size: whatsappIconSize,
      ),
      onPressed: () {
        widget.postData.sharePost.onShareButtonPressed(
          shareMethod: ShareMethod.Whatsapp,
        );
      },
      buttonType: ButtonType.Comment,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  if (widget.feed is HomeFeed ||
                      widget.feed is LocalIssueFeed ||
                      widget.feed is SinglePageFeed)
                    context.vxNav.push(Uri.parse(MyRoutes.profileRoute),
                        params: widget.postData.post.user);
                },
                child: NameAndDesignation(
                    postData: widget.postData, feed: widget.feed),
              ),
            ),
            SizedBox(
              width: 45,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LikeButton(
                  index: widget.index,
                  isDarkTheme: widget.isDarkTheme,
                  postData: widget.postData,
                  animateButtons: widget.postData.animateButtons,
                ),
                SizedBox(
                  width: 14,
                ),
                InteractiveBarButton(
                  eachInteractiveButtonModel: whatsappShareButton,
                ),
                SizedBox(
                  width: 14,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Material(
                        type: MaterialType.transparency,
                        child: Center(
                          child: Padding(
                            padding: getPostWidgetSymmetricPadding(context,
                                horizontal: 8),
                            child: new Container(
                                height: 200,
                                decoration: new BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: new BorderRadius.all(
                                      Radius.circular(20.0),
                                    )),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 18,
                                    ),
                                    child: Column(
                                      children: [
                                        MenuItemTile(
                                          text: COMMENTS.tr(),
                                          onTap: () {
                                            context.vxNav.push(
                                                Uri.parse(
                                                  MyRoutes.viewComment,
                                                ),
                                                params: widget.postData);
                                          },
                                          iconData: FontAwesomeIcons.commentAlt,
                                        ),
                                        MenuItemTile(
                                          text: 'फेसबुक पर शेयर करें',
                                          onTap: () {
                                            widget.postData.sharePost
                                                .onShareButtonPressed(
                                              shareMethod: ShareMethod.Facebook,
                                            );
                                          },
                                          iconData: FontAwesomeIcons.facebook,
                                          iconColor: Colors.blue,
                                        ),
                                        widget.postData
                                                .isPostOwnedByLoggedInUserOrAdministrator()
                                            ? MenuItemTile(
                                                text: EDIT.tr(),
                                                onTap: () {
                                                  context.vxNav.push(
                                                      Uri.parse(MyRoutes
                                                          .createPostRoute),
                                                      params: {
                                                        "postData":
                                                            widget.postData,
                                                      });
                                                },
                                                iconData: FontAwesomeIcons.edit,
                                              )
                                            : Container(),
                                        widget.postData
                                                .isPostOwnedByLoggedInUserOrAdministrator()
                                            ? MenuItemTile(
                                                text: DELETE.tr(),
                                                onTap: () async {
                                                  bool isPostDeleted;
                                                  isPostDeleted = await Services
                                                      .gqlMutationService
                                                      .updatePost
                                                      .deletePost(
                                                          postData:
                                                              widget.postData);

                                                  widget.feed.refreshData();

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      (isPostDeleted)
                                                          ? POST_DELETION_SUCCESSFUL
                                                          : POST_DELETION_FAILED,
                                                    ).tr(),
                                                  ));
                                                },
                                                iconData:
                                                    FontAwesomeIcons.trash,
                                                iconColor: Colors.red,
                                              )
                                            : Container(),
                                        MenuItemTile(
                                          text: REPORT.tr(),
                                          onTap: () async {
                                            await Future.delayed(
                                                Duration(seconds: 1));
                                            widget.feed.refreshData();

                                            Navigator.of(context).pop();

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text(REPORT_RECEIVED).tr(),
                                            ));
                                          },
                                          iconData: Icons.report,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    FontAwesomeIcons.ellipsisV,
                    color: Theme.of(context).textTheme.headline4.color,
                    // color: Colors.grey[400],
                    size: menuIconSize,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class InteractiveBarButton extends StatelessWidget {
  const InteractiveBarButton({
    Key key,
    @required this.eachInteractiveButtonModel,
  }) : super(key: key);

  final InteractiveButtonModel eachInteractiveButtonModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        eachInteractiveButtonModel.onPressed();
      },
      onLongPress: eachInteractiveButtonModel.onLongPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          eachInteractiveButtonModel.icon,
          eachInteractiveButtonModel.number != null
              ? getIconCount(context, eachInteractiveButtonModel.number)
              : Container(),
        ],
      ),
    );
  }
}

Widget getIconCount(BuildContext context, int number) {
  return Padding(
    padding: const EdgeInsets.only(left: 2.0),
    child: Text(
      humanizeIntInd(number).toString(),
      style: Theme.of(context)
          .textTheme
          .headline4
          .copyWith(fontWeight: FontWeight.normal, fontSize: iconCountSize),
    ),
  );
}

class InteractiveButtonModel {
  Widget icon;
  Function onPressed;
  ButtonType buttonType;
  int number;
  Function onLongPress;
  InteractiveButtonModel({
    @required this.icon,
    @required this.onPressed,
    @required this.buttonType,
    this.onLongPress,
    this.number,
  });
}
