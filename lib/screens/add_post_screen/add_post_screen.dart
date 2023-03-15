// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_new, curly_braces_in_flow_control_structures, prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/firestoreModels/postTag.dart';
import 'package:online_panchayat_flutter/models/Complaint.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/widgets/bottomBar.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/ui/mediaAttachment.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/mediaUploadData.dart';
import 'package:online_panchayat_flutter/screens/widgets/EnterAadhaarDialog/aadhaarRules.dart';
import 'package:online_panchayat_flutter/screens/widgets/EnterAadhaarDialog/enterAadhaarDialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/screens/widgets/outlineInputBorder.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/constants.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'addPostScreenData.dart';
import 'widgets/createPostButton.dart';

class AddPost extends StatefulWidget {
  AddPost({
    Key key,
    this.postData,
    this.complaint,
    this.postTag,
  }) : super(key: key);

  final PostData postData;
  final Complaint complaint;
  final PostTag postTag;

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController contentTextEditingController;
  GlobalDataNotifier globalDataNotifier;
  User _localUser;
  AddPostScreenData addPostScreenData;

  @override
  void initState() {
    contentTextEditingController = TextEditingController();
    globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    _localUser = globalDataNotifier.localUser;
    addPostScreenData = createAddPostScreenDataInstance();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!AadhaarRules.isUserAllowedToPost(_localUser))
        showDialog(
          context: context,
          builder: (_) => Material(
            type: MaterialType.transparency,
            child: Center(
              child: Padding(
                padding: getPostWidgetSymmetricPadding(context),
                child: new EnterAadhaarDialog(),
              ),
            ),
          ),
        );
    });
    super.initState();
  }

  createAddPostScreenDataInstance() {
    var postScreenData = AddPostScreenData(
      controller: contentTextEditingController,
    );

    if (widget.postData != null)
      postScreenData.initialise(widget.postData);
    else if (widget.postTag != null) {
      postScreenData.postTag = widget.postTag;
    }

    return postScreenData;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addPostScreenData,
      builder: (context, child) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            actions: [
              CreatePostButton(
                globalDataNotifier: globalDataNotifier,
                addPostScreenData: addPostScreenData,
              )
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_sharp,
              ),
              onPressed: () => {Navigator.pop(context)},
              color: KThemeLightGrey,
            ),
            centerTitle: true,
            title: Text(
              START_PANCHAYAT,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.m)),
            ).tr(),
            titleSpacing: 0.0,
          ),
          body: Responsive(
            mobile: ResponsiveAddPost(
              contentTextEditingController: contentTextEditingController,
              localUser: _localUser,
            ),
            tablet: ResponsiveAddPost(
              contentTextEditingController: contentTextEditingController,
              localUser: _localUser,
            ),
            desktop: ResponsiveAddPost(
              contentTextEditingController: contentTextEditingController,
              localUser: _localUser,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    contentTextEditingController.dispose();
    addPostScreenData.dispose();
    super.dispose();
  }
}

class ResponsiveAddPost extends StatefulWidget {
  final TextEditingController contentTextEditingController;
  final User localUser;
  ResponsiveAddPost({this.contentTextEditingController, this.localUser});

  @override
  _ResponsiveAddPostState createState() => _ResponsiveAddPostState();
}

class _ResponsiveAddPostState extends State<ResponsiveAddPost> {
  AddPostScreenData addPostScreenData;
  @override
  void initState() {
    addPostScreenData = Provider.of<AddPostScreenData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.2, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.safePercentHeight * 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        widget.localUser.image != null
                            ? CircleAvatar(
                                radius: context.safePercentHeight * 3.5,
                                backgroundColor: Colors.white,
                                foregroundImage:
                                    NetworkImage(widget.localUser.image))
                            : Container(),
                        SizedBox(
                          width: context.safePercentWidth * 3,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.localUser.name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.m),
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: context.safePercentHeight * 2,
                    ),
                    Divider(
                      color: KThemeLightGrey,
                      height: 1,
                      indent: context.safePercentWidth * 2,
                      endIndent: context.safePercentWidth * 2,
                    ),
                    ResponsiveHeight(
                      heightRatio: 2,
                    ),
                    TextField(
                      controller: widget.contentTextEditingController,
                      // style:
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.m)),
                      decoration: InputDecoration(
                        hintText: START_CONVERSATION.tr(),
                        enabledBorder: textFormFieldBorder(),
                        focusedBorder: textFormFieldBorder(),
                        errorBorder: textFormFieldBorder(),
                        focusedErrorBorder: textFormFieldBorder(),
                      ),
                      scrollPadding: EdgeInsets.all(20.0),
                      keyboardType: TextInputType.multiline,
                      autofocus: true,
                      maxLines: null,
                    ),
                    SizedBox(
                      height: context.safePercentHeight * 4,
                    ),
                    Consumer<AddPostScreenData>(
                      builder: (context, value, child) {
                        return mediaColumn();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          BottomBar()
        ],
      ),
    );
  }

  Widget mediaColumn() {
    return Column(
      children: [
        MediaAttachment(
          mediaUploadData: addPostScreenData.video,
        ),
        SizedBox(
          height: 5,
        ),
        MediaAttachment(
          mediaUploadData: addPostScreenData.image,
        ),
        SizedBox(
          height: context.safePercentHeight * 4,
        ),
        for (MediaUploadData imageData in addPostScreenData.images)
          Column(
            children: [
              MediaAttachment(
                mediaUploadData: imageData,
              ),
              SizedBox(
                height: context.safePercentHeight * 4,
              ),
            ],
          )
      ],
    );
  }
}
