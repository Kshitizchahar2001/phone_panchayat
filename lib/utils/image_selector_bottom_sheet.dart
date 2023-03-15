// import 'dart:io';
// import 'dart:async';

// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/fileType.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

// PickedFile imageFile;

class BottomSheetWidget extends StatelessWidget {
  final Function(PickedFile) selectFile;
  final FileType fileType;
  BottomSheetWidget(this.selectFile, {this.fileType = FileType.Image});
  final _picker = ImagePicker();

  void takePhotoByCamera(BuildContext context) async {
    Navigator.pop(context);
    await _picker.getImage(source: ImageSource.camera).then(selectFile);
  }

  void takePhotoByGallery(BuildContext context) async {
    Navigator.pop(context);
    await _picker.getImage(source: ImageSource.gallery).then(selectFile);
  }

  void takeVideoByCamera(BuildContext context) async {
    Navigator.pop(context);
    await _picker.getVideo(source: ImageSource.camera).then(selectFile);
  }

  void takeVideoByGallery(BuildContext context) async {
    Navigator.pop(context);
    await _picker.getVideo(source: ImageSource.gallery).then(selectFile);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      height: context.safePercentHeight * 15,
      width: context.safePercentWidth * 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            fileType == FileType.Video ? "Add video" : ADD_PHOTO,
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: responsiveFontSize(context,
                      size: ResponsiveFontSizes.s10),
                  fontWeight: FontWeight.normal,
                ),
          ).tr(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (fileType == FileType.Video)
                    takeVideoByCamera(context);
                  else
                    takePhotoByCamera(context);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: context.safePercentHeight * 6,
                      color: Theme.of(context).textTheme.headline1.color,
                    ),
                    Text(
                      "Camera",
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s),
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(),
              InkWell(
                onTap: () {
                  if (fileType == FileType.Video)
                    takeVideoByGallery(context);
                  else
                    takePhotoByGallery(context);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.image,
                      size: context.safePercentHeight * 6,
                      color: Theme.of(context).textTheme.headline1.color,
                    ),
                    Text(
                      "Gallery",
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s),
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // CustomButton browseFromDeviceButton(BuildContext context) => CustomButton(
  //       text: 'Browse from device',
  //       buttonColor: Colors.white,
  //       textColor: Colors.black,
  //       onPressed: () {
  //         takePhotoByGallery(context);
  //       },
  //     );
  // CustomButton clickNewPhotoButton(BuildContext context) => CustomButton(
  //       text: 'Click a new photo',
  //       buttonColor: Colors.white,
  //       textColor: Colors.black,
  //       onPressed: () {
  //         takePhotoByCamera(context);
  //       },
  //     );
}
