// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, prefer_const_constructors, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/EnterAadhaarDialog/aadhaarRules.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';
import 'enterAadhaarDialog.dart';

class UploadAadhaarImageWidget extends StatefulWidget {
  final PageController pageController;
  final AadhaarInputData aadhaarInputData;
  final Function onSubmitted;
  final TextEditingController aadharNumberTextEditingController;

  UploadAadhaarImageWidget(
      {@required this.pageController,
      @required this.aadhaarInputData,
      @required this.aadharNumberTextEditingController,
      this.onSubmitted});

  @override
  _UploadAadhaarImageWidgetState createState() =>
      _UploadAadhaarImageWidgetState();
}

class _UploadAadhaarImageWidgetState extends State<UploadAadhaarImageWidget> {
  bool isAadharImageValid = true;
  aadhaarImageValidator() {
    if (widget.aadhaarInputData.pickedAadhaarImage == null &&
        AadhaarRules.isAadhaarImageMandatory)
      isAadharImageValid = false;
    else
      isAadharImageValid = true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.safePercentWidth * 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                widget.pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  0.0,
                  8.0,
                  8.0,
                  8.0,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).textTheme.headline2.color,
                ),
              ),
            ),
            // ResponsiveHeight(heightRatio: 2),
            HeadingAndSubheading(
              heading: AADHAAR_PHOTO, //image
              subheading:
                  "${YOUR_AADHAAR_NUMBER.tr()} ${widget.aadharNumberTextEditingController.text}\n${AADHAAR_PHOTO_DESCRIPTION.tr()}", //image
            ),
            ResponsiveHeight(heightRatio: 4),
            Text(
              AADHAAR_PHOTO,
              style: Theme.of(context).textTheme.headline3.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.s)),
            ).tr(),
            ResponsiveHeight(heightRatio: 2),
            InkWell(
              onTap: () => getImage(),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                Theme.of(context).textTheme.headline3.color)),
                    height: context.safePercentHeight * 20,
                    child: (widget.aadhaarInputData.pickedAadhaarImage != null)
                        ? Image(
                            image: Image.file(
                                    widget.aadhaarInputData.pickedAadhaarImage)
                                .image,
                          )
                        : Text(
                            "+ ${ADD_PHOTO.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s)),
                          ),
                  ),
                  (widget.aadhaarInputData.pickedAadhaarImage != null)
                      ? Positioned(
                          right: 2,
                          top: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.aadhaarInputData.pickedAadhaarImage =
                                    null;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.cancel,
                                color:
                                    Theme.of(context).textTheme.headline1.color,
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            ResponsiveHeight(
              heightRatio: 2,
            ),
            Text(
              WE_MAY_VERIFY_YOUR_ADDHAR_LATER, //image
              style: Theme.of(context).textTheme.headline3.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: responsiveFontSize(context,
                      size: ResponsiveFontSizes.xs10)),
            ).tr(),
            ResponsiveHeight(heightRatio: 2),
            (!isAadharImageValid)
                ? Text(
                    UPLOAD_IMAGE_ERROR_TEXT.tr(), //image
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.xs10),
                        color: Colors.red),
                  )
                : SizedBox(),

            ResponsiveHeight(heightRatio: 3),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DialogBoxButton(
                  text: SUBMIT,
                  onPressed: () async {
                    aadhaarImageValidator();
                    if (isAadharImageValid) {
                      widget.onSubmitted();
                    } else
                      setState(() {});
                  },
                ),
              ],
            ),
            ResponsiveHeight(heightRatio: 5),
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
                var croppedImage = await ImageCropper().cropImage(
                  sourcePath: image.path,
                );
                setState(() {
                  widget.aadhaarInputData.pickedAadhaarImage =
                      croppedImage as File;
                  isAadharImageValid = true;
                });
              } else {
                print('No image selected.');
              }
            })));
  }
}
