// ignore_for_file: deprecated_member_use, prefer_const_constructors, avoid_print

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/storageService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';

class CommentField extends StatefulWidget {
  final String postId;
  final Function refresh;
  const CommentField({
    Key key,
    @required this.postId,
    this.refresh,
  }) : super(key: key);

  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  TextEditingController commentTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  File pickedImage;

  GlobalDataNotifier _globalDataNotifier;
  GQLMutationService _gqlMutationService;
  User _localUser;

  @override
  void initState() {
    commentTextEditingController = TextEditingController();
    focusNode = FocusNode();

    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    _gqlMutationService =
        Provider.of<GQLMutationService>(context, listen: false);
    _localUser = _globalDataNotifier.localUser;
    super.initState();
  }

  @override
  void dispose() {
    commentTextEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (pickedImage != null)
                ? Flexible(
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: context.safePercentHeight * 25),
                      child: Padding(
                        padding: getPostWidgetSymmetricPadding(context),
                        child: RemovableWidget(
                          onRemoved: () {
                            pickedImage = null;
                            setState(() {});
                          },
                          child: Image(
                            image: Image.file(pickedImage).image,
                            // height: context.safePercentHeight * 10,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    readOnly: false,
                    controller: commentTextEditingController,
                    focusNode: focusNode,
                    cursorColor: KThemeLightGrey,
                    showCursor: true,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s),
                        fontWeight: FontWeight.normal),
                    maxLength: null,
                    maxLines: (true) ? null : 1,
                    decoration: InputDecoration(
                      // isDense: true,
                      border: InputBorder.none,
                      hintText: ADD_COMMENT.tr(),
                      hintStyle: Theme.of(context).textTheme.headline4.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s),
                          color: lightGreySubheading),
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                      enabledBorder: textFormFieldBorder(),
                      focusedBorder: textFormFieldBorder(),
                      errorBorder: textFormFieldBorder(),
                      focusedErrorBorder: textFormFieldBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          // print("Clicked");
                          getImage();
                        },
                        child: Icon(Icons.add_a_photo_rounded),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () async {
                          performWriteOperationAfterConditionsCheck(
                              registrationInstructionText:
                                  REGISTRATION_MESSAGE_BEFORE_CREATING_ANY_REACTION,
                              writeOperation: () async {
                                String content =
                                    commentTextEditingController.text;

                                if (content == "" && pickedImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        EMPTY_COMMENT_MESSAGE.tr(),
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                showMaterialDialog(context);

                                String imageURL;

                                if (pickedImage != null) {
                                  imageURL = await StorageService()
                                      .uploadCommentImageAndGetUrl(
                                          image: pickedImage,
                                          userId: _localUser.id);
                                }

                                setState(() {
                                  commentTextEditingController.clear();
                                  pickedImage = null;
                                  focusNode.unfocus();
                                });

                                try {
                                  await _gqlMutationService.createComment
                                      .createComment(
                                          postId: widget.postId,
                                          userId: _localUser.id,
                                          status: Status.ACTIVE,
                                          content: content,
                                          imageURL: imageURL)
                                      .then((value) => {
                                            AnalyticsService.firebaseAnalytics
                                                .logEvent(
                                                    name: 'comment_created',
                                                    parameters: {
                                                  "post_id": widget.postId,
                                                })
                                          });
                                  //refresh comments here
                                  await widget.refresh();
                                } catch (e, s) {
                                  FirebaseCrashlytics.instance
                                      .recordError(e, s);
                                }
                                Navigator.pop(context);
                              },
                              context: context);
                        },
                        child: Text(
                          POST,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s)),
                        ).tr(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: ((builder) => BottomSheetWidget((image) async {
              if (image != null) {
                cropImage(image.path);
              } else {
                print('No image selected.');
              }
            })));
  }

  cropImage(String imagePath) async {
    var croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 80,
    );

    setState(() {
      pickedImage = croppedImage as File;
    });
  }

  OutlineInputBorder textFormFieldBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).inputDecorationTheme.fillColor,
          // color: Color.fromRGBO(255, 255, 255, 1),
          width: 0.0,
        ),
        borderRadius: BorderRadius.circular(10));
  }
}
